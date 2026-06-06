# Guide: FOD (Fingerprint-on-Display) Patch untuk OxygenOS/ColorOS 16
### Berdasarkan commit `4fead03` — `oplus16_tran_udfps_hack` oleh ryanistr

---

## Daftar Isi
1. [Overview & Tujuan](#1-overview--tujuan)
2. [Cara Kerja Patch](#2-cara-kerja-patch)
3. [Struktur File yang Dimodifikasi](#3-struktur-file-yang-dimodifikasi)
4. [Analisis Smali Per-File](#4-analisis-smali-per-file)
5. [Alur Logika FingerKeyReceiver](#5-alur-logika-fingerkeyreceiver)
6. [Langkah Implementasi](#6-langkah-implementasi)
7. [Catatan Penting & Troubleshooting](#7-catatan-penting--troubleshooting)

---

## 1. Overview & Tujuan

Patch ini bertujuan untuk **mengaktifkan fingerprint under-display (UDFPS/FOD)** pada perangkat OxygenOS/ColorOS 16 yang menggunakan sensor UDFPS transparan, dengan cara menyuntikkan logika custom ke dalam `SystemUI`.

**Masalah yang diselesaikan:**
- Pada OS 16, mekanisme trigger fingerprint dari layar-off tidak berjalan secara native untuk beberapa variant device.
- Ikon FOD tidak muncul / tidak merespons saat layar mati kemudian jari diletakkan.
- Tidak ada bridge antara sinyal hardware fingerprint key (`FINGER_DOWN`/`FINGER_UP`) dengan UI SystemUI.

**Solusinya:** Menyisipkan `BroadcastReceiver` (`FingerKeyReceiver`) ke dalam class `OnScreenFingerprintIcon` yang mendengarkan broadcast custom dari paket terpisah (`com.rianixia.*`), lalu memicu alur autentikasi UI secara manual.

---

## 2. Cara Kerja Patch

```
[Driver/Kernel]
      │
      ▼
[com.rianixia broadcast sender]
      │  Intent: "com.rianixia.FINGER_DOWN"
      │  Intent: "com.rianixia.FINGER_UP"
      ▼
[FingerKeyReceiver (disuntikkan ke OnScreenFingerprintIcon)]
      │
      ├─ FINGER_DOWN + icon visible  ──► handleFingerprintKeyPress() + onFpTouch(true)
      ├─ FINGER_DOWN + icon hidden   ──► (cek screen off) ──► updateOpticalUI() + handleFingerprintKeyPress() + onFpTouch(true)
      └─ FINGER_UP                   ──► handleFingerprintKeyRelease() + onFpTouch(false) + (hide icon jika screen was off)
```

Alur ini membutuhkan **dua sisi**:
1. **Sisi sender** (aplikasi/service terpisah `com.rianixia`) — mengirim broadcast saat finger event terjadi.
2. **Sisi receiver** (patch ini di SystemUI) — menangkap broadcast dan mengendalikan UI FOD.

---

## 3. Struktur File yang Dimodifikasi

Semua file berada di dalam `classes5.dex` dari `SystemUI.apk`, di package:

```
com/oplus/systemui/biometrics/finger/udfps/
```

| File Smali | Deskripsi |
|---|---|
| `OnScreenFingerprintIcon.smali` | Class utama FOD — dimodifikasi untuk mendaftarkan receiver |
| `OnScreenFingerprintIcon$FingerKeyReceiver.smali` | Inner class BroadcastReceiver baru (ditambahkan) |
| `OnScreenFingerprintIcon$FingerKeyReceiver$1.smali` | Anonymous Runnable untuk `FINGER_DOWN` (show HBM surface) |
| `OnScreenFingerprintIcon$FingerKeyReceiver$2.smali` | Anonymous Runnable untuk `FINGER_UP` (hide icon) |
| `OnScreenFingerprintIcon$1.smali` | Runnable existing yang melakukan `setHbmSurfaceControl()` |

> **Target DEX:** `classes5.dex` — bukan `classes.dex` utama. Pastikan kamu melakukan baksmali/apktool pada DEX yang tepat.

---

## 4. Analisis Smali Per-File

### `OnScreenFingerprintIcon$1.smali` — HBM Surface Control Runnable

Runnable ini dieksekusi saat icon FOD perlu menghubungkan dirinya ke surface hardware backlight (HBM = High Brightness Mode untuk AOD fingerprint).

```smali
.method public run()V
    # Ambil mHbmDummyView
    iget-object v1, v0, ...->mHbmDummyView:Landroid/view/View;
    if-nez v1, :cond_7       # lanjut jika view ada
    return-void

    :cond_7
    # Ambil ViewRootImpl dari view
    invoke-virtual {v1}, ...->getViewRootImpl()...
    # Ambil SurfaceControl dari ViewRootImpl
    invoke-virtual {v2}, ...->getSurfaceControl()...
    # Panggil setHbmSurfaceControl(surfaceControl)
    invoke-virtual {p0, v3}, ...->setHbmSurfaceControl(...)V
.end method
```

**Fungsi:** Menghubungkan `SurfaceControl` ke mekanisme HBM agar layar bisa di-brighten saat autentikasi berlangsung.

---

### `OnScreenFingerprintIcon$FingerKeyReceiver$1.smali` — Runnable FINGER_DOWN (show)

Dijalankan via `updateOpticalUI()` saat FINGER_DOWN diterima ketika icon tidak visible:

```smali
.method public run()V
    # Ambil this$1 (FingerKeyReceiver) → lalu this$0 (OnScreenFingerprintIcon)
    iget-object v0, ...->this$1:...FingerKeyReceiver;
    iget-object v0, v0, ...->this$0:...OnScreenFingerprintIcon;

    const/4 v1, 0x0           # VISIBLE = 0
    invoke-virtual {v0, v1}, ...->setVisibility(I)V
.end method
```

**Fungsi:** Membuat icon FOD visible (VISIBLE = 0) di UI thread optical.

---

### `OnScreenFingerprintIcon$FingerKeyReceiver$2.smali` — Runnable FINGER_UP (hide)

Dijalankan via `updateOpticalUI()` saat FINGER_UP diterima setelah layar-off:

```smali
.method public run()V
    iget-object v0, ...->this$1:...FingerKeyReceiver;
    iget-object v0, v0, ...->this$0:...OnScreenFingerprintIcon;

    const/16 v1, 0x8          # GONE = 8
    invoke-virtual {v0, v1}, ...->setVisibility(I)V
.end method
```

**Fungsi:** Menyembunyikan icon FOD (GONE = 8) setelah jari diangkat saat screen-off.

---

### `OnScreenFingerprintIcon$FingerKeyReceiver.smali` — BroadcastReceiver Utama

Ini adalah core dari patch. Kelas ini meng-handle dua broadcast action:

#### Saat `com.rianixia.FINGER_DOWN`:

```
Jika icon NOT visible:
    → Cek apakah screen sedang OFF (via getScreenTurnedOff())
    → Jika ya:
        - Log: "FINGER_DOWN received, icon not visible, screen OFF. Handling."
        - updateOpticalUI(Runnable$1) → set icon VISIBLE
        - handleFingerprintKeyPress()
        - onFpTouch(true)

Jika icon VISIBLE (visibility == 0):
    - Log: "FINGER_DOWN received, icon visible. Handling."
    - handleFingerprintKeyPress()
    - onFpTouch(true)
```

#### Saat `com.rianixia.FINGER_UP`:

```
- Log: "FINGER_UP received. Handling."
- Simpan wasScreenOff = getScreenTurnedOff()
- handleFingerprintKeyRelease()
- onFpTouch(false)

Jika wasScreenOff == true:
    - Log: "FINGER_UP received, screen was off. Hiding icon."
    - updateOpticalUI(Runnable$2) → set icon GONE
```

---

## 5. Alur Logika FingerKeyReceiver

```
onReceive(context, intent)
        │
        ├─ action == "com.rianixia.FINGER_DOWN"?
        │        │
        │        ├─ getVisibility() == 0 (VISIBLE)?
        │        │       └─ YES → handleFingerprintKeyPress() + onFpTouch(true) → return
        │        │
        │        └─ getVisibility() != 0 (GONE/INVISIBLE)?
        │                └─ mech != null && getScreenTurnedOff()?
        │                        └─ YES → updateOpticalUI($1: setVisible)
        │                                 handleFingerprintKeyPress()
        │                                 onFpTouch(true) → return
        │
        └─ action == "com.rianixia.FINGER_UP"?
                 │
                 ├─ wasScreenOff = mech?.getScreenTurnedOff() ?: false
                 ├─ handleFingerprintKeyRelease()
                 ├─ mech?.onFpTouch(false)
                 └─ wasScreenOff? → updateOpticalUI($2: setGone)
```

---

## 6. Langkah Implementasi

### Prasyarat

- `apktool` v2.9+ atau `baksmali`/`smali` standalone
- `zipalign` + `apksigner` (atau `signapk`)
- Root + Magisk / KernelSU di device
- Akses ke `SystemUI.apk` dari ROM OxygenOS/ColorOS 16 yang ditarget
- Aplikasi sender broadcast `com.rianixia.*` (terpisah — tidak termasuk dalam repo ini)

---

### Langkah 1 — Ekstrak SystemUI.apk

```bash
adb pull /system/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk .
# atau
adb pull /system/priv-app/SystemUI/SystemUI.apk .
```

---

### Langkah 2 — Dekompilasi DEX

Karena target adalah `classes5.dex`, gunakan baksmali langsung:

```bash
# Ekstrak classes5.dex dari APK
unzip SystemUI.apk classes5.dex

# Baksmali ke folder smali
baksmali d classes5.dex -o smali_classes5/
```

Atau dengan apktool (akan mendekompilasi semua DEX sekaligus):

```bash
apktool d SystemUI.apk -o SystemUI_decompiled/
# File smali ada di: SystemUI_decompiled/smali_classes5/
```

---

### Langkah 3 — Navigasi ke Package Target

```bash
cd SystemUI_decompiled/smali_classes5/com/oplus/systemui/biometrics/finger/udfps/
```

---

### Langkah 4 — Tambahkan File Smali Baru

Copy 4 file smali baru dari repo ke direktori ini:

```
OnScreenFingerprintIcon$FingerKeyReceiver.smali
OnScreenFingerprintIcon$FingerKeyReceiver$1.smali
OnScreenFingerprintIcon$FingerKeyReceiver$2.smali
OnScreenFingerprintIcon$1.smali  ← (timpa jika sudah ada, atau merge)
```

> ⚠️ **Perhatian pada `OnScreenFingerprintIcon$1.smali`**: Cek terlebih dahulu apakah file ini sudah ada di ROM kamu. Jika sudah ada dan berbeda, lakukan merge manual — jangan langsung timpa.

---

### Langkah 5 — Patch `OnScreenFingerprintIcon.smali` Utama

Ini bagian yang **tidak disertakan secara eksplisit di commit** tapi wajib dilakukan: mendaftarkan `FingerKeyReceiver` di dalam class utama.

Cari section `<init>` atau method yang relevan di `OnScreenFingerprintIcon.smali`, lalu tambahkan:

```smali
# Deklarasikan field receiver di header class
.field private mFingerKeyReceiver:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

# Di dalam constructor atau attach/onAttachedToWindow:
new-instance v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;
invoke-direct {v0, p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V
iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFingerKeyReceiver:...;

# Register receiver dengan IntentFilter
new-instance v1, Landroid/content/IntentFilter;
invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V
const-string v2, "com.rianixia.FINGER_DOWN"
invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V
const-string v2, "com.rianixia.FINGER_UP"
invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V
invoke-virtual {context, v0, v1}, Landroid/content/Context;->registerReceiver(...)V
```

---

### Langkah 6 — Recompile DEX

```bash
# Dengan smali standalone:
smali a smali_classes5/ -o classes5.dex

# Atau dengan apktool:
apktool b SystemUI_decompiled/ -o SystemUI_patched.apk
```

---

### Langkah 7 — Repack & Sign APK

```bash
# Jika manual (tanpa apktool build):
cp SystemUI.apk SystemUI_patched.apk
zip -j SystemUI_patched.apk classes5.dex   # update classes5.dex saja

# Sign dengan debug key (untuk Magisk module):
apksigner sign --ks ~/.android/debug.keystore \
    --ks-pass pass:android \
    --key-alias androiddebugkey \
    SystemUI_patched.apk

# Atau gunakan signapk dengan platform key jika punya
```

---

### Langkah 8 — Deploy via Magisk Module

Buat struktur Magisk module:

```
magisk_module/
├── META-INF/
│   └── com/google/android/
│       ├── update-binary
│       └── updater-script
├── module.prop
└── system/
    └── priv-app/
        └── SystemUI/
            └── SystemUI.apk   ← APK yang sudah dipatch
```

`module.prop`:
```ini
id=fod_patch_os16
name=FOD Patch OxygenOS 16
version=v1
versionCode=1
author=ryanistr
description=UDFPS hack for OPlus OS16 transparent FOD
```

Flash via Magisk Manager atau:
```bash
adb push magisk_module.zip /sdcard/
# Flash dari Magisk app
```

---

## 7. Catatan Penting & Troubleshooting

### Perlu aplikasi sender terpisah

Patch ini hanya sisi **receiver**. Kamu butuh aplikasi atau service terpisah yang men-broadcast:
- `com.rianixia.FINGER_DOWN` — saat finger event terdeteksi
- `com.rianixia.FINGER_UP` — saat jari diangkat

Sender ini biasanya berupa Xposed module atau service yang mendengarkan event input kernel.

### `classes5.dex` bukan `classes.dex`

Jika kamu salah DEX target, patch tidak akan aktif. Verifikasi dengan:
```bash
grep -r "OnScreenFingerprintIcon" SystemUI_decompiled/smali*/
```
Pastikan class ditemukan di `smali_classes5/`.

### Visibility Constants

| Nilai | Konstanta Android |
|---|---|
| `0x0` | `View.VISIBLE` |
| `0x4` | `View.INVISIBLE` |
| `0x8` | `View.GONE` |

### Log Debug

Patch ini menyertakan log debug di `Logcat` dengan tag `OnScreenFingerprintIcon`:
```bash
adb logcat -s OnScreenFingerprintIcon
```

Output yang diharapkan saat finger event:
```
D OnScreenFingerprintIcon: FingerKeyReceiver: FINGER_DOWN received, icon not visible, screen OFF. Handling.
D OnScreenFingerprintIcon: FingerKeyReceiver: FINGER_UP received, screen was off. Hiding icon.
```

### Kompatibilitas

| Kondisi | Status |
|---|---|
| OxygenOS 16 / ColorOS 16 | Target utama |
| `classes5.dex` ada di SystemUI.apk | Required |
| `OnScreenFingerprintUiMech` class ada | Required |
| `setHbmSurfaceControl()` method ada | Required |
| Sensor UDFPS transparan (optical) | Required |

---

*Guide ini dibuat berdasarkan analisis commit `4fead03` dari repo `ryanistr/oplus16_tran_udfps_hack`. Selalu backup ROM sebelum melakukan modifikasi SystemUI.*
