//
// 演示如何获取分辨率，以及如何适应分辨率
//
// 几个概念
// 1、pixel：真实像素
// 2、point：在 ios 开发中，设置尺寸以及定位都是通过 “点” 来完成的，这样就不用太关心分辨率的问题了，系统会自动把 point 缩放到 pixel
// 3、point * scale = pixel
//

#import "WResolutionController.h"

@interface WResolutionController ()

@end

@implementation WResolutionController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // 获取当前屏幕的分辨率（单位：point）
    CGRect rectPoint = [[UIScreen mainScreen] bounds];
    // 获取 point 到 pixel 的缩放比
    CGFloat scale = [[UIScreen mainScreen] scale];
    // 获取当前屏幕的分辨率（单位：pixel）
    CGRect rectPixel = CGRectMake(0, 0, rectPoint.size.width * scale, rectPoint.size.height * scale);
    
    // 获取当前屏幕的分辨率，不包括 statusBar（单位：point）
    CGRect rectPointWithoutStatusBar = [[UIScreen mainScreen] applicationFrame];
    // 获取当前屏幕的分辨率，不包括 statusBar（单位：pixel）
    CGRect rectPixelWithoutStatusBar = CGRectMake(0, 0, rectPointWithoutStatusBar.size.width * scale, rectPointWithoutStatusBar.size.height * scale);
    
    self.lblMsg.text = [NSString stringWithFormat:@"point: %1.0f * %1.0f, scale: %1.0f", rectPoint.size.width, rectPoint.size.height, scale];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\npixel: %1.0f * %1.0f", rectPixel.size.width, rectPixel.size.height];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\npixel(without statusBar): %1.0f * %1.0f", rectPixelWithoutStatusBar.size.width, rectPixelWithoutStatusBar.size.height];
    
    
    
    // 图片为了适应多种分辨率，命名规则如下：
    // 一般图片文件名：xxx.png, 对应的 retina 屏图片文件名：xxx@2x.png（分辨率必须是 xxx.png 的两倍，否则引用可能会有问题）
    // 引用图片时与平时的做法一样，系统如果发现是 retina 屏，会自动引用对应的 @2x 文件
    self.imageView.image = [UIImage imageNamed:@"A.png"];
    
    
    
    // 以下再简述几个常识（单位均是像素）：
    // iphone3gs 或以下的分辨率：320 * 480
    // iphone4 或以上的分辨率：640 * 960
    // iphone5 或以上的分辨率：640 * 1136
    
    // ipad 分辨率：768 * 1024
    // ipad retina 分辨率：1536 * 2048
    
    // app 在 itunes 上的图标 512*512, 圆角半径 90
    // iphone app 图标 57*57, 圆角半径 10
    // iphone app retina 图标 114*114, 圆角半径 20
    // ipad app 图标 72*72, 圆角半径 12
    // ipad app retina 图标 144*144, 圆角半径 24
    
    // iphone spotlight（and settings） 图标 29*29, 圆角半径 5
    // iphone spotlight retina（and settings） 图标 58*58, 圆角半径 10
    // ipad spotlight（and settings） 图标 50*50, 圆角半径 10
    // ipad spotlight retina（and settings） 图标 100*100, 圆角半径 20
}

@end
