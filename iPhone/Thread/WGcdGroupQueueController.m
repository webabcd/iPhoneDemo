//
// 演示 group queue
//
// 分组队列用于将 dispatch queue 分组，组内的 dispatch queue 串行执行（先进先执行，执行完一个再执行下一个），不同组并行执行
//

#import "WGcdGroupQueueController.h"

@interface WGcdGroupQueueController ()

@end

@implementation WGcdGroupQueueController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.lblMsg.text = @"";
    self.lblMsg2.text = @"";
    
    dispatch_queue_t serialQueue1 = dispatch_queue_create("com.webabcd.mySerialQueue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t serialQueue2 = dispatch_queue_create("com.webabcd.mySerialQueue2", DISPATCH_QUEUE_SERIAL);

    // dispatch_group_t - 分组队列
    // dispatch_group_create - 创建一个分组队列
    dispatch_group_t group1 = dispatch_group_create();
    dispatch_group_t group2 = dispatch_group_create();
    
    for (int i=0; i<10; i++)
    {
        // 将指定的 block 推入指定的 dispatch queue，然后将此 dispatch queue 归入指定的组
        dispatch_group_async(group1, serialQueue1, ^{
            for (int i=0; i<10; i++)
            {
                [NSThread sleepForTimeInterval:0.1f];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%i,", i];
                });
            }
        });
    }
    
    for (int i=0; i<10; i++)
    {
        // 将指定的 block 推入指定的 dispatch queue，然后将此 dispatch queue 归入指定的组
        dispatch_group_async(group2, serialQueue2, ^{
            for (int i=0; i<10; i++)
            {
                [NSThread sleepForTimeInterval:0.1f];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.lblMsg2.text = [self.lblMsg2.text stringByAppendingFormat:@"%i,", i];
                });
            }
        });
    }
    
    
    // 同步等待 100 秒（阻塞当前线程，等 group 执行完毕或 100 秒超时时间到则停止阻塞）
    // dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 100); // 单位是纳秒，NSEC_PER_SEC 代表 1 秒等于多少纳秒
    // dispatch_group_wait(group1, time);
    // dispatch_group_wait(group2, time);
    
    
    // dispatch_group_notify - 当指定的分组队列执行完毕后，将指定的 block 推入指定的 dispatch queue
    dispatch_group_notify(group1, dispatch_get_main_queue(), ^{
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@", @"执行完毕"];
    });
    dispatch_group_notify(group2, dispatch_get_main_queue(), ^{
        self.lblMsg2.text = [self.lblMsg2.text stringByAppendingFormat:@"%@", @"执行完毕"];
    });
    
    
    // dispatch_release - 释放指定的 dispatch_xxx_t（注意：ios6 和以上版本不再需要手动 release 了）
    // dispatch_release(serialQueue1);
    // dispatch_release(serialQueue2);
    // dispatch_release(group1);
    // dispatch_release(group2);
}

@end
