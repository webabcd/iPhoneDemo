//
// 演示 CGContext 的基础
//
// 注：通过 Core Graphics 绘画，绘画所需的数据均来自当前的 CG 上下文
//
// CG - Core Graphics, 其绘图引擎来自 Quartz 2D（当然，UIKit 的绘图引擎也是 Quartz 2D）
//

#import "WDrawBasicView.h"

@implementation WDrawBasicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 获取当前的 CG 上下文
    // CG - Core Graphics, 其绘图引擎来自 Quartz 2D（当然，UIKit 的绘图引擎也是 Quartz 2D）
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置当前笔划的颜色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1); // 红色
    
    // 保存当前的 CG 上下文（此时，当前的 CG 上下文变成了一个新的 CG 上下文）
    CGContextSaveGState(context);
    
    // 在新的 CG 上下文中设置笔划的颜色
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1); // 蓝色
    
    // 通过新的 CG 上下文画线，即蓝色线
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextStrokePath(context);
    
    // 加载老的 CG 上下文（此时，当前的 CG 上下文变成了我们之前保存的 CG 上下文）
    CGContextRestoreGState(context);
    
    // 通过之前保存的 CG 上下文画线，即红色线
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 10, 200);
    CGContextStrokePath(context);

}

@end
