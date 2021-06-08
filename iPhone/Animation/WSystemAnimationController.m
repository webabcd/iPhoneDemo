//
// 演示系统动画的应用（ios7 或以上支持）
//

#import "WSystemAnimationController.h"

@interface WSystemAnimationController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;

@end

@implementation WSystemAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化 2 个 view（一个红色的view，一个绿色的view），用于演示系统动画的应用
    self.redView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:self.redView atIndex:0];
    
    self.greenView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view insertSubview:self.greenView atIndex:0];
    
    
    // 实例化一个 UIImageView
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"son.png"]];
    self.imageView.frame = CGRectMake(10, 300, 100, 100);
    [self.view addSubview:self.imageView];
}


// 演示 UISystemAnimationDelete 动画的效果
- (IBAction)button1Pressed:(id)sender
{
    // performSystemAnimation - 执行一段系统动画（仅 ios7 或以上支持）
    // 第 1 个参数：系统动画的类型，UISystemAnimation 枚举，目前只支持 UISystemAnimationDelete
    // 第 2 个参数：指定在哪些 view 上使用系统动画
    // 第 3 个参数：与系统动画并发执行的动画的动画选项，参见：UIViewAnimationOptions 枚举
    // 第 4 个参数：一个 block，与系统动画并发执行的动画的动画完成后的结果
    // 第 5 个参数：一个 block，动画完成
    [UIView performSystemAnimation:UISystemAnimationDelete onViews:@[self.redView] options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromLeft animations:^
    {
       self.imageView.frame = CGRectMake(200, 300, 100, 100);
    } completion:^(BOOL finished)
    {
        // YES 代表过渡动画正常结束
    }];
}

@end
