//
// 演示 UIImageView 的应用
//
// 关于图像九宫格请参见：Graphics/WDrawImageController.m
//

#import "WImageViewController.h"

@interface WImageViewController ()

@end

@implementation WImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // contentMode = UIViewContentModeScaleToFill - 拉伸以填满容器，默认值
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 100, 50)];
    imageView.image = [UIImage imageNamed:@"Son.jpg"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    
    // contentMode = UIViewContentModeScaleAspectFill - 等比缩放以填满容器，可能会溢出
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 200, 100, 50)];
    imageView2.image = [UIImage imageNamed:@"Son.jpg"];
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView2];

    // contentMode = UIViewContentModeScaleAspectFit - 等比缩放以适应容器，不会溢出
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 300, 100, 50)];
    imageView3.image = [UIImage imageNamed:@"Son.jpg"];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView3];
    
    
    // 显示序列图（逐帧动画）
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
    // 注意
    // 1、可以不要后缀名
    // 2、ios8 以下，比如如果找不到@2x，就会去找标准，但是不会找@3x
    // 3、ios8 或以上，比如如果找不到@2x，就会去找标准，再找不到就会去找@3x
    [array addObject:[UIImage imageNamed:@"A.png"]];
    [array addObject:[UIImage imageNamed:@"B.png"]];
    [array addObject:[UIImage imageNamed:@"C.png"]];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 400, 100, 50)];
    // 序列图数组
    imageView4.animationImages = array;
    // 显示完序列图中的全部图片所需要的秒数
    imageView4.animationDuration = 1.0;
    // 重复次数（0 代表无限循环）
    imageView4.animationRepeatCount = 0;
    // 开始序列图动画
    [imageView4 startAnimating];
    [self.view addSubview:imageView4];
    
    
    // 还有一些其它常用 api 如下
    // 是否隐藏
    // [imageView.hidden]
    // 不透明度
    // [imageView.alpha]
    // 将图片的尺寸调整为原始大小
    // [imageView sizeToFit]
    // 高亮相关的一组属性
    // imageView.highlighted, imageView.highlightedImage, imageView.highlightedAnimationImages
    
    
    // 显示 http 方式的远程图片（注：这个是同步的）。可以考虑一个开源库：SDWebImage
    // [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://aaa.aaa.aaa/aaa.png"]]];
}

@end
