//
// 演示如何通过 Core Graphics 绘制各种形状
//

#import "WDrawShapeView.h"

@implementation WDrawShapeView

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
    // 画线
    [self drawLine];
    
    // 画虚线
    [self drawLineDash];
    
    // 画矩形
    [self drawRectangle];
    
    // 画椭圆
    [self drawEllipse];
    
    // 画弧线
    [self drawArc];
    
    // 画二次贝塞尔曲线
    [self drawQuadraticBezier];
    
    // 画三次北塞尔曲线
    [self drawBezier];
    
    
    // 演示 CGMutablePathRef 的应用
    // 绘制路径后，可以保存路径信息
    [self CGPathDemo];
}


// 画线
- (void)drawLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 笔划颜色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    // 笔划粗细
    CGContextSetLineWidth(context, 10);
    
    // 设置图形连接点的连接类型
    // kCGLineJoinMiter - 角形连接
    // kCGLineJoinBevel - 线形连接
    // kCGLineJoinRound - 弧形连接
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    
    // 第 1 个点
    CGContextMoveToPoint(context, 10, 10);
    // 直线连接到第 2 个点
    CGContextAddLineToPoint(context, 100, 100);
    // 直线连接到第 3 个点
    CGContextAddLineToPoint(context, 300, 10);
    
    // 绘制当前 CG 上下文中的路径（路径相关的上下文会被清空，但是笔划相关的上下文会被保留。如果需要保留路径信息，需要 CGPath，请参见本例中的 CGPathDemo）
    CGContextStrokePath(context);
    

    // 清除指定的矩形区域
    // CGContextClearRect(context, CGRectMake(0, 0, 300, 200));
}

// 画虚线
- (void)drawLineDash
{
    CGContextRef context = UIGraphicsGetCurrentContext();
 
    const CGFloat dashArray[] = {20, 15, 10};
    // 设置虚线样式
    // 第 2 个参数：虚线起始点的偏移位置
    // 第 3 个参数：虚线实体和虚线间隙的值的集合（本例为：第 1 条实线长度 20（根据 1 个参数偏移后就是 10），第 1 条虚线长度 15，第 2 条实线长度 10，第 2 条虚线长度 20，如此循环。。。）
    // 第 4 个参数：指定使用 dashArray 的前几个元素
    CGContextSetLineDash(context, 10,  dashArray, 3);
    
    // 虚线实体部分两端（线帽）的类型
    // kCGLineCapButt - 无
    // kCGLineCapSquare - 矩形，高度为 lineWidth，宽度为 lineWidth/2
    // kCGLineCapRound - 半圆，直径为 lineWidth
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    CGContextSetLineWidth(context, 5);
    
    CGContextMoveToPoint(context, 0, 50);
    CGContextAddLineToPoint(context, 300, 50);
    
    // 绘制当前 CG 上下文中的路径
    CGContextStrokePath(context);
}

// 画矩形
- (void)drawRectangle
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 清除当前 CG 上下文的虚线设置
    CGContextSetLineDash(context, 0,  nil, 0);
    
    CGContextSetRGBStrokeColor(context, 1, 0, 1, 1);
    CGContextSetLineWidth(context, 5);
    
    // 绘制矩形
    CGContextAddRect(context, CGRectMake(100, 120, 100, 30));
    
    // 绘制当前 CG 上下文中的路径
    CGContextStrokePath(context);
}

// 绘制椭圆
- (void)drawEllipse
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGContextSetLineWidth(context, 5);
    
    // 指定一个矩形区域，绘制椭圆
    CGContextAddEllipseInRect(context, CGRectMake(100, 180, 100, 30));
    
    // 绘制当前 CG 上下文中的路径
    CGContextDrawPath(context, kCGPathStroke);
}

// 绘制弧线
- (void)drawArc
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextSetLineWidth(context, 5);
    
    // 绘制弧线（圆形的一部分）
    // 第 2、3 个参数：圆形的中心点
    // 第 4 个参数：圆形的半径
    // 第 5、6 个参数：弧的开始角度和结束角度（x 正方向为 0 度，顺时针为正）
    // 第 7 个参数：1 顺时针绘制，0 逆时针绘制
    CGContextAddArc(context, 100, 200, 100, 0, -45, 0);
    
    // 绘制当前 CG 上下文中的路径
    CGContextStrokePath(context);
}

// 绘制二次贝塞尔曲线（Quadratic Bezier - 二次贝塞尔曲线）
- (void)drawQuadraticBezier
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 0, 1, 1);
    CGContextSetLineWidth(context, 5);
    
    // 绘制二次北塞尔曲线（关于什么是“二次贝塞尔曲线”，请维基百科，有动画演示）
    CGContextMoveToPoint(context, 100, 300);
    CGContextAddQuadCurveToPoint(context, 200, 250, 300, 300);
    
    // 绘制当前 CG 上下文中的路径
    CGContextStrokePath(context);
}

// 绘制三次贝塞尔曲线（Cubic Bezier - 三次贝塞尔曲线，就是我们常说的贝塞尔曲线）
- (void)drawBezier
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 1, 0, 1);
    CGContextSetLineWidth(context, 5);
    
    // 绘制三次贝塞尔曲线（关于什么是“三次贝塞尔曲线”，请维基百科，有动画演示）
    CGContextMoveToPoint(context, 100, 300);
    CGContextAddCurveToPoint(context, 80, 200, 200, 200, 300, 300);
    
    // 绘制当前 CG 上下文中的路径
    CGContextStrokePath(context);
}



// 演示 CGMutablePathRef 的应用
// 绘制路径后，可以保存路径信息
- (void)CGPathDemo
{
    // 按之前所说的方法绘制各种路径时，绘制之后路径相关的上下文会被清空，但是笔划相关的上下文还是会被保留
    // 如果需要保留路径信息，则需要引入 CGMutablePathRef, CGPathRef（CGMutablePathRef 继承自 CGPathRef）
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 实例化 CGMutablePathRef，路径信息在绘制之后也会被保留
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 100, 320);
    CGPathAddLineToPoint(path, nil, 200, 350);
    CGPathAddRect(path, nil, CGRectMake(200, 350, 100, 20));
    
    // 将我们构造好的 CGPathRef 添加进 CG 上下文
    CGContextAddPath(context, path);
    
    // 绘制当前 CG 上下文中的路径
    CGContextDrawPath(context, kCGPathStroke);
    
    // 注意：需要释放 CGPathRef
    CGPathRelease(path);
}

@end
