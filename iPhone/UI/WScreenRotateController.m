//
// 演示如何自动或手动旋转屏幕
//
// 1、首先先要配置 app 可能支持的设备方向（在项目属性 -> General -> Deployment Info -> Device Orientation 中配置或者在 xxx-Info.plist 中配置）
// 2、查看本页代码之前请先看看 WNavigationController.m 中的代码
//

#import "WScreenRotateController.h"

@interface WScreenRotateController ()

@end

@implementation WScreenRotateController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


// ios6 或以上支持屏幕旋转的方式（注意：必须要在 rootViewController 或者 presentModalViewController 中重写才会被执行）
// 本例 rootViewController 会调用当前 controller 的 supportedInterfaceOrientations，从而实现每个 controller 控制自己所支持的设备方向
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


// 手动旋转
- (IBAction)btnRotatePressed:(id)sender
{
    // 推荐用 transform 的方式手动旋转
    // 当然也可以用 [UIDevice currentDevice] 的方式手动旋转（具体实现去网上搜搜吧），不过据说有可能通不过审核
    
    
    // 用 transform 的方式手动旋转 view 的时候，注意别忘了旋转 statusBar
    // [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    
    
    // 还有要想手动旋转的话，就需要禁用自动旋转（参见：WNavigationController.m 中的代码）
    // ios6 - 要让 shouldAutorotate 返回 NO
    // ios5 - 要让 shouldAutorotateToInterfaceOrientation 返回 NO
}

@end
