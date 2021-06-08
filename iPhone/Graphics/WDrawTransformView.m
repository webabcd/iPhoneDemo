//
// 演示 Transform 的应用
//
// 本例演示的是如何 Transform 一个 Graphics
// UIView 的 Transform 与此同理，可以通过 UIView 的 transform 属性来实现
//

#import "WDrawTransformView.h"

@implementation WDrawTransformView

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
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 0, 1, 1);
    CGContextSetLineWidth(context, 5);
    
    // 实例化 CGMutablePathRef，可以指定其 transform
    CGMutablePathRef path = CGPathCreateMutable();

    // 绘制 CGPath，并指定其 transform
    CGAffineTransform transform = [self getTransform];
    CGPathAddRect(path, &transform, CGRectMake(10, 10, 200, 100));
    
    // 将我们构造好的 CGPathRef 添加进 CG 上下文
    CGContextAddPath(context, path);
    
    // 绘制当前 CG 上下文中的路径
    CGContextDrawPath(context, kCGPathStroke);
    
    // 注意：需要释放 CGPathRef
    CGPathRelease(path);
}

// 获取 CGAffineTransform 对象
- (CGAffineTransform)getTransform
{
    // 位移变换（另外还可以缩放变换，旋转变换，矩阵变换）
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100, 100);
    
    // matrix transform
    // CGAffineTransformMake(<#CGFloat a#>, <#CGFloat b#>, <#CGFloat c#>, <#CGFloat d#>, <#CGFloat tx#>, <#CGFloat ty#>);
    
    // 缩放变换（在指定的 transform 的基础上再增加新的 transform）
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    
    // 旋转变换
    transform = CGAffineTransformRotate(transform, [self degreesToRadians:45]);
    
    // 合并两个 transform
    // transform = CGAffineTransformConcat(<#CGAffineTransform t1#>, <#CGAffineTransform t2#>)
    
    return transform;
}

// 角度转弧度
- (float)degreesToRadians:(float)degrees
{
    return M_PI * degrees / 180.0;
}

@end
