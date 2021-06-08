//
// 控件基础：简述 bounds frame center 的含义
//
// 为了便于理解，请对着 demo 看 bounds frame center 的值
// 控件均在 UIKit 中，均继承自 UIView
//

#import "WControlBasicController.h"

@interface WControlBasicController ()

@end

@implementation WControlBasicController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 通过 frame 指定控件的初始位置
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    UIImageView *imageViewRotation = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    
    // bounds: 0, 0, 100, 100 - 控件自身的边界
    // frame: 0, 200, 100, 100 - 控件所占用的矩形框的位置（相对于容器 00 点）和大小
    // center: 50, 250 - 控件中心点相对于容器 00 点的位置
    imageView.image = [UIImage imageNamed:@"Son.jpg"];
    
    // bounds: 0, 0, 100, 100 - 控件自身的边界
    // frame: 79, 279, 141, 141 - 控件所占用的矩形框的位置（相对于容器 00 点）和大小
    // center: 150, 350 - 控件中心点相对于容器 00 点的位置
    imageViewRotation.image = [UIImage imageNamed:@"Son.jpg"];
    imageViewRotation.transform = CGAffineTransformMakeRotation([self degreesToRadians:45]); // 顺时针旋转 45 度
    
    [self.view addSubview:imageView];
    [self.view addSubview:[[WControlBasicUIView alloc] initWithFrame:imageViewRotation.frame]]; // 用于标记 imageViewRotation 的 frame（红色背景部分）
    [self.view addSubview:imageViewRotation];
    
    self.lblMsg.text = [NSString stringWithFormat:@"bounds:%1.2f, %1.2f, %1.2f, %1.2f\nframe:%1.2f, %1.2f, %1.2f, %1.2f\ncenter:%1.2f, %1.2f\n\nbounds:%1.2f, %1.2f, %1.2f, %1.2f\nframe:%1.2f, %1.2f, %1.2f, %1.2f\ncenter:%1.2f, %1.2f", imageView.bounds.origin.x, imageView.bounds.origin.y, imageView.bounds.size.width, imageView.bounds.size.height, imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height, imageView.center.x, imageView.center.y, imageViewRotation.bounds.origin.x, imageViewRotation.bounds.origin.y, imageViewRotation.bounds.size.width, imageViewRotation.bounds.size.height, imageViewRotation.frame.origin.x, imageViewRotation.frame.origin.y, imageViewRotation.frame.size.width, imageViewRotation.frame.size.height, imageViewRotation.center.x, imageViewRotation.center.y];
    
    
    // 如果要让某个 view 相对于某个 view 居中的话可以利用 center 属性
    // 比如让一个 imageView 居中的话就: imageView.center = self.view.center;
}

// 角度转弧度
- (float)degreesToRadians:(float)degrees
{
    return M_PI * degrees / 180.0;
}

@end


// 用于标记哪部分是 imageViewRotation 的 frame
@implementation WControlBasicUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    self.backgroundColor = [UIColor redColor];
    return self;
}

@end
