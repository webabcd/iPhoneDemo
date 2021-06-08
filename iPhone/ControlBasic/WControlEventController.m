//
// 演示 UIControlEvent 的应用，即 target/action 的应用
//
// 注：所有继承自 UIControl 的控件（比如 UIButton, UITextField 等）均支持 target/action 模型，即可以捕获相关的 UIControlEvent 事件
//
// UIControlEvent 事件包括：
// UIControlEventTouch - 触摸相关的一堆事件，如：UIControlEventTouchDown 等等
// UIControlEventEditing - 编辑相关的一堆事件，如：UIControlEventEditingDidBegin 等等，UITextField 可以触发这些事件
// UIControlEventValueChanged - 值发生变化的事件，对于 UISwitch 之类的会很有用
//

#import "WControlEventController.h"

@interface WControlEventController ()
{
    // gcd timer
    dispatch_source_t _timer;
}

@end

@implementation WControlEventController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 演示 target/action
    [self demo1];
    
    // 演示当开发一个自定义控件的时候，如何触发 UIControlEvent 事件
    [self demo2];
}


// 演示 target/action
- (void)demo1
{
    // target/action 模型（可以通过 “|” 在一个 addTarget 中捕获多个事件）
    [self.btnDemo addTarget:self action:@selector(onUIControlEvent:) forControlEvents:UIControlEventTouchDown|UIControlEventTouchUpInside];
    
    
    // 以下是来自 UIControl 的一些函数
    // 移除 target/action（action 为 nil）
    // [self.btnDemo removeTarget:<#(id)#> action:nil forControlEvents:<#(UIControlEvents)#>];
    
    // 获取全部 target
    // [self.btnDemo allTargets];
    
    // 获取指定事件的全部 action
    // [self.btnDemo actionsForTarget:<#(id)#> forControlEvent:<#(UIControlEvents)#>];
    
    // 获取全部 UIControlEvent
    // [self.btnDemo allControlEvents];
}
- (void)onUIControlEvent:(UIControl *)sender
{
    self.lblMsg.text = [NSString stringWithFormat:@"%1.2f", [NSDate date].timeIntervalSince1970];
}


// 演示当开发一个自定义控件的时候，如何触发 UIControlEvent 事件
- (void)demo2
{
    uint64_t interval = 1 * NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create("myQueue", 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(_timer, ^()
    {
        // 通过 sendActionsForControlEvents 来触发事件
        [self.btnDemo2 sendActionsForControlEvents:UIControlEventTouchDown];
        
        // 注意：自定义事件的话可以使用的值的范围如下（但是比较坑的是，其是flag类型的）
        // 0x0F000000 - 0x0FFFFFFF
    });
    dispatch_resume(_timer);
    
    [self.btnDemo2 addTarget:self action:@selector(onUIControlEvent2:) forControlEvents:UIControlEventAllEvents];
}
- (void)onUIControlEvent2:(UIControl *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^()
    {
        self.lblMsg2.text = [NSString stringWithFormat:@"%1.2f", [NSDate date].timeIntervalSince1970];
    });
}

@end
