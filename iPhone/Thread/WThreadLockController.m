//
// 演示 NSLock @synchronized 的应用
//
// NSLock - NSLock 实现了 NSLocking 协议，NSLocking 协议包括 lock 和 unlock 函数
// @synchronized - @synchronized 简化了 NSLock 的使用
//
//
// 还有一些锁，如：OSAtomic, NSRecursiveLock 等请参看文档
// 关于 NSConditionLock, NSCondition 请参看 WThreadConditionController.m
//

#import "WThreadLockController.h"

@interface WThreadLockController ()
{
    int _count;
    
    // 用于演示 NSLock
    NSLock *_lock;
    
    // 用于演示 @synchronized
    id _lockObj;
}

@end

@implementation WThreadLockController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



// 演示没有锁的情况
- (void)myMethod1
{
    for (int i = 0; i < 1000; i++)
    {
        _count += 1;
    }
}
- (IBAction)btn1Pressed:(id)sender
{
    _count = 0;
    
    for (int i = 0; i < 100; i++)
    {
        [NSThread detachNewThreadSelector:@selector(myMethod1) toTarget:self withObject:nil];
    }
    
    // 假设 1 秒后所有线程都执行完毕，由于并发的影响，结果有可能会小于 100000
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.lblMsg.text = [NSString stringWithFormat:@"%i", _count];
        });
    });

}



// 演示 NSLock 的应用
- (void)myMethod2
{
    for (int i = 0; i < 1000; i++)
    {
        // 加锁
        [_lock lock];
        // 尝试加锁
        // [_lock tryLock];
        // 加锁，并指定一个加锁的超时时间
        // [_lock lockBeforeDate:<#(NSDate *)#>];
        
        _count += 1;
        
        // 解锁
        [_lock unlock];
    }
}
- (IBAction)btn2Pressed:(id)sender
{
    _count = 0;
    _lock = [[NSLock alloc] init];
    
    for (int i = 0; i < 100; i++)
    {
        [NSThread detachNewThreadSelector:@selector(myMethod2) toTarget:self withObject:nil];
    }
    
    // 假设 1 秒后所有线程都执行完毕，虽然会并发，但是由于通过 NSLock 来做线程同步，所以结果肯定是 100000
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.lblMsg.text = [NSString stringWithFormat:@"%i", _count];
        });
    });
}



// 演示 @synchronized 的应用，@synchronized 简化了 NSLock 的使用
- (void)myMethod3
{
    for (int i = 0; i < 1000; i++)
    {
        // 与 lock unlock 效果相同
        @synchronized(_lockObj)
        {
            _count += 1;
        }
    }
}
- (IBAction)btn3Pressed:(id)sender
{
    _count = 0;
    _lockObj = [[NSObject alloc] init];
    
    for (int i = 0; i < 100; i++)
    {
        [NSThread detachNewThreadSelector:@selector(myMethod3) toTarget:self withObject:nil];
    }
    
    // 假设 1 秒后所有线程都执行完毕，虽然会并发，但是由于通过 @synchronized 来做线程同步，所以结果肯定是 100000
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.lblMsg.text = [NSString stringWithFormat:@"%i", _count];
        });
    });
}


@end
