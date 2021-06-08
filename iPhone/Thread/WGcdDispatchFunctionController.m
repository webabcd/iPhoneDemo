//
// 各种 dispatch 的说明
//
// 关于 GCD 的更多内容还是参看文档吧：https://developer.apple.com/library/ios/documentation/performance/reference/gcd_libdispatch_ref/reference/reference.html
//





// 为啥没写 dispatch_sync 呢?







#import "WGcdDispatchFunctionController.h"

@interface WGcdDispatchFunctionController ()

@end

@implementation WGcdDispatchFunctionController

static dispatch_once_t onceToken;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.lblMsg.text = @"各种 dispatch 函数请看代码注释";
    
    // 1、dispatch_set_target_queue - 指定私有队列的优先级
    dispatch_queue_t serialQueue = dispatch_queue_create("com.webabcd.mySerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    // 将 serialQueue 的优先级设置为 DISPATCH_QUEUE_PRIORITY_HIGH
    dispatch_set_target_queue(serialQueue, globalQueue);
    
    
    
    // 2、dispatch_once - 单例模式，保证整个 app 的生命周期内只执行一次
    dispatch_once(&onceToken, ^{
        // 保证在整个应用程序周期内只执行一次
    });
    
    
    
    // 3、dispatch_after - 延迟执行
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delayInSeconds);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // 2 秒后执行
    });
    
    
    
    // 4、执行 n 次（经测试，不能在 main queue 中执行，否则 ui 线程会阻塞）
    dispatch_apply(10, serialQueue, ^(size_t index) {
        // 此处代码执行 10 次
    });
    
    
    
    // 5、barrier － 屏障（所有参与者都到达屏障后，屏障解除）
    /*
    dispatch_async(concurrentQueue, block1);
    dispatch_async(concurrentQueue, block2);
    dispatch_barrier_async(concurrentQueue, ^{
        // concurrentQueue 队列要等着 block1 和 block2 执行完毕，才会执行到这里，然后后续任务才能执行（比如 block3 之类的）
    });
    dispatch_async(concurrentQueue, block3);
    */
    
    
    
    // 6、semaphore - 信号量（按许可证中心理解，许可证有限，拿到许可证的可以执行，执行完毕后归还许可证）
    /*
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(100); // 许可证中心一共有 100 个许可证
    dispatch_semaphore_signal(semaphore); // 归还许可证
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // 申请许可证（无超时时间）
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1)); // 申请许可证（超时时间为 1 秒）
    */
    
    
    
    // 7、dispatch_release - 释放指定的 dispatch_xxx_t（注意：ios6 和以上版本不再需要手动 release 了）
}

@end
