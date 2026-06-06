# classes5.dex

.class Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    name = "onReceive"
    signature = "(Landroid/content/Context;Landroid/content/Intent;)V"
    value = Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;


# direct methods
.method constructor <init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;)V
    .registers 2

    iput-object p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver$2;->this$1:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 3

    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver$2;->this$1:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

    iget-object v0, v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;->this$0:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->setVisibility(I)V

    return-void
.end method
