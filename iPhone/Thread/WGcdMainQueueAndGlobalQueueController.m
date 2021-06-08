//
// 演示 main queue 和 global queue
//
// GCD － Grand Central Dispatch，由苹果开发的一套用于简化多线程处理的框架
//
// GCD 中的 FIFO（先进先出）队列被称为 dispatch queue，其会保证先进来的任务先执行，其主要分为以下 3 类
// 1、main dispatch queue － 在主线程（UI 线程）上执行的任务队列，先进来的任务先执行
// 2、global dispatch queue － 并发的全局任务队列，先进来先执行，多个任务并发执行
// 3、private dispatch queue - 私有队列，先进来先执行（队列中的任务可以并发也可以串行）
//
// 关于 GCD 的更多内容还是参看文档吧：https://developer.apple.com/library/ios/documentation/performance/reference/gcd_libdispatch_ref/reference/reference.html
//

#import "WGcdMainQueueAndGlobalQueueController.h"

@interface WGcdMainQueueAndGlobalQueueController ()

@end

@implementation WGcdMainQueueAndGlobalQueueController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)buttonPressed:(id)sender
{
    // dispatch_queue_t - 就是 gcd 中 fifo 队列的类型
    
    // dispatch_get_global_queue - 获取全局队列
    //     第一个参数：四种优先级按从高到低的顺序如下，DISPATCH_QUEUE_PRIORITY_HIGH, DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_PRIORITY_LOW, DISPATCH_QUEUE_PRIORITY_BACKGROUND
    //     第二个参数：占坑用的，都写“0”就好
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // dispatch_async - 将指定的 block 推入指定的 dispatch queue
    dispatch_async(globalQueue, ^{
        
        // 当前线程睡 3 秒
        [NSThread sleepForTimeInterval:3.0f];
        
        NSURL *url = [NSURL URLWithString:@"http://images.cnblogs.com/mvpteam.gif"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        if (image != nil)
        {
            // dispatch_get_main_queue - 获取主线程（UI 线程）队列
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        }
    });
    
    // 注：对于主线程队列和全局队列来说，他们是永远存在的，所以不需要 release
}

@end
