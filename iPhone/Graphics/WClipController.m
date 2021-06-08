//
// 演示如何通过 CGContextClip 剪切图片
//

#import "WClipController.h"

@interface WClipController ()

@end

@implementation WClipController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 定义一个需要显示的图片
    UIImage *srcImage = [UIImage imageNamed:@"Son.png"];
    CGFloat width = srcImage.size.width;
    CGFloat height = srcImage.size.height;
    
    // 通过 UIKit 开始绘制图片（指定绘制的宽和高）
    UIGraphicsBeginImageContext(srcImage.size);
    
    // 获取 UIKit 的当前 CG 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 通过 CG 上下文画一个菱形
    CGContextMoveToPoint(context, width/2, 0);
    CGContextAddLineToPoint(context, width, height/2);
    CGContextAddLineToPoint(context, width/2, height);
    CGContextAddLineToPoint(context, 0, height/2);
    CGContextClosePath(context);
    
    // 剪切图片，只显示上面所绘制的菱形区域
    CGContextClip(context);
    
    // 剪切图片，显示除了上面所绘制的菱形区域之外的其他内容（奇偶规则）
    // CGContextAddRect(context, CGContextGetClipBoundingBox(context));
    // CGContextEOClip(context); //（EO: e - even 偶，o - odd 奇）
    
    // 坐标系转换
    // 因为 CGContextDrawImage 使用的是左下角为(0,0)的坐标系，所以要把它转换为左上角为(0,0)的坐标系
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1, -1);
    
    // 通过 CGContextDrawImage 绘制 clip 后的图片
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [srcImage CGImage]);
    
    // 通过 UIKit 结束绘制
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    // 将绘制的图片显示在界面上
    UIImageView *imgView = [[UIImageView alloc] initWithImage:destImage];
    imgView.frame = CGRectMake(50, 100, 200, 200);
    
    [self.view addSubview:imgView];
}

@end
