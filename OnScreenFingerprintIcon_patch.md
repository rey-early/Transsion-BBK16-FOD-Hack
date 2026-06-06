# ============================================================
# PATCH DIFF — OnScreenFingerprintIcon.smali
# Integrasi FodRefreshRateController ke class utama FOD
#
# Terapkan perubahan ini ke OnScreenFingerprintIcon.smali
# yang sudah kamu baksmali dari classes5.dex
# ============================================================


# ─────────────────────────────────────────────
# [1] TAMBAH FIELD di bagian "# instance fields"
# Cari baris terakhir di section instance fields, tambahkan setelahnya:
# ─────────────────────────────────────────────

.field private mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;


# ─────────────────────────────────────────────
# [2] INISIALISASI di constructor / init method
# Cari constructor <init>(...) di OnScreenFingerprintIcon.smali
# Sebelum "return-void" di constructor, tambahkan:
# ─────────────────────────────────────────────

# new-instance mFodRateController
new-instance v_tmp, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
invoke-direct {v_tmp, context_register}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;-><init>(Landroid/content/Context;)V
iput-object v_tmp, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;

# CATATAN: Ganti "v_tmp" dan "context_register" dengan register
# yang tersedia di constructor kamu. Cek ".registers N" di constructor
# untuk tahu berapa register yang tersedia. Tambah jika perlu.
# Context biasanya ada di parameter p1 atau bisa di-iget dari field mContext.


# ─────────────────────────────────────────────
# [3] PANGGIL onFodShow() di setVisibility(VISIBLE)
# Cari method setVisibility(I)V atau show() di OnScreenFingerprintIcon.smali
# Atau cari tempat di mana icon di-set VISIBLE (const/4 v, 0x0 + setVisibility)
# Tambahkan SEBELUM atau SETELAH super.setVisibility():
# ─────────────────────────────────────────────

# Pola yang dicari di smali (visibility == VISIBLE = 0):
#   const/4 vX, 0x0
#   invoke-virtual {p0, vX}, ...->setVisibility(I)V
#
# Tambahkan ini SETELAH baris setVisibility VISIBLE:

iget-object v_ctrl, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
if-eqz v_ctrl, :skip_show
invoke-virtual {v_ctrl}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->onFodShow()V
:skip_show


# ─────────────────────────────────────────────
# [4] PANGGIL onFodHide() di setVisibility(GONE)
# Cari tempat di mana icon di-set GONE (const/16 v, 0x8 + setVisibility)
# Tambahkan SETELAH baris setVisibility GONE:
# ─────────────────────────────────────────────

# Pola yang dicari (visibility == GONE = 8):
#   const/16 vX, 0x8
#   invoke-virtual {p0, vX}, ...->setVisibility(I)V
#
# Tambahkan ini SETELAH baris setVisibility GONE:

iget-object v_ctrl, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFodRateController:Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;
if-eqz v_ctrl, :skip_hide
invoke-virtual {v_ctrl}, Lcom/oplus/systemui/biometrics/finger/udfps/FodRefreshRateController;->onFodHide()V
:skip_hide


# ─────────────────────────────────────────────
# [5] ALTERNATIF: Hook di FingerKeyReceiver
# Jika lebih mudah hook di FingerKeyReceiver.smali
# yang sudah ada dari patch sebelumnya:
# ─────────────────────────────────────────────

# Di FingerKeyReceiver.onReceive():
# Setelah blok FINGER_DOWN → handleFingerprintKeyPress(), tambahkan:
#
#   iget-object v_icon, v1, ...OnScreenFingerprintIcon$FingerKeyReceiver;->this$0:...OnScreenFingerprintIcon;
#   iget-object v_ctrl, v_icon, ...OnScreenFingerprintIcon;->mFodRateController:...FodRefreshRateController;
#   if-eqz v_ctrl, :skip_rate_show
#   invoke-virtual {v_ctrl}, ...FodRefreshRateController;->onFodShow()V
#   :skip_rate_show
#
# Setelah blok FINGER_UP → handleFingerprintKeyRelease(), tambahkan:
#
#   iget-object v_icon, v1, ...OnScreenFingerprintIcon$FingerKeyReceiver;->this$0:...OnScreenFingerprintIcon;
#   iget-object v_ctrl, v_icon, ...OnScreenFingerprintIcon;->mFodRateController:...FodRefreshRateController;
#   if-eqz v_ctrl, :skip_rate_hide
#   invoke-virtual {v_ctrl}, ...FodRefreshRateController;->onFodHide()V
#   :skip_rate_hide
