//
// 演示 UIActivityIndicatorView 的应用
//

#import "WActivityIndicatorViewController.h"

@interface WActivityIndicatorViewController ()

@end

@implementation WActivityIndicatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 演示如何显示一个 loading（包括 loading 和背景）
    [self demo1];
    
    // 演示如何显示一个 loading（包括 loading，提示文字和背景）
    [self demo2];
}

- (void)demo1
{
    // 实例化 UIActivityIndicatorView
    // 样式有：UIActivityIndicatorViewStyleWhite(小号白色), UIActivityIndicatorViewStyleWhiteLarge(大号白色), UIActivityIndicatorViewStyleGray(小号灰色)
    // 大号 loading 的大小是 32*32，小号的 loading 的大小是 16*16（也就是说 loading 大小无法自定义，通过 frame 指定的宽和高是背景的宽和高）
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.frame = CGRectMake(20, 100, 100, 100);
    
    // 设置前景色
    loading.color = [UIColor orangeColor];
    // 设置背景色（默认是透明的，即：[UIColor clearColor]）
    loading.backgroundColor = [UIColor grayColor];
    // 设置 alpha
    loading.alpha = 0.5;
    
    // 设置背景矩形的圆角效果的圆角半径
    loading.layer.cornerRadius = 10;
    // 加个遮罩，以实现背景矩形的圆角效果
    loading.layer.masksToBounds = YES;
    // 显示 loading 动画
    [loading startAnimating];
    
    // 停止 loading 动画时，是否隐藏 UIActivityIndicatorView
    // loading.hidesWhenStopped = YES;
    // 停止 loading 动画
    //[loading stopAnimating];
    
    [self.view addSubview:loading];
}

- (void)demo2
{
    CGRect containerFrame = CGRectMake(100, 200, 100, 80);
    
    // 实现一个 loading
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((containerFrame.size.width - 32) / 2, 15, 32, 32)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [indicator startAnimating];
    
    // 实现一个 loading 时的提示文字
    UILabel *waitingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, containerFrame.size.width, 20)];
    waitingLabel.text = @"Loading...";
    waitingLabel.textAlignment = NSTextAlignmentCenter;
    waitingLabel.textColor = [UIColor whiteColor];
    waitingLabel.font = [UIFont systemFontOfSize:15];
    waitingLabel.backgroundColor = [UIColor clearColor];
    
    // 实现一个包含有 loading 和提示文字的容器
    UIView *container = [[UIView alloc] initWithFrame:containerFrame];
    container.backgroundColor = [UIColor blackColor];
    container.alpha = 0.7;
    container.layer.cornerRadius = 10;
    container.layer.masksToBounds = YES;
    
    // 在容器中添加 loading 和提示文字
    [container addSubview:indicator];
    [container addSubview:waitingLabel];

    // 显示容器
    [self.view addSubview:container];
}

@end
