//
// 演示如何 draw image, 以及图像九宫格的应用
//
// 详细代码参见: WDrawImageView.m
//

#import "WDrawImageController.h"
#import "WDrawImageView.h"

@interface WDrawImageController ()

@end

@implementation WDrawImageController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 将我们自定义的 UIView 添加进来（用于演示如何 draw image, 以及图像九宫格的应用）
    WDrawImageView *myImageView = [[WDrawImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [self.view addSubview:myImageView];
}

@end
