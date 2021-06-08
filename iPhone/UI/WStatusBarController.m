//
// 演示 UIStatusBar 的应用
//
// 注意：UIStatusBar 的高度为 20 像素
//
// 由于 ios7 中 statusBar 是透明的且不占位，所以需要的时候要做 ios6 和 ios7 的 statusBar 的兼容，官方的解决方案如下
// 1、在 show the file inspector 中的 view as 中选择 ios 6.1 and earlier，同时去掉自动布局（代表 ios6 或以下用此布局）
// 2、在 show the size inspector 中的 DeltaY 设置为 20（代表 ios7 布局时，向下偏移 20 个像素）
//

#import "WStatusBarController.h"

@interface WStatusBarController ()

@property (nonatomic) BOOL statusBarHidden;
@property (nonatomic) UIStatusBarStyle statusBarStyle;

@property (weak, nonatomic) IBOutlet UIButton *button1;

@end

@implementation WStatusBarController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.button1.titleLabel.lineBreakMode = 0; // button 上的文字自动换行
    self.button1.titleLabel.textAlignment = NSTextAlignmentCenter; // button 上的文字居中显示
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    // 指定 statusBar 是否可见，ios7 中若让此种方式生效，需要在 info.plist 中设置 UIViewControllerBasedStatusBarAppearance 为 NO（本例中没用这种方式）
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 指定 statusBar 的样式，ios7 中若让此种方式生效，需要在 info.plist 中设置 UIViewControllerBasedStatusBarAppearance 为 NO（本例中没用这种方式）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
    // 如果有 navigationBar 的话，可以通过修改其样式来达到改变 statusBar 样式的目的（因为在 ios7 以上，statusBar 是透明的，所以如果想改变它的背景色的话，也可以在顶部 20 像素放一个自定义的 UIView）
    // self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    // 这里如果是 UIBarStyleDefault 则 statusBar 强制为 UIStatusBarStyleDefault, 这里如果是 UIBarStyleBlack 则 statusBar 强制为 UIStatusBarStyleLightContent
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // 注意：如果指定了 navigationBar 的背景图，则 statusBar 是 UIStatusBarStyleDefault 还是 UIStatusBarStyleLightContent 也是由上面的 navigationBar.barStyle 决定
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Son.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 如果想自己控制 statusBar 是 UIStatusBarStyleDefault 还是 UIStatusBarStyleLightContent 的话，则要隐藏 navigationBar
    self.navigationController.navigationBarHidden = YES;
}

// 在 ios7 中指定 statusBar 是否可见
- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden = !self.statusBarHidden;
}

// 在 ios7 中指定 statusBar 的样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (!self.statusBarHidden)
    {
        if (self.statusBarStyle == UIStatusBarStyleDefault)
            return self.statusBarStyle = UIStatusBarStyleLightContent; // light 内容, 透明背景
        else
            return self.statusBarStyle = UIStatusBarStyleDefault; // dark 内容，透明背景
    }
    else
    {
        return self.statusBarStyle;
    }
}

// 在 ios7 中指定显示/隐藏 statusBar 时的动画方式
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
    // UIStatusBarAnimationNone
    // UIStatusBarAnimationFade
}

// ios7, 默认返回 nil, 如果返回了一个 UIViewController 则执行这个 UIViewController 的 preferredStatusBarStyle, 而不再执行当前 controller 的 preferredStatusBarStyle
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return nil;
}

// ios7, 默认返回 nil, 如果返回了一个 UIViewController 则执行这个 UIViewController 的 prefersStatusBarHidden, 而不再执行当前 controller 的 prefersStatusBarHidden
- (UIViewController *)childViewControllerForStatusBarHidden
{
    return nil;
}


// 在 ios7 中显示/隐藏 UIStatusBar，每次显示时改变 UIStatusBarStyle
- (IBAction)button1Pressed:(id)sender
{
    // 需要显示/隐藏 statusBar 时有动画效果，就这么写
    [UIView animateWithDuration:1.0 animations:^ // 可以控制动画时间
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }];

    // 不需要显示/隐藏 statusBar 时有动画效果，就这么写（如果想在 controller 运行期间设置 statusBar 的可见性和样式的话，则需要先调用 setNeedsStatusBarAppearanceUpdate）
    // [self setNeedsStatusBarAppearanceUpdate];
}


// 几点注意：
// 1、ios7 的 info.plist 中新增了键值 UIViewControllerBasedStatusBarAppearance，其默认值为 YES
// 2、ios6 及以下用 setStatusBarHidden 和 setStatusBarStyle 的方式设置 statusBar 的可见性和样式
// 3、ios7 中如果要通过 setStatusBarHidden 和 setStatusBarStyle 的方式设置 statusBar 的可见性和样式，需要将 UIViewControllerBasedStatusBarAppearance 设置为 NO
// 4、ios7 中建议用 prefersStatusBarHidden 和 preferredStatusBarStyle 的方式设置 statusBar 的可见性和样式，需要将 UIViewControllerBasedStatusBarAppearance 设置为 YES（不指定这个键值也可以，其默认为 YES）
// 5、ios7 的默认方式中，每次 controller 加载都会执行 prefersStatusBarHidden 和 preferredStatusBarStyle，如果想在 controller 运行期间设置 statusBar 的可见性和样式的话，则需要先调用 setNeedsStatusBarAppearanceUpdate，然后 controller 就会执行 prefersStatusBarHidden 和 preferredStatusBarStyle 了


// info.plist 中与 statusBar 相关的配置及说明如下：
// 1、UIViewControllerBasedStatusBarAppearance（View controller-based status bar appearance） - ios7 新增，默认值为 YES，说明见上面
// 2、Status bar style - UIStatusBarStyleDefault 或 UIStatusBarStyleLightContent
// 3、Status bar is initially hidden - YES 或 NO
// 4、UIStatusBarHidden~ipad - ipad 的 Status bar is initially hidden

@end
