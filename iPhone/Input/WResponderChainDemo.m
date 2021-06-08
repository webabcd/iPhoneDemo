//
// 用于演示 Responder Chain 的 UIView
//
// 几个需要知道的概念如下：
// Responder Chain - 响应者链，其实就是事件冒泡
// Response Object - 响应者
// First Responder - 第一个响应者
// Next Responder - 下一个响应者，就是事件冒泡
//

#import "WResponderChainDemo.h"

@implementation WResponderChainDemo

@synthesize lblMsg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 在 UIView 上添加一个 UILabel，用于显示相关信息
        self.lblMsg = [[UILabel alloc] initWithFrame:self.bounds];
        self.lblMsg.text = @"touch me";
        self.lblMsg.textColor = [UIColor whiteColor];
        self.lblMsg.numberOfLines = 0;
        
        [self addSubview:self.lblMsg];
        self.backgroundColor = [UIColor blueColor];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 注意：默认是不冒泡的，要想冒泡就调用 super 的同函数
    [super touchesBegan:touches withEvent:event];
    
    self.lblMsg.text = [NSString stringWithFormat:@"touchesBegan: %1.2f", event.timestamp];
}

@end
