//
// 演示 UIActivityViewController 的应用
//
// UIActivityViewController - 用于弹出分享框（注：iPhone 与 iPad 的弹出方式不同）
//

#import "WActivityViewControllerController.h"

@interface WActivityViewControllerController ()

@end

@implementation WActivityViewControllerController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)btnSharePressed:(id)sender
{
    // 构造一个用于分享的数据，可以是文字，可以是url，可以是图片
    NSArray *activityItems = [[NSArray alloc] initWithObjects:@"分享的内容可以是文字，可以是url，可以是图片", @"http://webabcd.cnblogs.com", [UIImage imageNamed:@"Son.png"], nil];
    
    // 实力化 UIActivityViewController，并指定需要分享的数据
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                   initWithActivityItems:activityItems // 需要分享的数据
                                   applicationActivities:nil]; // 除了内置的分享目标之外，可以在这里自定义需要显示在分享列表中的分享目标，自定义的分享目标需要继承 UIActivity

    // 指定不需要出现再分享目标列表中的 app（来自 UIActivityType 枚举）
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint];
    
    // 通过 presentViewController 弹出分享框（iPad 需要用 popover 的方式，详见 iPad demo）
    [self presentViewController:activityViewController animated:YES completion:nil];
    
    // 分享操作结束后的回调 block
    UIActivityViewControllerCompletionHandler myCompletion = ^(NSString *activityType, BOOL completed)
    {
        if (completed)
        {
            // 完成了分享操作
            self.lblMsg.text = @"completed";
            
            // 用户所选取的分享目标
            self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\n%@", activityType];
        }
        else
        {
            // 取消了分享操作
            self.lblMsg.text = @"canceled";
        }
    };
    // 指定分享操作结束后的回调 block
    activityViewController.completionHandler = myCompletion;
    
    

    // 30 秒后自动关闭分享框
    double delayInSeconds = 30.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delayInSeconds);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // 通过 dismissViewControllerAnimated 隐藏分享框
        [self dismissViewControllerAnimated:YES completion:^{
            self.lblMsg.text = @"分享框被隐藏了";
        }];
    });
}

@end
