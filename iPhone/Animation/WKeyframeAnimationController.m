//
// 演示关键帧动画（插帧动画）的应用
//

#import "WKeyframeAnimationController.h"

@interface WKeyframeAnimationController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation WKeyframeAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化用于演示插帧动画的 UIImageView
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Son.png"]];
    self.imageView.frame = CGRectMake(10, 300, 100, 100);
    [self.view addSubview:self.imageView];
}


// 通过关键帧动画模拟 BounceEase 缓动（通过 CAKeyframeAnimation）
- (IBAction)button1Pressed:(id)sender
{
    // 实例化 CAKeyframeAnimation
    // animationWithKeyPath - 代表动画要改变的属性，本例要改变的是 UIImageView 的 bounds.size 属性
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    
    // 动画开始时的 size
    CGSize startingSize = CGSizeZero;
    // 动画结束时的 size
    CGSize targetSize = CGSizeMake(100,100);
    // BounceEase 弹出去时的 size
    CGSize overshootSize = CGSizeMake(120,120);
    // BounceEase 缩回来时的 size
    CGSize undershootSize = CGSizeMake(80,80);
    
    // 关键帧动画的每个关键帧的显示时间点（0 - 1 之间）
    NSArray *times = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f], nil];
    [animation setKeyTimes:times];

    // 关键帧动画的每个关键帧的针对 animationWithKeyPath 所设置的值
    NSArray *boundsValues = [NSArray arrayWithObjects:[NSValue valueWithCGSize:startingSize],
                             [NSValue valueWithCGSize:targetSize],
                             [NSValue valueWithCGSize:overshootSize],
                             [NSValue valueWithCGSize:undershootSize],
                             [NSValue valueWithCGSize:targetSize], nil];
    [animation setValues:boundsValues];
    
    // 动画时长
    animation.duration = 1.0;
    
    // 关键帧动画的方式
    //   kCAAnimationLinear（线性）, kCAAnimationDiscrete（离散）, kCAAnimationPaced, kCAAnimationCubic, kCAAnimationCubicPaced
    animation.calculationMode = kCAAnimationLinear;
    
    // 开始插帧动画
    // 第 1 个参数：CAKeyframeAnimation
    // 第 2 个参数：动画的 id
    [self.imageView.layer addAnimation:animation forKey:NULL];
}


// 实现关键帧动画的简单方法（通过 animateKeyframesWithDuration，ios7 或以上支持）
- (IBAction)button2Pressed:(id)sender
{
    // animateKeyframesWithDuration - 执行一段关键帧动画
    // 第 1 个参数：动画时长
    // 第 2 个参数：动画的延迟开始时间
    // 第 3 个参数：关键帧动画选项，参见：UIViewKeyframeAnimationOptions 枚举
    // 第 4 个参数：一个 block，用于设置关键帧动画的每一个关键帧
    // 第 5 个参数：一个 block，关键帧动画完成
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^
    {
        // 设置关键帧动画的每一个关键帧
        // 第 1 个参数：此关键帧的显示时间点（0 - 1 之间）
        // 第 2 个参数：此关键帧的显示时长占动画总时长的百分比（0 - 1 之间）
        // 第 3 个参数：此关键帧的结果
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.6 animations:^{
            self.imageView.frame = CGRectMake(100, 300, 100, 100);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(200, 300, 100, 100);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            self.imageView.frame = CGRectMake(10, 300, 100, 100);
        }];

    } completion:^(BOOL finished)
    {
        // YES 代表过渡动画正常结束
    }];
}


// 只有两个关键帧的动画的简单实现方法（通过 CABasicAnimation）
- (IBAction)button3Pressed:(id)sender
{
    // 实例化 CABasicAnimation
    // animationWithKeyPath - 代表动画要改变的属性，本例要改变的是 UIImageView 的 opacity 属性
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    // 两关键帧动画的第 1 帧
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    // 两关键帧动画的第 2 帧
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    
    // 两个关键帧之间的动画类型
    //   kCAMediaTimingFunctionLinear, kCAMediaTimingFunctionEaseIn, kCAMediaTimingFunctionEaseOut, kCAMediaTimingFunctionEaseInEaseOut, kCAMediaTimingFunctionDefault;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 通过三次贝塞尔曲线控制两个关键帧之间的动画类型
    // animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :1 :0.1];
    
    // 动画时长
    animation.duration = 2;
    
    // 开始动画
    // 第 1 个参数：CABasicAnimation
    // 第 2 个参数：动画的 id
    [self.imageView.layer addAnimation:animation forKey:NULL];
}

@end
