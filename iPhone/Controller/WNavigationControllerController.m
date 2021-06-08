//
// 演示 NavigationController 的应用
//
// 一同介绍的还有 NavigationBar（导航栏），ToolBar（工具栏），BarButtonItem（导航栏或工具栏上的按钮）
// Flexible Space Bar Button Item - 自适应分隔符
// Fixed Space Bar Button Item - 固定宽度分隔符
//
//
// 本例为导航的二级，一级见 WIndexController.m（其是通过 IB 实现，通过 WAppDelegate.m 如何实现可以在网上找）
// 不通过 IB 也不通过 WAppDelegate.m 创建 NavigationController 可以看考 WTabBarControllerController.m 中的实现方式
//

#import "WNavigationControllerController.h"

@interface WNavigationControllerController ()

@end

@implementation WNavigationControllerController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // 设置导航栏的左侧按钮（不指定的话，默认是上一级导航栏的 title）
    //     样式有：UIBarButtonItemStylePlain, UIBarButtonItemStyleBordered, UIBarButtonItemStyleDone，但是在 ios7 中没有差别
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"文本" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    // 设置导航栏的右侧按钮
    // UIBarButtonItem 的样式来自 UIBarButtonSystemItem 枚举
    //     UIBarButtonSystemItemAdd - 内置加号按钮
    //     更多内置按钮的说明及样式参见：https://developer.apple.com/library/ios/documentation/uikit/reference/UIBarButtonItem_Class/Reference/Reference.html
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    // 自定义 UIBarButtonItem
    // [[UIBarButtonItem alloc] initWithCustomView:<#(UIView *)#>];
    
    
    // 设置导航栏的 title
    // self.navigationItem.title = @"title";
    
    
    // 自定义导航栏的 title
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Son.png"]];
    imageView.frame = CGRectMake(0, 0, 20, 20);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imageView;
    
    
    // 显示工具栏（默认是隐藏的）
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    
    // 设置工具栏上的按钮（关于创建内置按钮，自定义按钮参见上面的代码即可）
    UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithTitle:@"文本1" style:UIBarButtonItemStylePlain target:self action:@selector(barButton1Pressed:)];
    
    // UIBarButtonSystemItemFlexibleSpace - Flexible Space Bar Button Item（自适应分隔符）
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // UIBarButtonSystemItemFixedSpace - Fixed Space Bar Button Item（固定宽度分隔符）
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 100.0f;
    
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithTitle:@"文本2" style:UIBarButtonItemStylePlain target:self action:@selector(barButton2Pressed:)];
    
    // 设置工具栏的 UIBarButtonItem 们
    [self setToolbarItems:@[barButton1, flexibleSpace, barButton2]];
    
    
    // 如何创建 NavigationController: 直接将 Navigation Controller 拖进来即可
    // 如果需要自己创建 NavigationController 则通过 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:<#(UIViewController *)#>]; 然后 [self.view addSubview:self.navigationController.view]; 即可
    
    
    // 获取 UINavigationBar 的高度
    int height = self.navigationController.navigationBar.bounds.size.height;
    
    // 设置 UINavigationBar 的背景色
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}

- (void)rightButtonPressed:(id)sender
{
    self.lblMsg.text = @"navigation bar 的右侧按钮被单击了";
}

- (void)leftButtonPressed:(id)sender
{
    // 隐藏工具栏，并 pop viewController（即返回）
    self.navigationController.toolbarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)barButton1Pressed:(id)sender
{
    self.lblMsg.text = @"tool bar 的第一个按钮被单击了";
}

- (void)barButton2Pressed:(id)sender
{
    self.lblMsg.text = @"tool bar 的第二个按钮被单击了";
}

@end
