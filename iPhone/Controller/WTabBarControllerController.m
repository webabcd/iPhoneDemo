//
// 演示 TabBarController 的应用
//
// UITabBar - 标签栏
// 最多 5 个 tab，超过了 5 个的话，第 5 个会以 more 的形式出现
//
// 注：UITabBarController 内部的每个 Controller 的所对应的 UITabBarItem 是在此 Controller 中定义的
//

#import "WTabBarControllerController.h"
#import "WTabBarController1Controller.h"
#import "WTabBarController2Controller.h"

@interface WTabBarControllerController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) WTabBarController1Controller *tabBarController1;
@property (nonatomic, strong) WTabBarController2Controller *tabBarController2;
@property (nonatomic, strong) WTabBarController1Controller *tabBarController3;
@property (nonatomic, strong) WTabBarController2Controller *tabBarController4;
@property (nonatomic, strong) WTabBarController1Controller *tabBarController5;
@property (nonatomic, strong) WTabBarController2Controller *tabBarController6;

@end

@implementation WTabBarControllerController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // 实例化 UITabBarController
    self.tabBarController = [[UITabBarController alloc] init];
    // 设置 UITabBarController 的背景
    self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"C.png"];
    self.tabBarController.delegate = self;


    // 实例化 UITabBarController 中的内容，本例是 6 个 Controller
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Controller" bundle:nil];
    self.tabBarController1 = [s instantiateViewControllerWithIdentifier:@"TabBarController1"];
    self.tabBarController2 = [s instantiateViewControllerWithIdentifier:@"TabBarController2"];
    self.tabBarController3 = [s instantiateViewControllerWithIdentifier:@"TabBarController1"];
    self.tabBarController4 = [s instantiateViewControllerWithIdentifier:@"TabBarController2"];
    self.tabBarController5 = [s instantiateViewControllerWithIdentifier:@"TabBarController1"];
    self.tabBarController6 = [s instantiateViewControllerWithIdentifier:@"TabBarController2"];
    
    
    // 指定 UITabBarController 中所包括的全部 Controller
    self.tabBarController.viewControllers = @[self.tabBarController1, self.tabBarController2, self.tabBarController3, self.tabBarController4, self.tabBarController5, self.tabBarController6];
    

    // 获取 UITabBar 中的指定的 UITabBarItem（UITabBarItem 的定义在对应的 Controller 中）
    // UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:0];

    
    // more 按钮所对应的 NavigationController（只读）
    // self.tabBarController.moreNavigationController;
    
    
    // 指定选中的 UITabBarItem
    [self.tabBarController setSelectedIndex:1];
    
    
    // 将我们自己创建的 UITabBarController 的 view 添加进当前的 view
    [self.view addSubview:self.tabBarController.view];
    
    // 获取 UITabBar 的高度
    int height = self.tabBarController.tabBar.bounds.size.height;
}


#pragma mark -
#pragma mark UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 跳转到某个 tab 后
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // 用户点击某个 tab 后，是否要选中这个 tab
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    // 点击了 more，然后点击右上角 edit（ios7 没有 edit）
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    // 点击了 more，然后点击右上角 edit（ios7 没有 edit）
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    // 点击了 more，然后点击右上角 edit（ios7 没有 edit）
}


// 首选方向 ios7
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController
{
    return UIInterfaceOrientationPortrait;
}

// 支持的方向 ios7
- (NSUInteger)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController
{
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationPortraitUpsideDown | UIDeviceOrientationLandscapeRight | UIInterfaceOrientationLandscapeRight;
}

@end
