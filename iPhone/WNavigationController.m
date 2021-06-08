//
// 我是此 app 的 rootViewController 的一个 subclass
//

#import "WNavigationController.h"

@interface WNavigationController ()

@end

@implementation WNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



#pragma mark -
#pragma mark ios6 或以上支持屏幕旋转的方式
// 注意：必须要在 rootViewController 或者 presentModalViewController 中重写才会被执行
// 是否需要支持自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持的旋转方向（注意：ios6 或以上的枚举是 UIInterfaceOrientationMask 类型）
- (NSUInteger)supportedInterfaceOrientations
{
    // 本 rootViewController 之内的所有 controller 均使用此配置
    // return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    
    
    // 如果要每个 controller 控制自己的 supportedInterfaceOrientations 怎么办？
    // 就像这样返回当前 controller 的 supportedInterfaceOrientations 即可（请参看 UI/WScreenRotateController.m）
    return self.topViewController.supportedInterfaceOrientations;
}

/* 可以指定首选方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
*/


#pragma mark -
#pragma mark ios5 或以下支持屏幕旋转的方式
// 设备准备旋转前，告诉它到底可不可以旋转（注意：ios5 或以下的枚举是 UIInterfaceOrientation 类型）
// 在哪个 controller 写都可以
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        return YES;
    return NO;
}



#pragma mark -
#pragma mark 关于设备旋转的一些辅助方法，ios5或以上都是支持的
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"将要旋转");
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"旋转动画将要开始");
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"旋转结束");
}

@end
