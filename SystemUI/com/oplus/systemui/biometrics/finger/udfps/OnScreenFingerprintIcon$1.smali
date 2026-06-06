# classes5.dex

.class Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;


# direct methods
.method constructor <init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V
    .registers 2

    iput-object p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$1;->this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 5

    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$1;->this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;

    iget-object v1, v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmDummyView:Landroid/view/View;

    if-nez v1, :cond_7

    return-void

    :cond_7
    invoke-virtual {v1}, Landroid/view/View;->getViewRootImpl()Landroid/view/ViewRootImpl;

    move-result-object v2

    if-eqz v2, :cond_18

    invoke-virtual {v2}, Landroid/view/ViewRootImpl;->getSurfaceControl()Landroid/view/SurfaceControl;

    move-result-object v3

    if-eqz v3, :cond_18

    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$1;->this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;

    invoke-virtual {p0, v3}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->setHbmSurfaceControl(Landroid/view/SurfaceControl;)V

    :cond_18
    return-void
.end method
