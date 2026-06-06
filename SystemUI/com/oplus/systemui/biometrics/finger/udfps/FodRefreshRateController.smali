# classes5.dex

# ============================================================
# FodRefreshRateController.smali
# Kelas terpisah untuk mengatur refresh rate saat FOD aktif.
#
# Mekanisme: Settings.System PEAK_REFRESH_RATE + MIN_REFRESH_RATE
# Target: OxygenOS/ColorOS 16, classes5.dex
#
# Cara kerja:
#   - onFodShow() → simpan nilai peak saat ini, set peak=120 & min=120
#   - onFodHide() → restore nilai peak & min sebelumnya
# ============================================================

.class public Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
.super Ljava/lang/Object;
.source "FodRefreshRateController.kt"


# instance fields

# ContentResolver untuk akses Settings.System
.field private final mContentResolver:Landroid/content/ContentResolver;

# Nilai peak_refresh_rate sebelum FOD aktif (untuk restore)
.field private mSavedPeakRefreshRate:F

# Nilai min_refresh_rate sebelum FOD aktif (untuk restore)
.field private mSavedMinRefreshRate:F

# Flag: apakah sedang dalam mode FOD
.field private mFodActive:Z

# Target refresh rate saat FOD (120.0f)
.field private static final FOD_TARGET_RATE:F = 120.0f

# Default fallback jika tidak bisa baca nilai tersimpan
.field private static final DEFAULT_PEAK_RATE:F = 144.0f

.field private static final DEFAULT_MIN_RATE:F = 0.0f

.field private static final TAG:Ljava/lang/String; = "FodRefreshRateController"


# direct methods

.method public constructor <init>(Landroid/content/Context;)V
    .registers 3
    .param p1, "context"    # Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    # mContentResolver = context.getContentResolver()
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mContentResolver:Landroid/content/ContentResolver;

    # mFodActive = false
    const/4 v0, 0x0
    iput-boolean v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mFodActive:Z

    # mSavedPeakRefreshRate = DEFAULT_PEAK_RATE (144.0f)
    const/high16 v0, 0x43100000    # 144.0f
    iput v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mSavedPeakRefreshRate:F

    # mSavedMinRefreshRate = DEFAULT_MIN_RATE (0.0f)
    const/4 v0, 0x0
    iput v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mSavedMinRefreshRate:F

    return-void
.end method


# virtual methods

# ============================================================
# onFodShow() — dipanggil saat FOD icon mulai tampil
# Menyimpan nilai refresh rate saat ini, lalu set ke 120hz
# ============================================================
.method public onFodShow()V
    .registers 6

    # Cek jika sudah aktif, skip (hindari double-save)
    iget-boolean v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mFodActive:Z
    if-nez v0, :already_active

    # Log
    const-string v0, "FodRefreshRateController"
    const-string v1, "onFodShow: saving current refresh rates and limiting to 120Hz"
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mContentResolver:Landroid/content/ContentResolver;

    # --- Baca dan simpan peak_refresh_rate saat ini ---
    const-string v1, "peak_refresh_rate"
    const/high16 v2, 0x43100000    # default 144.0f
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->getFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)F
    move-result v3
    iput v3, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mSavedPeakRefreshRate:F

    # --- Baca dan simpan min_refresh_rate saat ini ---
    const-string v1, "min_refresh_rate"
    const/4 v2, 0x0    # default 0.0f
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->getFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)F
    move-result v3
    iput v3, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mSavedMinRefreshRate:F

    # --- Set peak_refresh_rate = 120.0f ---
    const-string v1, "peak_refresh_rate"
    const/high16 v2, 0x42F00000    # 120.0f
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)Z

    # --- Set min_refresh_rate = 120.0f ---
    const-string v1, "min_refresh_rate"
    const/high16 v2, 0x42F00000    # 120.0f
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$System;->putFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)Z

    # mFodActive = true
    const/4 v0, 0x1
    iput-boolean v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mFodActive:Z

    :already_active
    return-void
.end method


# ============================================================
# onFodHide() — dipanggil saat FOD icon disembunyikan
# Restore nilai refresh rate sebelumnya
# ============================================================
.method public onFodHide()V
    .registers 5

    # Cek jika tidak sedang aktif, skip
    iget-boolean v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mFodActive:Z
    if-eqz v0, :not_active

    # Log
    const-string v0, "FodRefreshRateController"
    const-string v1, "onFodHide: restoring refresh rates"
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mContentResolver:Landroid/content/ContentResolver;

    # --- Restore peak_refresh_rate ---
    iget v1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mSavedPeakRefreshRate:F
    const-string v2, "peak_refresh_rate"
    invoke-static {v0, v2, v1}, Landroid/provider/Settings$System;->putFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)Z

    # --- Restore min_refresh_rate ---
    iget v1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mSavedMinRefreshRate:F
    const-string v2, "min_refresh_rate"
    invoke-static {v0, v2, v1}, Landroid/provider/Settings$System;->putFloat(Landroid/content/ContentResolver;Ljava/lang/String;F)Z

    # mFodActive = false
    const/4 v0, 0x0
    iput-boolean v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mFodActive:Z

    :not_active
    return-void
.end method


# ============================================================
# isActive() — helper cek status
# ============================================================
.method public isActive()Z
    .registers 2

    iget-boolean v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->mFodActive:Z
    return v0
.end method
