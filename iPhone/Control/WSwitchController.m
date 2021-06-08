//
// 演示 UISwitch 的应用
//

#import "WSwitchController.h"

@interface WSwitchController ()

@end

@implementation WSwitchController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// 实例化 UISwitch（注：无法指定宽度和高度）
    UISwitch *uiSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(20, 100, 10000, 10000)];
    // 是否是选中状态
    uiSwitch.on = YES;
    
    // 添加一个 target action，用于响应 UIControlEventValueChanged 事件（即选中状态发生变化时所触发的事件）
    [uiSwitch addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:uiSwitch];
}

- (void)myAction:(UISwitch *)uiSwitch
{
    // 获取 UISwitch 的选中状态
    BOOL checked = uiSwitch.on;
    NSString *msg = checked ? @"YES" : @"NO";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];

}

@end
