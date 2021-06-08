// 写 [touches anyObject] locationInView:self]



//
// 用于演示 touch 的 UIView
//
// UIResponder 提供如下 4 个 touch 事件：touchesBegan, touchesMoved, touchesEnded, touchesCancelled
//

#import "WMyTouchView.h"

@implementation WMyTouchView

@synthesize lblMsg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 在 UIView 上添加一个 UILabel，用于显示 touch 的相关信息
        self.lblMsg = [[UILabel alloc] initWithFrame:self.bounds];
        self.lblMsg.text = @"multitouch me";
        self.lblMsg.textColor = [UIColor whiteColor];
        self.lblMsg.numberOfLines = 0;
        
        [self addSubview:self.lblMsg];
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

// touch 已经开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showMsg:touches withEvent:event];
}

// touch 移动中
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showMsg:touches withEvent:event];
}

// touch 已经结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showMsg:touches withEvent:event];
}

// touch 被取消，比如有电话打进来的时候
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showMsg:touches withEvent:event];
}

// 显示 touch 事件的相关信息
- (void)showMsg:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lblMsg.text = @"";
    
    // 可以捕获到多点触摸
    for (UITouch *touch in event.allTouches) // 注意：多点触摸的话要用 event.allTouches，而不要用 touches
    {
        // 触摸点相对于 self 的位置
        CGPoint locationInSelf = [touch locationInView:self];
        // 触摸点相对于 window 的位置
        CGPoint locationInWindow = [touch locationInView:nil];
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"phase:%i, locationInSelf:(%1.2f,%1.2f), locationInWindow():(%1.2f,%1.2f)\n", touch.phase, locationInSelf.x, locationInSelf.y, locationInWindow.x, locationInWindow.y];
    }

    // UITouch 说明如下
    //     phase - 当前 touch 所属的阶段，UITouchPhase 枚举：UITouchPhaseBegan, UITouchPhaseMoved, UITouchPhaseEnded, UITouchPhaseCancelled
    //     tapCount - 当前 touch 的的轻触次数，可以判断是否是双击
    //     timestamp - 当前 touch 发生的时间戳（与系统启动时间点的 offset）
    //     view - 当前 touch 所属的 UIView
    //     window - 当前 touch 所属的 UIWindow
    //     locationInView - 当前触摸点的位置
    //     previousLocationInView - 上一个触摸点的位置
    
    // UIEvent 说明如下
    //     allTouches - 全部 UITouch
    //     touchesForView - 属于 UIView 的全部 UITouch
    //     touchesForWindow - 属于 UIWindow 的全部 UITouch
    //     timestamp - 当前事件发生的时间戳（与系统启动时间点的 offset）
    //     type - 事件类型，UIEventType 枚举：UIEventTypeTouches, UIEventTypeMotion（设备的运动，例如 shake）, UIEventTypeRemoteControl（远程控制）,
    //     subtype - 事件的子类型，UIEventSubtype 枚举：UIEventSubtypeNone, UIEventSubtypeMotionShake, 还有一堆远程控制的子类型参看文档吧
}

@end
