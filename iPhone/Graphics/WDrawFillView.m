//
// 演示填充、渐变、阴影的应用
//

#import "WDrawFillView.h"

@implementation WDrawFillView

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
    // 通过 CGContextDrawPath 填充
    [self fillDemo];
    
    // 通过 CGContextFillRect, CGContextFillRects, CGContextFillEllipseInRect, CGContextFillPath 填充
    [self fillDemo2];
    
    // 线性渐变
    [self gradientDemo];
    
    // 放射性渐变
    [self gradientDemo2];
    
    // 阴影效果
    [self shadowDemo];
}


// 通过 CGContextDrawPath 填充
- (void)fillDemo
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制矩形
    CGContextAddRect(context, CGRectMake(100, 10, 100, 30));
    
    // 设置填充颜色
    CGContextSetRGBFillColor(context, 0, 1, 0, 1);
    
    // 以填充的方式绘制路径
    // 第 2 个参数是 CGPathDrawingMode 枚举
    //   kCGPathStroke - 绘制路径
    //   kCGPathFill - 填充路径
    //   kCGPathFillStroke - 填充路径并绘制路径
    //   kCGPathEOFill - 奇偶规则填充路径（EO: e - even 偶，o - odd 奇，关于奇偶规则可以参见 WDrawClipController.m 中的演示）
    //   kCGPathEOFillStroke - 奇偶规则填充路径并绘制路径
    CGContextDrawPath(context, kCGPathFill);
}

// 通过 CGContextFillRect, CGContextFillRects, CGContextFillEllipseInRect, CGContextFillPath 填充
- (void)fillDemo2
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置填充颜色
    CGContextSetRGBFillColor(context, 0, 1, 0, 1);
    
    // 矩形填充
    CGContextFillRect(context, CGRectMake(100, 50, 100, 30));
    
    // CGContextFillRects - 填充多矩形
    // CGContextFillEllipseInRect - 填充椭圆
    // CGContextFillPath - 填充路径，如果不是封闭图形的话，可以先执行 CGContextClosePath(context) 来封闭路径
}


// 演示线性渐变
- (void)gradientDemo
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
        29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
        0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
    };
    CGFloat locations[] = {0.0, 0.7, 1.0};
    
    // 创建一个渐变对象
    // 第 1 个参数：颜色空间，一般就是 CGColorSpaceCreateDeviceRGB()
    // 第 2 个参数：渐变颜色的关键颜色数组，采用 RGBA 方式，所以数组必须要有 n*4 个元素
    // 第 3 个参数：关键颜色数组中每一个颜色的位置（nil，代表采用等分的方式）
    // 第 4 个参数：关键颜色的数量（本例是 3 个）
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, locations, sizeof(colors)/(sizeof(colors[0])*4));
    
    // 绘制线性渐变效果
    // 第 2 个参数：渐变对象
    // 第 3 个参数：起始点
    // 第 4 个参数：结束点
    // 第 5 个参数：CGGradientDrawingOptions 枚举
    //   0 - 无
    //   kCGGradientDrawsBeforeStartLocation - 起始点之前的区域用关键颜色数组中的第一个颜色填充
    //   kCGGradientDrawsAfterEndLocation - 结束点之后的区域用关键颜色数组中的最后一个颜色填充
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 100.0), CGPointMake(0.0,150.0), 0);
    
    // 注意：需要手动释放
    CGColorSpaceRelease(rgb);
    CGGradientRelease(gradient);
}

// 演示放射性渐变
- (void)gradientDemo2
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
        29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
        0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
    };
    CGFloat locations[] = {0.0, 0.7, 1.0};
    
    // 创建一个渐变对象
    // 第 1 个参数：颜色空间，一般就是 CGColorSpaceCreateDeviceRGB()
    // 第 2 个参数：渐变颜色的关键颜色数组，采用 RGBA 方式，所以数组必须要有 n*4 个元素
    // 第 3 个参数：关键颜色数组中每一个颜色的位置（nil，代表采用等分的方式）
    // 第 4 个参数：关键颜色的数量（本例是 3 个）
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, locations, sizeof(colors)/(sizeof(colors[0])*4));
    
    // 绘制放射性渐变效果
    // 第 2 个参数：渐变对象
    // 第 3 个参数：放射性渐变起始中心点
    // 第 4 个参数：以放射性渐变起始中心点为圆心的一个指定半径的圆，这个圆的圆周就是放射性渐变的起始点
    // 第 5 个参数：放射性渐变结束中心店
    // 第 6 个参数：以放射性渐变结束中心点为圆心的一个指定半径的圆，这个圆的圆周就是放射性渐变的结束点
    // 第 7 个参数：CGGradientDrawingOptions 枚举
    //   0 - 无
    //   kCGGradientDrawsBeforeStartLocation - 起始点之前的区域用关键颜色数组中的第一个颜色填充
    //   kCGGradientDrawsAfterEndLocation - 结束点之后的区域用关键颜色数组中的最后一个颜色填充
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 200), 0, CGPointMake(148, 180), 50, 0);
    
    // 注意：需要手动释放
    CGColorSpaceRelease(rgb);
    CGGradientRelease(gradient);
}


// 演示阴影效果
- (void)shadowDemo
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置阴影的偏移量
    CGSize shadowOffset = CGSizeMake (5, 10);
    CGContextSetShadow(context, shadowOffset, 5);
    
    const CGFloat colorValues[] = {1, 0, 0, 0.3};
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(colorSpaceRef, colorValues);
    
    // 设置阴影效果
    // 第 2 个参数：阴影偏移量
    // 第 3 个参数：毛边大小
    // 第 4 个参数：阴影颜色（nil 就是没有阴影效果）
    CGContextSetShadowWithColor(context, shadowOffset, 5, colorRef);
    
    // 绘制矩形（同时会根据 CG 上下文中的阴影信息绘制阴影效果）
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    CGContextFillRect(context, CGRectMake(50, 250, 200, 100));
    
    // 注意：需要手动释放
    CGColorRelease(colorRef);
    CGColorSpaceRelease(colorSpaceRef);
}

@end
