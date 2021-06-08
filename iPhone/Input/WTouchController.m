//
// 演示 touch 的应用
//

#import "WTouchController.h"

@interface WTouchController ()

@end

@implementation WTouchController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 通过一个自定义的 UIView 演示 touch 相关事件
    WMyTouchView *myTouchView = [[WMyTouchView alloc] initWithFrame:CGRectMake(0, 200, 320, 300)];
    [self.view addSubview:myTouchView];
    
    // 演示 controller 如何响应 touch 相关事件
    self.lblMsg.text = @"touch anywhere";
    self.lblMsg.backgroundColor = [UIColor greenColor];
}

// UIResponder 提供如下 4 个 touch 事件：touchesBegan, touchesMoved, touchesEnded, touchesCancelled（关于这 4 个事件的详细说明参看：WMyTouchView.m）
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lblMsg.text = @"touchesBegan";
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lblMsg.text = @"touchesMoved";
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lblMsg.text = @"touchesEnded";
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lblMsg.text = @"touchesCancelled";
}

@end
