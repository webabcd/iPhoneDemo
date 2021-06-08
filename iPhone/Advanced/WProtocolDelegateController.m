//
// 演示 Protocol 的用于 Delegate 的应用
//
// 这部分有点类似于 c# 的事件模型
//

#import "WProtocolDelegateController.h"

@interface WProtocolDelegateController ()

@end

@implementation WProtocolDelegateController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
    
    WProtocolDelegateDemo *delegateDemo = [[WProtocolDelegateDemo alloc] init];
    // self 实现了 WProtocolDelegate 协议
    delegateDemo.myDelegate = self;
    [delegateDemo method];
}

#pragma mark -
#pragma mark WProtocolDelegate
// 实现 WProtocolDelegate 协议。这个会由 WProtocolDelegateDemo 回调
- (void)callback:(WProtocolDelegateDemo *)sender
{
    self.lblMsg.text = [NSString stringWithFormat:@"hello: %@", sender];
}

@end
