# Guide: FOD → Auto Limit 120Hz (dari 144Hz)
### Patch tambahan untuk `oplus16_tran_udfps_hack`
### Mencegah HBM glitch saat UDFPS aktif di 144Hz device

---

## Latar Belakang Masalah

Di perangkat OxygenOS/ColorOS 16 dengan layar 144Hz, saat FOD (Fingerprint-on-Display) aktif dan HBM (High Brightness Mode) dinyalakan bersamaan, terjadi glitch visual. Root cause-nya adalah **konflik timing antara HBM brightness burst dan panel scan rate 144Hz** — sensor optical UDFPS butuh interval frame yang lebih panjang untuk membaca pantulan IR dengan benar.

**Solusi:** Saat FOD icon muncul, limit refresh rate ke 120Hz. Saat FOD selesai, restore ke nilai sebelumnya.

---

## Mekanisme yang Dipakai

Dari Android 11+, `DisplayModeDirector` di framework membaca dua key dari `Settings.System`:

| Key | Fungsi |
|---|---|
| `peak_refresh_rate` | Batas atas refresh rate yang diizinkan |
| `min_refresh_rate` | Batas bawah refresh rate |

Dengan set keduanya ke `120.0f`, panel akan lock di 120Hz tanpa perlu akses ke `IDisplayManager` binder yang butuh permission lebih tinggi. SystemUI sudah memiliki akses write ke `Settings.System` secara native.

---

## File yang Dibuat / Dimodifikasi

```
SystemUI/com/oplus/systemui/biometrics/finger/udfps/
├── FodRefreshRateController.smali          ← BARU (kelas controller terpisah)
└── OnScreenFingerprintIcon.smali           ← DIMODIFIKASI (tambah field + call)
```

Opsional (jika hook di receiver lebih mudah):
```
└── OnScreenFingerprintIcon$FingerKeyReceiver.smali  ← ALTERNATIF hook point
```

---

## Langkah Implementasi

### Langkah 1 — Persiapan

Pastikan kamu sudah punya hasil baksmali dari `classes5.dex` sebelumnya (dari patch `4fead03`). Kalau belum:

```bash
unzip SystemUI.apk classes5.dex
baksmali d classes5.dex -o smali_classes5/
```

Navigasi ke direktori target:
```bash
cd smali_classes5/com/oplus/systemui/biometrics/finger/udfps/
```

---

### Langkah 2 — Copy `FodRefreshRateController.smali`

Copy file `FodRefreshRateController.smali` ke direktori ini. File ini adalah kelas baru yang menangani semua logika refresh rate.

Tidak perlu edit file ini kecuali device kamu bukan 144Hz — dalam hal itu ganti konstanta `DEFAULT_PEAK_RATE`:

```smali
# Di FodRefreshRateController.smali, cari:
.field private static final DEFAULT_PEAK_RATE:F = 144.0f
# Ganti 0x43100000 (144.0f) dengan float hex device kamu:
# 165Hz → 0x43250000
# 144Hz → 0x43100000  (default, tidak perlu ganti)
# 120Hz → 0x42F00000
```

**Tabel hex IEEE 754 untuk refresh rate umum:**

| Hz | Hex Float |
|---|---|
| 165.0 | `0x43250000` |
| 144.0 | `0x43100000` |
| 120.0 | `0x42F00000` |
| 90.0  | `0x42B40000` |
| 60.0  | `0x42700000` |

---

### Langkah 3 — Patch `OnScreenFingerprintIcon.smali`

Buka file `OnScreenFingerprintIcon.smali` dengan text editor.

#### 3a. Tambah field

Cari section `# instance fields`, tambahkan field baru di bagian akhirnya:

```smali
.field private mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
```

#### 3b. Inisialisasi di constructor

Cari method `constructor <init>(...)V` di file ini. Lihat berapa banyak register (`.registers N`) dan tentukan register kosong mana yang bisa dipakai.

Sebelum `return-void` di constructor, tambahkan:

```smali
# Cari register context (biasanya p1 atau iget dari mContext field)
# Contoh jika context ada di p1:

new-instance v0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
invoke-direct {v0, p1}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;-><init>(Landroid/content/Context;)V
iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
```

> ⚠️ **Penting:** Cek jumlah register di constructor. Jika semua register sudah terpakai, naikkan `.registers N` menjadi `N+1` atau `N+2`, dan pakai register baru (v[N], v[N+1]) untuk kode di atas.

#### 3c. Hook show (VISIBLE)

Cari di file ini tempat di mana icon dibuat visible. Pola yang dicari:

```smali
const/4 vX, 0x0       # VISIBLE
invoke-virtual {p0, vX}, ...->setVisibility(I)V
```

Atau method `show()` / `onShow()` jika ada. Tambahkan **setelah** baris `setVisibility`:

```smali
iget-object v_ctrl, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
if-eqz v_ctrl, :skip_fod_show
invoke-virtual {v_ctrl}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->onFodShow()V
:skip_fod_show
```

#### 3d. Hook hide (GONE)

Cari tempat icon dibuat GONE. Pola:

```smali
const/16 vX, 0x8      # GONE
invoke-virtual {p0, vX}, ...->setVisibility(I)V
```

Tambahkan **setelah** baris `setVisibility`:

```smali
iget-object v_ctrl, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
if-eqz v_ctrl, :skip_fod_hide
invoke-virtual {v_ctrl}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->onFodHide()V
:skip_fod_hide
```

---

### Langkah 4 — ALTERNATIF: Hook di FingerKeyReceiver (lebih mudah)

Jika susah menemukan hook point di class utama, bisa langsung hook di `FingerKeyReceiver.smali` yang sudah ada dari patch sebelumnya. Ini lebih mudah karena kita tahu persis posisinya.

Buka `OnScreenFingerprintIcon$FingerKeyReceiver.smali`, cari method `onReceive`:

**Setelah** baris `invoke-virtual {v1}, ...->handleFingerprintKeyPress()V` (ada dua tempat):

```smali
# Ambil icon dari this$0
iget-object v_icon, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;->this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;
# Ambil controller dari icon
iget-object v_ctrl, v_icon, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
if-eqz v_ctrl, :skip_rate_show
invoke-virtual {v_ctrl}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->onFodShow()V
:skip_rate_show
```

**Setelah** baris `invoke-virtual {v1}, ...->handleFingerprintKeyRelease()V`:

```smali
iget-object v_icon, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;->this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;
iget-object v_ctrl, v_icon, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
if-eqz v_ctrl, :skip_rate_hide
invoke-virtual {v_ctrl}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->onFodHide()V
:skip_rate_hide
```

> ⚠️ Register `v_icon` dan `v_ctrl` harus tersedia. Cek `.registers N` di method `onReceive` — jika penuh, naikkan nilainya dan pakai register baru.

---

### Langkah 5 — Verifikasi Register

Ini step paling rawan error. Setelah menambahkan kode, pastikan:

1. Tidak ada dua label dengan nama sama di satu method (`:skip_fod_show` harus unik)
2. Register yang dipakai (`v_ctrl`, `v_icon`) tidak bentrok dengan register lain di method yang sama
3. Jumlah `.registers` mencukupi

Cara cek: hitung semua register yang dipakai di method (v0, v1, v2, ... + p0, p1, ...). Nilai `.registers` harus >= jumlah total.

---

### Langkah 6 — Recompile & Deploy

```bash
# Recompile smali ke DEX
smali a smali_classes5/ -o classes5.dex

# Update APK
cp SystemUI.apk SystemUI_patched.apk
zip -j SystemUI_patched.apk classes5.dex

# Sign
apksigner sign --ks ~/.android/debug.keystore \
    --ks-pass pass:android \
    --key-alias androiddebugkey \
    SystemUI_patched.apk

# Push via Magisk module (lihat guide sebelumnya)
```

---

## Verifikasi dengan Logcat

```bash
adb logcat -s FodRefreshRateController
```

Output yang diharapkan:

Saat jari diletakkan:
```
D FodRefreshRateController: onFodShow: saving current refresh rates and limiting to 120Hz
```

Saat jari diangkat:
```
D FodRefreshRateController: onFodHide: restoring refresh rates
```

Verifikasi nilai Settings secara real-time:
```bash
# Terminal 1: monitor perubahan refresh rate setting
watch -n 0.5 "adb shell settings get system peak_refresh_rate && adb shell settings get system min_refresh_rate"

# Terminal 2: trigger FOD
# Letakkan jari → nilai harus berubah ke 120.0
# Angkat jari → nilai harus kembali ke 144.0 (atau nilai asli)
```

---

## Troubleshooting

**Q: Smali gagal compile dengan error "register count too low"**
A: Naikkan `.registers N` di method yang dimodifikasi. Tambah 2 untuk `v_ctrl` dan `v_icon`.

**Q: Nilai tidak berubah setelah jari diletakkan**
A: Cek apakah hook point tepat — mungkin `setVisibility` dipanggil dari tempat lain. Cari semua referensi `VISIBLE` di file smali:
```bash
grep -n "const/4.*0x0" OnScreenFingerprintIcon.smali
```

**Q: HBM glitch masih terjadi**
A: Timing issue — coba hook `onFodShow()` lebih awal, sebelum `updateOpticalUI` dipanggil, bukan setelahnya.

**Q: Device hang / bootloop setelah patch**
A: Kemungkinan crash di constructor karena context null atau register bentrok. Tambahkan null check sebelum `new-instance`:
```smali
if-eqz context_register, :skip_controller_init
# ... inisialisasi controller ...
:skip_controller_init
```

**Q: Refresh rate tidak kembali ke 144Hz setelah unlock berhasil**
A: Pastikan `onFodHide()` terpanggil. Cek apakah ada path di mana icon di-hide tapi tidak melewati hook point kamu (misalnya INVISIBLE = 0x4 bukan GONE = 0x8).

---

## Ringkasan Alur Lengkap Setelah Kedua Patch

```
Jari diletakkan
    ↓
[com.rianixia] broadcast FINGER_DOWN
    ↓
FingerKeyReceiver.onReceive()
    ├─ handleFingerprintKeyPress()
    ├─ onFpTouch(true)
    ├─ updateOpticalUI → setVisibility(VISIBLE)
    └─ FodRefreshRateController.onFodShow()
           ├─ simpan peak=144, min=0
           ├─ set peak_refresh_rate=120
           └─ set min_refresh_rate=120
                    ↓
              [Panel lock 120Hz, HBM aman]

Jari diangkat
    ↓
[com.rianixia] broadcast FINGER_UP
    ↓
FingerKeyReceiver.onReceive()
    ├─ handleFingerprintKeyRelease()
    ├─ onFpTouch(false)
    ├─ updateOpticalUI → setVisibility(GONE)
    └─ FodRefreshRateController.onFodHide()
           ├─ restore peak_refresh_rate=144
           └─ restore min_refresh_rate=0
                    ↓
              [Panel kembali adaptive 144Hz]
```

---

*Patch ini merupakan lanjutan dari commit `4fead03` ryanistr/oplus16_tran_udfps_hack.*
*Selalu backup ROM dan test di device kedua sebelum daily driver.*
