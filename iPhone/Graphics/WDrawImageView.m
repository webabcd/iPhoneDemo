//
// 演示如何 draw image, 以及图像九宫格的应用
//

#import "WDrawImageView.h"

@implementation WDrawImageView

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
    UIImage *image = [UIImage imageNamed:@"A.png"];
    
    // 在 0,0 点以图片原始大小绘制图像
    [image drawAtPoint:CGPointMake(0, 0)];
    
    // 将图片拉伸为 200,100 然后在 0,80 点绘制
    [image drawInRect:CGRectMake(0, 80, 200, 100)];
    
    
    
    // 以下演示如何九宫格
    // 图像九宫格的 4 个不变部分的大小
    UIEdgeInsets edgeInsets;
    edgeInsets.left = 20.0f;
    edgeInsets.top = 20.0f;
    edgeInsets.right = 20.0f;
    edgeInsets.bottom = 20.0f;
    
    // 以九宫格方式绘制图片（UIImageResizingModeTile - repeate 方式填充可变部分）
    image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    [image drawInRect:CGRectMake(0, 200, 300, 80)];
    
    // 以九宫格方式绘制图片（UIImageResizingModeStretch - stretch 方式填充可变部分）
    image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
    [image drawInRect:CGRectMake(0, 300, 300, 80)];
}

@end
