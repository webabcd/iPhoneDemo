//
// 演示如何识别和响应手势
//
// 系统内置手势包括：tap, double tap, long press, pan, swipe, pinch, rotation
// 开发自定义手势的话，需要继承 UIGestureRecognizer，并实现其中的 touchesBegan, touchesMoved, touchesEnded, touchesCancelled 函数即可
//

#import "WGestureController.h"

@interface WGestureController ()<UIGestureRecognizerDelegate>

@end

@implementation WGestureController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 新建一个图片，用于演示各种手势操作（UIView 通过 addGestureRecognizer 来绑定相关的手势识别）
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 200, 200, 200)];
    imageView.image = [UIImage imageNamed:@"Son.jpg"];
    // 注意：一定要将 userInteractionEnabled 设置为 YES（默认是 NO），这样 UIImageView 才能识别手势
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    
    // tap 手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    // 触摸点个数
    tap.numberOfTouchesRequired = 1;
    // 点击次数
    tap.numberOfTapsRequired = 1;
    // 对 imageView 增加 tap 的手势识别
    [imageView addGestureRecognizer:tap];

    
    // double tap 手势（通过 UITapGestureRecognizer 实现）
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
    // 点击次数
    doubleTap.numberOfTapsRequired = 2;
    // 对 imageView 增加 double tap 的手势识别
    [imageView addGestureRecognizer:doubleTap];
    // double tap 手势识别失败后，才会尝试将其识别为 tap 手势
    [tap requireGestureRecognizerToFail:doubleTap];
    
    
    // long press 手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    // 触摸点个数
    longPress.numberOfTouchesRequired = 1;
    // 开始 long press 手势识别前的点击次数
    longPress.numberOfTapsRequired = 0;
    // 最小的按住时间，即按住时间超过此时间则识别为 long press 手势
    longPress.minimumPressDuration = 1.0f;
    // 按住后移动，是否仍然可以识别为 long press 手势
    longPress.allowableMovement = false;
    // 对 imageView 增加 long press 的手势识别
    [imageView addGestureRecognizer:longPress];
    
    
    // pan 手势（平移）
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    // 最小触摸点个数
    pan.minimumNumberOfTouches = 1;
    // 最大触摸点个数
    pan.maximumNumberOfTouches = 3;
    // 对 imageView 增加 pan 的手势识别
    [imageView addGestureRecognizer:pan];
    
    
    // swipe 手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    // 识别 swipe 手势的方向 “上下左右”
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    // 触摸点个数
    swipe.numberOfTouchesRequired = 1;
    // 对 imageView 增加 swipe 的手势识别
    [imageView addGestureRecognizer:swipe];
    // swipe 手势识别失败后，才会尝试将其识别为 pan 手势
    [pan requireGestureRecognizerToFail:swipe];

    
    // pinch 手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinch:)];
    // 对 imageView 增加 pinch 的手势识别
    [imageView addGestureRecognizer:pinch];
    // 如何实现同时触发多种手势：需要实现 UIGestureRecognizerDelegate 协议
    pinch.delegate = self;
    
    
    // rotation 手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onRotation:)];
    // 对 imageView 增加 rotation 的手势识别
    [imageView addGestureRecognizer:rotation];
    // 如何实现同时触发多种手势：需要实现 UIGestureRecognizerDelegate 协议
    rotation.delegate = self;
    
    
    
    // 以下来自 UIGestureRecognizer
    // addTarget:action:, removeTarget:action: - 为 target 添加或移除 action
    // locationOfTouch:inView: - 触摸点的位置
    // numberOfTouches - 触摸点的个数（只读）
    // enabled - 是否启用
    // view - 所绑定的 UIView（只读）
    // state - 识别状态（只读）：UIGestureRecognizerStatePossible, UIGestureRecognizerStateBegan, UIGestureRecognizerStateChanged, UIGestureRecognizerStateEnded, UIGestureRecognizerStateCancelled, UIGestureRecognizerStateFailed
    // requireGestureRecognizerToFail: - 如果指定的手势识别失败，再开始尝试识别为本手势
    // cancelsTouchesInView - 是否冒泡（默认值：YES）
    // 关于 UIGestureRecognizer 还有好多其他的 api，请看见文档
}



#pragma mark -
#pragma mark 各种手势识别的 SEL
// tap
- (void)onTap:(UITapGestureRecognizer *)recognizer
{
    // 触摸点相对于 self 的位置
    CGPoint locationInSelf = [recognizer locationInView:recognizer.view];
    // 触摸点相对于 window 的位置
    CGPoint locationInWindow = [recognizer locationInView:nil];

    self.lblMsg.text = [NSString stringWithFormat:@"tap, locationInSelf:(%1.2f,%1.2f), locationInWindow():(%1.2f,%1.2f)\n", locationInSelf.x, locationInSelf.y, locationInWindow.x, locationInWindow.y];
}

// double tap
- (void)onDoubleTap:(UIPanGestureRecognizer *)recognizer
{
    self.lblMsg.text = [NSString stringWithFormat:@"double tap: %1.2f", [NSDate date].timeIntervalSince1970];
}

// long press
- (void)onLongPress:(UILongPressGestureRecognizer *)recognizer
{
    self.lblMsg.text = [NSString stringWithFormat:@"long press: %1.2f", [NSDate date].timeIntervalSince1970];
}

// pan
- (void)onPan:(UIPanGestureRecognizer *)recognizer
{
    self.lblMsg.text = [NSString stringWithFormat:@"pan: %1.2f", [NSDate date].timeIntervalSince1970];
    
    // 跟随 pan 手势移动
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    // 运动速度
    // [recognizer velocityInView:<#(UIView *)#>];
}

// swipe
- (void)onSwipe:(UISwipeGestureRecognizer *)recognizer
{
    NSString *direction = @"";
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionDown:
            direction = @"down";
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            direction = @"left";
            break;
        case UISwipeGestureRecognizerDirectionRight:
            direction = @"right";
            break;
        case UISwipeGestureRecognizerDirectionUp:
            direction = @"up";
            break;
        default:
            break;
    }
    self.lblMsg.text = [NSString stringWithFormat:@"swipe direction: %@", direction];
}

// pinch
- (void)onPinch:(UIPinchGestureRecognizer *)recognizer
{
    self.lblMsg.text = [NSString stringWithFormat:@"pinch: %1.2f", [NSDate date].timeIntervalSince1970];
    
    // 跟随 pinch 手势缩放
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
    // 运动速度
    // [recognizer.velocity];
}

// rotation
- (void)onRotation:(UIRotationGestureRecognizer *)recognizer
{
    self.lblMsg.text = [NSString stringWithFormat:@"rotation: %1.2f", [NSDate date].timeIntervalSince1970];
    
    // 跟随 rotation 手势旋转
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform,  recognizer.rotation);
    recognizer.rotation = 0;
    
    // 运动速度
    // [recognizer.velocity];
}



#pragma mark -
#pragma mark UIGestureRecognizerDelegate
// 如何实现同时触发多种手势：需要实现 UIGestureRecognizerDelegate 协议
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // YES 代表允许同时触发
    // NO 代表不允许同时触发
    return YES;
}

@end
