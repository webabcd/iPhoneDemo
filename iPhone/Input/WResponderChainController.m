//
// 演示响应者链的概念
//

#import "WResponderChainController.h"

@interface WResponderChainController ()

@end

@implementation WResponderChainController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // touch 这个自定义 UIView，其就会捕获到 touchesBegan 事件，然后冒泡到此 controller 依然会捕获到 touchesBegan 事件
    WResponderChainDemo *myView = [[WResponderChainDemo alloc] initWithFrame:CGRectMake(0, 200, 320, 50)];
    [self.view addSubview:myView];
    
    self.lblMsg.text = @"touch me";
    self.lblMsg.backgroundColor = [UIColor greenColor];
}

// 点击 WResponderChainDemo 后，WResponderChainDemo 捕获到了 touchesBegan 事件，然后冒泡到此 controller 依然会捕获到 touchesBegan 事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lblMsg.text = [NSString stringWithFormat:@"touchesBegan: %1.2f", event.timestamp];
}

@end
