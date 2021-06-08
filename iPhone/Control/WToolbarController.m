//
// 演示 UIToolbar UIBarButtonItem UIBarButtonSystemItemFlexibleSpace UIBarButtonSystemItemFixedSpace 的应用
//
// 关于 UINavigationBar UINavigationItem 之类的参见：Controller/WNavigationControllerController.m
//

#import "WToolbarController.h"

@interface WToolbarController ()

@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation WToolbarController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 实例化一个 UIToolbar，并添加进来
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 44)];
    self.toolBar.backgroundColor = [UIColor redColor];
    
    // 设置工具栏上的按钮（关于创建内置按钮，自定义按钮参见上面的代码即可）
    UIBarButtonItem *barButton1 = [[UIBarButtonItem alloc] initWithTitle:@"文本1" style:UIBarButtonItemStylePlain target:self action:@selector(barButton1Pressed:)];
    
    // UIBarButtonSystemItemFlexibleSpace - Flexible Space Bar Button Item（自适应分隔符）
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // UIBarButtonSystemItemFixedSpace - Fixed Space Bar Button Item（固定宽度分隔符）
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 100.0f;
    
    // UIBarButtonItem 的样式来自 UIBarButtonSystemItem 枚举
    //     UIBarButtonSystemItemAdd - 内置加号按钮
    //     更多内置按钮的说明及样式参见：https://developer.apple.com/library/ios/documentation/uikit/reference/UIBarButtonItem_Class/Reference/Reference.html
    UIBarButtonItem *barButton2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButton2Pressed:)];
    
    // 设置工具栏的 UIBarButtonItem 们
    [self.toolBar setItems:@[barButton1, flexibleSpace, barButton2]];


    // 将 UIToolbar 添加进来
    [self.view addSubview:self.toolBar];
    
    // 获取 UIToolbar 的宽度
    int height = self.toolBar.bounds.size.height;
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
