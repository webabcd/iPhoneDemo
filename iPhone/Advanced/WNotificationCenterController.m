//
// 演示 NSNotificationCenter 的应用
//
// NSNotificationCenter 用于在同一程序中的不同对象间进行通信
//

#import "WNotificationCenterController.h"

@interface WNotificationCenterController ()

@end

@implementation WNotificationCenterController

// 从 stroyboard 加载的会通过 initWithCoder 初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // 监听通知
        // 第一个参数：用于监听通知的对象
        // 第二个参数：接收到通知后所执行的函数
        // 第三个参数：通知的名称，只监听此名称的通知
        // 第四个参数：只监听此对象发出的指定名称的通知。如果设置为 nil 则监听所有对象发出的指定名称的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceived:) name:@"mytest" object:nil];
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    // 发送通知
    // 第一个参数：通知的名称
    // 第二个参数：发出通知的对象
    // 第三个参数：通知的信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mytest" object:self userInfo:@{@"key":@"value"}];
}

- (void)onReceived:(NSNotification *)notification
{
    // 获取通知的分类
    NSString *className = [[notification object] description];
    // 获取通知的信息
    NSDictionary *userInfo = [notification userInfo];
    
    self.lblMsg.text = className;
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:(NSString *)[userInfo objectForKey:@"key"]];
}

- (void)dealloc
{
    // 移除此对象的全部通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)description
{
    return @"WNotificationCenterController";
}

@end
