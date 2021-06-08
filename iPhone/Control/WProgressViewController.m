//
// 演示 UIProgressView 的应用
//

#import "WProgressViewController.h"

@interface WProgressViewController ()

@end

@implementation WProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化 UIProgressView
    // 样式有 UIProgressViewStyleDefault, UIProgressViewStyleBar
    UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    // 注意：UIProgressView 的高度是无法自定义的
    progress.frame = CGRectMake(20, 100, 280, 100);
    
    // 设置填充部分的颜色
    progress.progressTintColor = [UIColor orangeColor];
    // 设置未填充部分的颜色
    progress.trackTintColor = [UIColor blueColor];
    
    // 设置填充部分和未填充部分的图片
    // progress.progressImage, progress.trackImage
    
    // 指定 UIProgressView 的值（0 - 1 之间）
    progress.progress = 0.7f;
    
    [self.view addSubview:progress];
}

@end
