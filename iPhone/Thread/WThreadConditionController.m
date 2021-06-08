//
// 演示 NSConditionLock, NSCondition 的应用
//
// NSConditionLock - 条件锁，其也实现了 NSLocking 协议。可以做到满足某一条件加锁，以及解锁后将条件设置为某一值，这里所谓的条件是一个整型数字
// NSCondition - 实现了 NSLocking 协议。除了 lock unlock 外，可通过 wait 阻塞，然后收到 signal 后通过
//

#import "WThreadConditionController.h"

@interface WThreadConditionController ()
{
    NSString *_result;
    
    // 用于演示 NSConditionLock 如何使用
    NSConditionLock *_conditionLock;
    
    // 用于演示 NSCondition 如何使用
    NSCondition *_condition;
}

@end

@implementation WThreadConditionController

- (void)viewDidLoad
{
    [super viewDidLoad];
}



// 没有使用任何线程同步处理
- (void)myMethod1Thread1
{
    while (_result.length < 10)
    {
        _result = [_result stringByAppendingString:@"1"];
    }
}
- (void)myMethod1Thread2
{
    while (_result.length < 10)
    {
        _result = [_result stringByAppendingString:@"2"];
    }
}
- (IBAction)btn1Pressed:(id)sender
{
    _result = @"";
    
    [NSThread detachNewThreadSelector:@selector(myMethod1Thread1) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(myMethod1Thread2) toTarget:self withObject:nil];
    
    // 结果很可能是 1111111111
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.lblMsg.text = _result;
        });
    });
}



// 演示如何通过 NSConditionLock 来做线程同步（本例的效果就是：两个线程会交替执行）
- (void)myMethod2Thread1
{
    while (_result.length < 10)
    {
        // 当条件为 1 时加锁（注意：条件不为 1 时会阻塞）
        [_conditionLock lockWhenCondition:1];
        // 尝试加锁
        // [_conditionLock tryLockWhenCondition:1];
        // 加锁，并指定一个加锁的超时时间
        // [_conditionLock lockWhenCondition:<#(NSInteger)#> beforeDate:<#(NSDate *)#>];
        
        _result = [_result stringByAppendingString:@"1"];
        
        // 解锁，并将条件设置为 2
        [_conditionLock unlockWithCondition:2];
    }
}
- (void)myMethod2Thread2
{
    while (_result.length < 10)
    {
        // 当条件为 2 时加锁（注意：条件不为 2 时会阻塞）
        [_conditionLock lockWhenCondition:2];
        
        _result = [_result stringByAppendingString:@"2"];
        
        // 解锁，并将条件设置为 1
        [_conditionLock unlockWithCondition:1];
    }
}
- (IBAction)btn2Pressed:(id)sender
{
    _result = @"";
    // 实例化一个 NSConditionLock，并指定初始条件为 1
    _conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    
    [NSThread detachNewThreadSelector:@selector(myMethod2Thread1) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(myMethod2Thread2) toTarget:self withObject:nil];

    // 结果是 12121212121
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.lblMsg.text = _result;
        });
    });
}



// 演示如何通过 NSCondition 来做线程同步
- (void)myMethod3Thread1
{
    while (_result.length < 10)
    {
        // 加锁
        [_condition lock];
        // 阻塞，收到 signal 后通过
        [_condition wait];
        // wait 时，可以指定超时时间
        // [_condition waitUntilDate:<#(NSDate *)#>];
        
        _result = [_result stringByAppendingString:@"1"];
        
        // 解锁
        [_condition unlock];
    }
}
- (void)myMethod3Thread2
{
    while (_result.length < 10)
    {
        // 加锁
        [_condition lock];
        
        _result = [_result stringByAppendingString:@"2"];
        
        // 发出 signal
        [_condition signal];
        
        // 解锁
        [_condition unlock];
    }
}
- (IBAction)btn3Pressed:(id)sender
{
    _result = @"";
    _condition = [[NSCondition alloc] init];
    
    [NSThread detachNewThreadSelector:@selector(myMethod3Thread1) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(myMethod3Thread2) toTarget:self withObject:nil];
    
    // 结果的可能性很多，可能是 22222122212, 22122212221, 22122221221 ......, 但无论如何肯定是 2 开头的
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^(void)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.lblMsg.text = _result;
        });
    });
}


@end
