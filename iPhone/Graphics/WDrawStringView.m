//
// 演示如何 draw string
//

#import "WDrawStringView.h"

@implementation WDrawStringView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// override drawRect（来自 UIView）
- (void)drawRect:(CGRect)rect
{
    // 构造一个文字样式的字典表（关于文字样式的更多内容参见：UI/WFontStyleController.m）
    NSDictionary *fontAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:32.0f], NSForegroundColorAttributeName:[UIColor orangeColor]};
    
    // 需要 draw 的字符串
    NSString *myString = [NSString stringWithFormat:@"time: %1.0f", [NSDate date].timeIntervalSince1970];
    
    // 在指定的位置，以指定的样式 draw 一个字符串
    [myString drawAtPoint:CGPointMake(0, 0) withAttributes:fontAttributes];
}

@end
