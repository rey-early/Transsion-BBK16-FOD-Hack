# classes5.dex

.class public final Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;
.super Landroid/widget/ImageView;
.source "go/retraceme 71bd28d7eab653e1a66f29f78961db819a471c52813d7059e2a7bb83db166fb2"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$Companion;,
        Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;
    }
.end annotation


# static fields
.field private static final ACTION_UPDATE_UI:Ljava/lang/String; = "com.oplus.systemui.osfp.updateui"

.field public static final Companion:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$Companion;

.field private static final TAG:Ljava/lang/String; = "OnScreenFingerprintIcon"


# instance fields
.field private alarmManager:Landroid/app/AlarmManager;

.field public brightnessAlpha:F

.field public logCount:I

.field private final logString:Ljava/lang/StringBuffer;

.field public mFingerKeyReceiver:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

.field public mHbmDummyView:Landroid/view/View;

.field public mHbmSurfaceControl:Landroid/view/SurfaceControl;

.field private final onScreenBrightnessUtils:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils;

.field private onScreenFingerprintUiMech:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;

.field private oplusBiometricAuthController:Lcom/oplus/systemui/biometrics/OplusBiometricAuthController;

.field private parent:Landroid/widget/FrameLayout;

.field public preventionShow:Z

.field public startTime:J

.field private switchAnim:Landroid/animation/Animator;

.field public targetScaleRate:F

.field private uiUpdatePendingIntent:Landroid/app/PendingIntent;

.field private final uiUpdateReceiver:Landroid/content/BroadcastReceiver;

.field private updateMonitor:Lcom/android/keyguard/KeyguardUpdateMonitor;

.field public visibility:I


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 1
    new-instance v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$Companion;

    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 6
    sput-object v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->Companion:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$Companion;

    .line 8
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;Lcom/android/keyguard/KeyguardUpdateMonitor;Lcom/oplus/systemui/biometrics/OplusBiometricAuthController;Landroid/widget/FrameLayout;)V
    .registers 11

    .line 1
    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 4
    new-instance v0, Ljava/lang/StringBuffer;

    .line 6
    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 9
    iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->logString:Ljava/lang/StringBuffer;

    .line 11
    const/4 v0, -0x1

    .line 12
    iput v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    .line 14
    const/high16 v0, 0x3f800000  # 1.0f

    .line 16
    iput v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->targetScaleRate:F

    .line 18
    iput v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    .line 20
    new-instance v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$uiUpdateReceiver$1;

    .line 22
    invoke-direct {v0, p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$uiUpdateReceiver$1;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V

    .line 25
    iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->uiUpdateReceiver:Landroid/content/BroadcastReceiver;

    .line 27
    iput-object p2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->onScreenFingerprintUiMech:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;

    .line 29
    const-string p2, "alarm"

    .line 31
    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    .line 34
    move-result-object p2

    .line 35
    check-cast p2, Landroid/app/AlarmManager;

    .line 37
    iput-object p2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->alarmManager:Landroid/app/AlarmManager;

    .line 39
    new-instance p2, Landroid/content/Intent;

    .line 41
    const-string v1, "com.oplus.systemui.osfp.updateui"

    .line 43
    invoke-direct {p2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 46
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    .line 49
    move-result-object v1

    .line 50
    invoke-virtual {p2, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 53
    new-instance v1, Landroid/content/IntentFilter;

    .line 55
    invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V

    .line 58
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    .line 61
    move-result-object v2

    .line 62
    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 65
    const/4 v2, 0x2

    .line 66
    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    .line 69
    const/4 v0, 0x0

    .line 70
    const/high16 v1, 0x14000000

    .line 72
    invoke-static {p1, v0, p2, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    .line 75
    move-result-object p2

    .line 76
    iput-object p2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->uiUpdatePendingIntent:Landroid/app/PendingIntent;

    .line 78
    sget-object p2, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    .line 80
    invoke-virtual {p0, p2}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 83
    sget-object p2, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils;->Companion:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils$Companion;

    .line 85
    invoke-virtual {p2, p1}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils$Companion;->getInstance(Landroid/content/Context;)Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils;

    .line 88
    move-result-object p2

    .line 89
    iput-object p2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->onScreenBrightnessUtils:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils;

    .line 91
    if-eqz p2, :cond_5f

    .line 93
    invoke-virtual {p2, p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenBrightnessUtils;->setOnScreenFingerprintIcon(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V

    .line 96
    :cond_5f
    iput-object p5, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->parent:Landroid/widget/FrameLayout;

    .line 98
    const/4 p2, 0x0

    .line 99
    invoke-virtual {p0, v0, p2}, Landroid/widget/ImageView;->setLayerType(ILandroid/graphics/Paint;)V

    .line 102
    iput-object p3, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->updateMonitor:Lcom/android/keyguard/KeyguardUpdateMonitor;

    .line 104
    iput-object p4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->oplusBiometricAuthController:Lcom/oplus/systemui/biometrics/OplusBiometricAuthController;

    new-instance v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

    invoke-direct {v0, p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V

    iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFingerKeyReceiver:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V

    const-string v2, "com.rianixia.FINGER_DOWN"

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v2, "com.rianixia.FINGER_UP"

    invoke-virtual {v1, v2}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    move-object v4, p1

    move-object p0, v0

    move-object p1, v1

    const/4 v2, 0x0

    move-object p2, v2

    move-object p3, v2

    const/4 v2, 0x4

    move p4, v2

    invoke-virtual/range {v4 .. v9}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;I)Landroid/content/Intent;

    .line 106
    return-void
.end method

.method public static final synthetic access$getAlarmManager$p(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)Landroid/app/AlarmManager;
    .registers 1

    .line 1
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->alarmManager:Landroid/app/AlarmManager;

    .line 3
    return-object p0
.end method

.method public static final synthetic access$getLogString$p(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)Ljava/lang/StringBuffer;
    .registers 1

    .line 1
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->logString:Ljava/lang/StringBuffer;

    .line 3
    return-object p0
.end method

.method public static final synthetic access$getUiUpdatePendingIntent$p(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)Landroid/app/PendingIntent;
    .registers 1

    .line 1
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->uiUpdatePendingIntent:Landroid/app/PendingIntent;

    .line 3
    return-object p0
.end method

.method public static final access$startSwitchAnim(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V
    .registers 9

    .line 1
    const/4 v0, 0x1

    .line 2
    const/4 v1, 0x0

    .line 3
    const/4 v2, 0x2

    .line 4
    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->stopSwitchAnim()V

    .line 7
    invoke-virtual {p0}, Landroid/widget/ImageView;->getScaleX()F

    .line 10
    move-result v3

    .line 11
    const v4, 0x3f855556

    .line 14
    mul-float/2addr v4, v3

    .line 15
    const v5, 0x3f75c28f  # 0.96f

    .line 18
    mul-float/2addr v5, v3

    .line 19
    iget-boolean v6, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->preventionShow:Z

    .line 21
    if-eqz v6, :cond_17

    .line 23
    move v4, v5

    .line 24
    :cond_17
    iput v4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->targetScaleRate:F

    .line 26
    sget-object v5, Landroid/widget/ImageView;->SCALE_X:Landroid/util/Property;

    .line 28
    new-array v6, v2, [F

    .line 30
    aput v3, v6, v1

    .line 32
    aput v4, v6, v0

    .line 34
    invoke-static {p0, v5, v6}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Landroid/util/Property;[F)Landroid/animation/ObjectAnimator;

    .line 37
    move-result-object v4

    .line 38
    sget-object v5, Landroid/widget/ImageView;->SCALE_Y:Landroid/util/Property;

    .line 40
    iget v6, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->targetScaleRate:F

    .line 42
    new-array v7, v2, [F

    .line 44
    aput v3, v7, v1

    .line 46
    aput v6, v7, v0

    .line 48
    invoke-static {p0, v5, v7}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Landroid/util/Property;[F)Landroid/animation/ObjectAnimator;

    .line 51
    move-result-object v3

    .line 52
    new-instance v5, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$startSwitchAnim$1;

    .line 54
    invoke-direct {v5, p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$startSwitchAnim$1;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V

    .line 57
    invoke-virtual {v4, v5}, Landroid/animation/ObjectAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 60
    new-instance v5, Landroid/animation/AnimatorSet;

    .line 62
    invoke-direct {v5}, Landroid/animation/AnimatorSet;-><init>()V

    .line 65
    new-array v2, v2, [Landroid/animation/Animator;

    .line 67
    aput-object v4, v2, v1

    .line 69
    aput-object v3, v2, v0

    .line 71
    invoke-virtual {v5, v2}, Landroid/animation/AnimatorSet;->playTogether([Landroid/animation/Animator;)V

    .line 74
    const-wide/16 v0, 0x320

    .line 76
    invoke-virtual {v5, v0, v1}, Landroid/animation/AnimatorSet;->setDuration(J)Landroid/animation/AnimatorSet;

    .line 79
    new-instance v0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$startSwitchAnim$2;

    .line 81
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 84
    invoke-virtual {v5, v0}, Landroid/animation/AnimatorSet;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 87
    iput-object v5, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->switchAnim:Landroid/animation/Animator;

    .line 89
    invoke-virtual {v5}, Landroid/animation/Animator;->start()V

    .line 92
    return-void
.end method


# virtual methods
.method public createHbmSurfaceControl()V
    .registers 16

    .line 0
    const-string v12, "OnScreenFingerprintIcon"

    const-string v13, "createHbmSurfaceControl: calling hwcomposer"

    invoke-static {v12, v13}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmSurfaceControl:Landroid/view/SurfaceControl;

    if-eqz v0, :cond_11

    const-string v0, "HBM is already enabled"

    invoke-static {v12, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_11
    invoke-virtual {p0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string/jumbo v0, "window"

    invoke-virtual {v2, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager;

    const/4 v11, 0x2

    new-array v5, v11, [I

    invoke-virtual {p0, v5}, Landroid/widget/ImageView;->getLocationOnScreen([I)V

    const/4 v6, 0x0

    aget v7, v5, v6

    const/4 v6, 0x1

    aget v8, v5, v6

    invoke-virtual {p0}, Landroid/widget/ImageView;->getWidth()I

    move-result v4

    invoke-virtual {p0}, Landroid/widget/ImageView;->getHeight()I

    move-result v9

    new-instance v10, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v10}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput v4, v10, Landroid/view/WindowManager$LayoutParams;->width:I

    iput v9, v10, Landroid/view/WindowManager$LayoutParams;->height:I

    iput v7, v10, Landroid/view/WindowManager$LayoutParams;->x:I

    iput v8, v10, Landroid/view/WindowManager$LayoutParams;->y:I

    const/16 v0, 0x7f7

    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->type:I

    const v0, 0x1080028

    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/4 v0, -0x3

    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->format:I

    const-string v0, "RianixiaHBMController"

    invoke-virtual {v10, v0}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    const/16 v0, 0x33

    iput v0, v10, Landroid/view/WindowManager$LayoutParams;->gravity:I

    new-instance v11, Landroid/view/View;

    invoke-direct {v11, v2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    invoke-virtual {v11, v0}, Landroid/view/View;->setAlpha(F)V

    invoke-interface {v3, v11, v10}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iput-object v11, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmDummyView:Landroid/view/View;

    invoke-virtual {v11}, Landroid/view/View;->getViewRootImpl()Landroid/view/ViewRootImpl;

    move-result-object v0

    if-nez v0, :cond_76

    const-string v1, "ViewRootImpl is null - waiting for attachment"

    invoke-static {v12, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$1;

    invoke-direct {v1, p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$1;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;)V

    invoke-virtual {v11, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_76
    invoke-virtual {v0}, Landroid/view/ViewRootImpl;->getSurfaceControl()Landroid/view/SurfaceControl;

    move-result-object v1

    if-eqz v1, :cond_84

    iput-object v1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmSurfaceControl:Landroid/view/SurfaceControl;

    const-string v2, "Triggered FULL_HBM_SET"

    invoke-static {v12, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_84
    const-string v2, "Failed to get SurfaceControl from ViewRootImpl"

    invoke-static {v12, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-interface {v3, v11}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    return-void
.end method

.method public destroyHbmSurfaceControl()V
    .registers 7

    .line 0
    const-string v0, "OnScreenFingerprintIcon"

    const-string v1, "destroyHbmSurfaceControl: onFingerUp"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmDummyView:Landroid/view/View;

    if-eqz v2, :cond_2c

    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v3

    const-string/jumbo v1, "window"

    invoke-virtual {v3, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager;

    :try_start_18
    invoke-interface {v3, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_1b
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_1b} :catch_1c

    goto :goto_22

    :catch_1c
    move-exception v1

    const-string v3, "Error stopping hbm"

    invoke-static {v0, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_22
    const-string v1, "Removed FULL_HBM_SET"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v4, 0x0

    iput-object v4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmDummyView:Landroid/view/View;

    iput-object v4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmSurfaceControl:Landroid/view/SurfaceControl;

    :cond_2c
    return-void
.end method

.method public final getBrightnessAlpha()F
    .registers 1

    .line 1
    iget p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    .line 3
    return p0
.end method

.method public final getLogStr()Ljava/lang/String;
    .registers 1

    .line 1
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->logString:Ljava/lang/StringBuffer;

    .line 3
    invoke-virtual {p0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    .line 6
    move-result-object p0

    .line 7
    return-object p0
.end method

.method public handleFingerprintKeyPress()V
    .registers 3

    .prologue
    const-string v0, "OnScreenFingerprintIcon"

    const-string v1, "Detected onFingerDown"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "FINGER_DOWN"

    invoke-virtual {p0, v0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->saveLog(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->createHbmSurfaceControl()V

    return-void
.end method

.method public handleFingerprintKeyRelease()V
    .registers 3

    .prologue
    const-string v0, "OnScreenFingerprintIcon"

    const-string v1, "Detected onFingerUp"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "FINGER_UP"

    invoke-virtual {p0, v0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->saveLog(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->destroyHbmSurfaceControl()V

    return-void
.end method

.method public final hasOverlappingRendering()Z
    .registers 1

    .line 1
    const/4 p0, 0x0

    .line 2
    return p0
.end method

.method public final invalidate()V
    .registers 4

    .line 1
    invoke-super {p0}, Landroid/widget/ImageView;->invalidate()V

    .line 4
    invoke-virtual {p0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    .line 7
    move-result-object v0

    .line 8
    invoke-static {v0}, Lcom/oplus/systemui/aod/display/AODDisplayUtil;->getInstance(Landroid/content/Context;)Lcom/oplus/systemui/aod/display/AODDisplayUtil;

    .line 11
    move-result-object v0

    .line 12
    const/4 v1, 0x1

    .line 13
    const/4 v2, 0x3

    .line 14
    invoke-virtual {v0, p0, v2, v1}, Lcom/oplus/systemui/aod/display/AODDisplayUtil;->requestScreenState(Landroid/view/View;IZ)V

    .line 17
    return-void
.end method

.method protected onDetachedFromWindow()V
    .registers 3

    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFingerKeyReceiver:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

    if-eqz v0, :cond_e

    :try_start_4
    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_b
    .catch Ljava/lang/IllegalArgumentException; {:try_start_4 .. :try_end_b} :catch_b

    :catch_b
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mFingerKeyReceiver:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$FingerKeyReceiver;

    :cond_e
    invoke-super {p0}, Landroid/widget/ImageView;->onDetachedFromWindow()V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 2

    .line 1
    const/4 p0, 0x1

    .line 2
    return p0
.end method

.method public onVisibilityChanged(Landroid/view/View;I)V
    .registers 5
    .param p1, "changedView"  # Landroid/view/View;
    .param p2, "visibility"  # I

    .line 1
    invoke-super {p0, p1, p2}, Landroid/widget/ImageView;->onVisibilityChanged(Landroid/view/View;I)V

    .line 4
    if-ne p1, p0, :cond_16

    if-eqz p2, :cond_a

    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->destroyHbmSurfaceControl()V

    .line 6
    :cond_a
    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->onScreenFingerprintUiMech:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;

    .line 8
    if-eqz v0, :cond_16

    .line 10
    if-nez p2, :cond_12

    const/4 v1, 0x1

    goto :goto_13

    :cond_12
    const/4 v1, 0x0

    .line 15
    :goto_13
    invoke-virtual {v0, v1}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;->notifyFpVisibilityChange(Z)V

    .line 18
    :cond_16
    return-void
.end method

.method public final saveLog(Ljava/lang/String;)V
    .registers 5

    .line 1
    sget-object v0, Lcom/oplus/systemui/biometrics/finger/KeyguardFingerprintUtils;->INSTANCE:Lcom/oplus/systemui/biometrics/finger/KeyguardFingerprintUtils;

    .line 3
    invoke-virtual {v0}, Lcom/oplus/systemui/biometrics/finger/KeyguardFingerprintUtils;->getWorkHandler()Landroid/os/Handler;

    .line 6
    move-result-object v0

    .line 7
    if-eqz v0, :cond_11

    .line 9
    new-instance v1, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$saveLog$1;

    .line 11
    const/4 v2, 0x0

    .line 12
    invoke-direct {v1, p0, p1, v2}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$saveLog$1;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;Ljava/lang/Object;I)V

    .line 15
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 18
    :cond_11
    return-void
.end method

.method public final sendFpCmdIfNeed()V
    .registers 6

    .line 1
    const/4 v0, 0x1

    .line 2
    const/4 v1, 0x0

    .line 3
    sget-object v2, Lcom/oplusos/systemui/common/feature/KeyguardFeatureOption;->INSTANCE:Lcom/oplusos/systemui/common/feature/KeyguardFeatureOption;

    .line 5
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 8
    sget-boolean v2, Lcom/oplusos/systemui/common/feature/KeyguardFeatureOption;->isFpBlindUnlockEnabled:Z

    .line 10
    if-nez v2, :cond_c

    .line 12
    goto :goto_44

    .line 13
    :cond_c
    iget-object v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->updateMonitor:Lcom/android/keyguard/KeyguardUpdateMonitor;

    .line 15
    if-eqz v2, :cond_1a

    .line 17
    sget-object v3, Landroid/hardware/biometrics/BiometricSourceType;->FINGERPRINT:Landroid/hardware/biometrics/BiometricSourceType;

    .line 19
    invoke-virtual {v2, v3}, Lcom/android/keyguard/KeyguardUpdateMonitor;->isUnlockingWithBiometricAllowed(Landroid/hardware/biometrics/BiometricSourceType;)Z

    .line 22
    move-result v2

    .line 23
    if-ne v2, v0, :cond_1a

    .line 25
    move v2, v0

    .line 26
    goto :goto_1b

    .line 27
    :cond_1a
    move v2, v1

    .line 28
    :goto_1b
    iget-object v3, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->updateMonitor:Lcom/android/keyguard/KeyguardUpdateMonitor;

    .line 30
    if-eqz v3, :cond_2b

    .line 32
    invoke-virtual {v3}, Lcom/android/keyguard/KeyguardUpdateMonitor;->isFingerprintDetectionRunning()Z

    .line 35
    move-result v3

    .line 36
    if-ne v3, v0, :cond_2b

    .line 38
    iget v3, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    .line 40
    if-eqz v3, :cond_2b

    .line 42
    move v3, v0

    .line 43
    goto :goto_2c

    .line 44
    :cond_2b
    move v3, v1

    .line 45
    :goto_2c
    if-eqz v2, :cond_44

    .line 47
    const-string v2, "hideAodIcon ="

    .line 49
    const-string v4, "OnScreenFingerprintIcon"

    .line 51
    invoke-static {v3, v2, v4}, Landroidx/exifinterface/media/ExifInterface$$ExternalSyntheticOutline0;->m(ILjava/lang/String;Ljava/lang/String;)V

    .line 54
    int-to-byte v2, v3

    .line 55
    new-array v0, v0, [B

    .line 57
    aput-byte v2, v0, v1

    .line 59
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->oplusBiometricAuthController:Lcom/oplus/systemui/biometrics/OplusBiometricAuthController;

    .line 61
    if-eqz p0, :cond_44

    .line 63
    const/4 v1, -0x1

    .line 64
    const/16 v2, 0x3fa

    .line 66
    invoke-virtual {p0, v1, v2, v0}, Lcom/oplus/systemui/biometrics/OplusBiometricAuthController;->sendFingerprintCmd(II[B)V

    .line 69
    :cond_44
    :goto_44
    return-void
.end method

.method public final setBrightnessAlpha(F)V
    .registers 2

    .line 1
    iput p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    .line 3
    return-void
.end method

.method public setHbmSurfaceControl(Landroid/view/SurfaceControl;)V
    .registers 2

    iput-object p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->mHbmSurfaceControl:Landroid/view/SurfaceControl;

    return-void
.end method

.method public final setMaxBrightnessToAlpha(F)V
    .registers 4

    .line 1
    iput p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    .line 3
    new-instance v0, Ljava/lang/StringBuilder;

    .line 5
    const-string v1, "setMaxBrightnessToAlpha: "

    .line 7
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 10
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    .line 13
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 16
    move-result-object v0

    .line 17
    const-string v1, "OnScreenFingerprintIcon"

    .line 19
    invoke-static {v1, v0}, Lcom/oplusos/keyguard/utils/KgdLogUtil;->normal(Ljava/lang/String;Ljava/lang/String;)V

    .line 22
    invoke-virtual {p0, p1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 25
    return-void
.end method

.method public setVisibility(I)V
    .registers 10

    .line 6
    iget v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    const/4 v1, 0x0

    if-eq v0, p1, :cond_e1

    .line 7
    iput p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    if-nez p1, :cond_c

    .line 8
    const-string v0, "VISIBLE"

    goto :goto_e

    :cond_c
    const-string v0, "INVISIBLE"

    .line 9
    :goto_e
    invoke-virtual {p0}, Landroid/widget/ImageView;->getAlpha()F

    move-result v2

    iget v3, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    new-instance v4, Ljava/lang/StringBuilder;

    const-string v5, "setVisibility "

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " ,IconAlpha = "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, "==>"

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 10
    const-string v2, "OnScreenFingerprintIcon"

    invoke-static {v2, v0}, Lcom/oplusos/keyguard/utils/KgdLogUtil;->i(Ljava/lang/String;Ljava/lang/String;)V

    .line 11
    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->uiUpdatePendingIntent:Landroid/app/PendingIntent;

    if-eqz v0, :cond_42

    .line 12
    iget-object v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->alarmManager:Landroid/app/AlarmManager;

    if-eqz v2, :cond_42

    invoke-virtual {v2, v0}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    :cond_42
    const/4 v0, 0x1

    if-nez p1, :cond_6c

    .line 13
    iget-object v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->uiUpdatePendingIntent:Landroid/app/PendingIntent;

    if-eqz v2, :cond_5a

    .line 14
    sget-object v3, Lcom/oplus/systemui/biometrics/finger/KeyguardFingerprintUtils;->INSTANCE:Lcom/oplus/systemui/biometrics/finger/KeyguardFingerprintUtils;

    invoke-virtual {v3}, Lcom/oplus/systemui/biometrics/finger/KeyguardFingerprintUtils;->getWorkHandler()Landroid/os/Handler;

    move-result-object v3

    if-eqz v3, :cond_5a

    new-instance v4, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$saveLog$1;

    const/4 v5, 0x1

    invoke-direct {v4, p0, v2, v5}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon$saveLog$1;-><init>(Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;Ljava/lang/Object;I)V

    invoke-virtual {v3, v4}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 15
    :cond_5a
    iget v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    invoke-virtual {p0, v2}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 16
    invoke-virtual {p0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/oplus/systemui/aod/display/AODDisplayUtil;->getInstance(Landroid/content/Context;)Lcom/oplus/systemui/aod/display/AODDisplayUtil;

    move-result-object v2

    const/4 v3, 0x3

    .line 17
    invoke-virtual {v2, p0, v3, v0}, Lcom/oplus/systemui/aod/display/AODDisplayUtil;->requestScreenState(Landroid/view/View;IZ)V

    goto :goto_7a

    .line 18
    :cond_6c
    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->stopSwitchAnim()V

    .line 19
    invoke-virtual {p0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/oplus/systemui/aod/display/AODDisplayUtil;->getInstance(Landroid/content/Context;)Lcom/oplus/systemui/aod/display/AODDisplayUtil;

    move-result-object v2

    .line 20
    invoke-virtual {v2, p0, v0, v0}, Lcom/oplus/systemui/aod/display/AODDisplayUtil;->requestScreenState(Landroid/view/View;IZ)V

    .line 21
    :goto_7a
    invoke-super {p0, p1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 22
    iget-object v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->parent:Landroid/widget/FrameLayout;

    if-nez v2, :cond_82

    goto :goto_85

    :cond_82
    invoke-virtual {v2, p1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 23
    :goto_85
    invoke-virtual {p0}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->sendFpCmdIfNeed()V

    .line 24
    iget-object p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->onScreenFingerprintUiMech:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;

    if-eqz p1, :cond_93

    invoke-virtual {p1}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;->getScreenTurnedOff()Z

    move-result p1

    if-ne p1, v0, :cond_93

    goto :goto_94

    :cond_93
    move v0, v1

    :goto_94
    const-wide/16 v2, 0x0

    if-nez v0, :cond_b0

    .line 25
    iget-wide v4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    cmp-long p1, v4, v2

    if-eqz p1, :cond_b0

    .line 26
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    sub-long/2addr v4, v6

    .line 27
    iput-wide v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    .line 28
    sget-object p1, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFpStatistic;->INSTANCE:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFpStatistic;

    invoke-virtual {p0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {p1, v6, v4, v5}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFpStatistic;->writeFpScreenOffShowTotalTime(Landroid/content/Context;J)V

    :cond_b0
    if-eqz v0, :cond_ce

    .line 29
    iget-wide v4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    cmp-long p1, v4, v2

    if-eqz p1, :cond_ce

    iget p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    if-eqz p1, :cond_ce

    .line 30
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    iget-wide v6, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    sub-long/2addr v4, v6

    .line 31
    iput-wide v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    .line 32
    sget-object p1, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFpStatistic;->INSTANCE:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFpStatistic;

    invoke-virtual {p0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {p1, v6, v4, v5}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFpStatistic;->writeFpScreenOffShowTotalTime(Landroid/content/Context;J)V

    :cond_ce
    if-eqz v0, :cond_f1

    .line 33
    iget p1, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    if-nez p1, :cond_f1

    iget-wide v4, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    cmp-long p1, v4, v2

    if-nez p1, :cond_f1

    .line 34
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->startTime:J

    goto :goto_f1

    :cond_e1
    if-nez p1, :cond_f1

    .line 35
    invoke-virtual {p0}, Landroid/widget/ImageView;->getAlpha()F

    move-result p1

    iget v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->brightnessAlpha:F

    cmpg-float p1, p1, v0

    if-nez p1, :cond_ee

    goto :goto_f1

    .line 36
    :cond_ee
    invoke-virtual {p0, v0}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 37
    :cond_f1
    :goto_f1
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->onScreenFingerprintUiMech:Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;

    if-eqz p0, :cond_f8

    .line 38
    invoke-virtual {p0, v1}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintUiMech;->updateFpIconAlpha(Z)V

    :cond_f8
    return-void
.end method

.method public final setVisibility(ILjava/lang/String;)V
    .registers 6

    .line 1
    iget v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->visibility:I

    if-eq v0, p1, :cond_24

    if-nez p1, :cond_9

    .line 2
    const-string v0, "VISIBLE"

    goto :goto_b

    :cond_9
    const-string v0, "INVISIBLE"

    .line 3
    :goto_b
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "setVisibility visibilityChanged:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ",reason:"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    .line 4
    invoke-virtual {p0, p2}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->saveLog(Ljava/lang/String;)V

    .line 5
    :cond_24
    invoke-virtual {p0, p1}, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->setVisibility(I)V

    return-void
.end method

.method public final stopSwitchAnim()V
    .registers 2

    .line 1
    iget-object v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->switchAnim:Landroid/animation/Animator;

    .line 3
    if-eqz v0, :cond_1f

    .line 5
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 8
    invoke-virtual {v0}, Landroid/animation/Animator;->isRunning()Z

    .line 11
    move-result v0

    .line 12
    if-eqz v0, :cond_17

    .line 14
    iget v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->targetScaleRate:F

    .line 16
    invoke-virtual {p0, v0}, Landroid/widget/ImageView;->setScaleX(F)V

    .line 19
    iget v0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->targetScaleRate:F

    .line 21
    invoke-virtual {p0, v0}, Landroid/widget/ImageView;->setScaleY(F)V

    .line 24
    :cond_17
    iget-object p0, p0, Lcom/oplus/systemui/biometrics/finger/udfps/OnScreenFingerprintIcon;->switchAnim:Landroid/animation/Animator;

    .line 26
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 29
    invoke-virtual {p0}, Landroid/animation/Animator;->cancel()V

    .line 32
    :cond_1f
    return-void
.end method
