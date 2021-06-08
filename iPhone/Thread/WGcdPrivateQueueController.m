//
// 演示 private queue
//
// 支持并发执行：先进来先执行，并发执行
// 支持串行执行：先进来先执行，前一个任务执行完毕后一个任务才能开始执行
//

#import "WGcdPrivateQueueController.h"

@interface WGcdPrivateQueueController ()

@end

@implementation WGcdPrivateQueueController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 演示私有队列的串行执行
    [self serialQueueDemo];
    
    // 演示私有队列的并发执行
    [self concurrentQueueDemo];
}

- (void)serialQueueDemo
{
    self.lblMsg.text = @"";
    
    // dispatch_queue_create - 创建一个私有队列
    //     第一个参数：一个无意义标识，主要用于调试时或错误汇报时让你知道是哪个队列报的错误
    //     第二个参数：DISPATCH_QUEUE_SERIAL - 串行队列（NULL 的话默认为串行队列）；DISPATCH_QUEUE_CONCURRENT - 并发队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.webabcd.mySerialQueue", DISPATCH_QUEUE_SERIAL);
    
    for (int i=0; i<10; i++)
    {
        // dispatch_async - 将指定的 block 推入指定的 dispatch queue
        dispatch_async(serialQueue, ^{
            for (int i=0; i<10; i++)
            {
                [NSThread sleepForTimeInterval:0.1f];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%i", i); // 当此线程没有执行完之前，你离开此页了，此线程中的内容也会依然继续执行，值到执行完毕（不知道该怎么取消）
                    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%i,", i];
                });
            }
        });
        
        // dispatch_release - 释放指定的 dispatch_xxx_t（注意：ios6 和以上版本不再需要手动 release 了）
        // dispatch_release(serialQueue);
    }
}

- (void)concurrentQueueDemo
{
    self.lblMsg2.text = @"";
   
    // dispatch_queue_create - 创建一个私有队列
    //     第一个参数：一个无意义标识，主要用于调试时或错误汇报时让你知道是哪个队列报的错误
    //     第二个参数：DISPATCH_QUEUE_SERIAL - 串行队列（NULL 的话默认为串行队列）；DISPATCH_QUEUE_CONCURRENT - 并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.webabcd.myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i=0; i<10; i++)
    {
        // dispatch_async - 将指定的 block 推入指定的 dispatch queue
        dispatch_async(concurrentQueue, ^{
            for (int i=0; i<10; i++)
            {
                [NSThread sleepForTimeInterval:0.1f];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lblMsg2.text = [self.lblMsg2.text stringByAppendingFormat:@"%i,", i];
                });
            }
        });
    
        // dispatch_release - 释放指定的 dispatch_xxx_t（注意：ios6 和以上版本不再需要手动 release 了）
        // dispatch_release(concurrentQueue);
    }
}

@end
