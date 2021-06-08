//
// 演示 NSTimer 的应用（在 UI 线程上）
//
// 建议用 GCD Timer
//

#import "WTimerDemoController.h"

@interface WTimerDemoController ()
{
    // 用于保存执行次数
    int _count;
}

@end

@implementation WTimerDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSTimeInterval interval = 1.0f;
    
    // 实例化一个 NSTimer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(onTick:) userInfo:@"webabcd" repeats:YES];
    
    // 立刻启动 timer，否则会在 interval 的时间过后再启动
    // [timer fire];
}

- (void)onTick:(NSTimer *)timer
{
    _count ++;
    self.lblMsg.text = [NSString stringWithFormat:@"%i", _count];
    
    if (_count >= 10)
    {
        // 停止 timer
        [timer invalidate];
        
        // 相当于一个上下文对象
        // [timer.userInfo];
        // 是否有效
        // [timer.isValid];
        // timer 的 interval
        // [timer.timeInterval];
        // timer 的启动时间
        // [timer.fireDate];
    }
}

@end
