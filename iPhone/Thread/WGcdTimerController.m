//
// 演示 GCD Timer
//

#import "WGcdTimerController.h"

@interface WGcdTimerController ()
{
    // gcd timer
    dispatch_source_t _timer;
    // 用于保存执行次数
    int _count;
}

@end

@implementation WGcdTimerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _count = 0;
    
    // timer tick 的间隔时间
    uint64_t interval = 1 * NSEC_PER_SEC;
    
    // 创建一个用于执行 timer tick 回调的 queue
    dispatch_queue_t queue = dispatch_queue_create("myQueue", 0);
    
    // 实例化一个 gcd timer
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置 gcd timer 的参数
    //     第一个参数：gcd timer
    //     第二个参数：gcd timer 的开始的时间
    //     第三个参数：timer tick 的间隔时间，单位：纳秒
    //     第四个参数：timer 的精度，想要高精度的就写 “0” 吧
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);

    // 设置 timer tick 的回调函数
    dispatch_source_set_event_handler(_timer, ^()
    {
        dispatch_async(dispatch_get_main_queue(), ^()
        {
            _count ++;
            self.lblMsg.text = [NSString stringWithFormat:@"%i", _count];
            
            if (_count >= 10)
            {
                // 取消 timer
                dispatch_source_cancel(_timer);
            }
        });
    });
    
    // dispatch_source 默认是 suspended 状态，需要通过 dispatch_resume 函数启动它
    dispatch_resume(_timer);
    
    
    // dispatch_release - 释放指定的 dispatch_xxx_t（注意：ios6 和以上版本不再需要手动 release 了）
    // dispatch_release(queue);
    // dispatch_release(_timer);
}

@end
