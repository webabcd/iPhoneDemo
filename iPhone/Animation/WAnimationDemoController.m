//
// 演示如何实现动画效果
//
// 动画效果来自：Core Animation
//
// 注：如需缓动效果请使用第三方框架，原生只支持 CurveEaseInOut, CurveEaseIn, CurveEaseOut 缓动
//

#import "WAnimationDemoController.h"

@interface WAnimationDemoController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageView2;

@end

@implementation WAnimationDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化两个用于演示动画效果的 UIImageView
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Son.png"]];
    self.imageView.frame = CGRectMake(10, 100, 100, 100);
    [self.view addSubview:self.imageView];

    self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Son.png"]];
    self.imageView2.frame = CGRectMake(10, 300, 100, 100);
    [self.view addSubview:self.imageView2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startAnimation];
    [self startAnimation2];
}


// 详解实线动画效果的过程（通过 beginAnimations, commitAnimations）
- (void)startAnimation
{
    // 准备开始一段动画
    // 第 1 个参数：此段动画的 id
    // 第 2 个参数：此段动画的上下文
    [UIView beginAnimations:@"myAnimation" context:(void *)self.imageView];
    
    // 动画时长
    [UIView setAnimationDuration:2.0f];
    
    // 调用 commitAnimations 后，在此参数指定的时间过后开始动画
    [UIView setAnimationDelay:1.0f];
    
    // 动画重复次数
    [UIView setAnimationRepeatCount:3];
    
    // 动画是否往复
    [UIView setAnimationRepeatAutoreverses:YES];
    
    // 设置一个简单的缓动效果（UIViewAnimationCurve 枚举）
    // UIViewAnimationCurveEaseInOut, UIViewAnimationCurveEaseIn, UIViewAnimationCurveEaseOut, UIViewAnimationCurveLinear
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    // 设置动画的开始时间
    // [UIView setAnimationStartDate:<#(NSDate *)#>];
    // 获取 AnimationsEnabled
    // [UIView areAnimationsEnabled];
    // 设置 AnimationsEnabled
    // [UIView setAnimationsEnabled:<#(BOOL)#>];
    // YES 代表停止之前的动画，从当前状态开始新动画
    // [UIView setAnimationBeginsFromCurrentState:<#(BOOL)#>];
    
    // 设置了 setAnimationDelegate 之后，才可以使用 setAnimationWillStartSelector, setAnimationDidStopSelector
    [UIView setAnimationDelegate:self];
    // 动画将要开始时
    [UIView setAnimationWillStartSelector:@selector(imageViewAnimationWillStart:context:)];
    // 动画结束后
    [UIView setAnimationDidStopSelector:@selector(imageViewAnimationDidStop:finished:context:)];
    
    
    // 此处设置动画完成后的结果（要在 beginAnimations 和 commitAnimations 之间设置）
    /***********************************************************************************/
    self.imageView.frame = CGRectMake(200, 300, 100, 100); // 位移
    self.imageView.alpha = 0.5f; // 透明度
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5f, 0.5f); // 缩放
    transform = CGAffineTransformRotate(transform, [self degreesToRadians:45]); // 旋转
    self.imageView.transform = transform;
    /***********************************************************************************/
    
    
    // 开始执行动画
    [UIView commitAnimations];
}

// 动画将要开始时
- (void)imageViewAnimationDidStop:(NSString *)paramAnimationId finished:(NSNumber *)paramFinished context:(void *)paramContext
{
    // paramAnimationId - beginAnimations 时指定的动画 id
    // paramContext - beginAnimations 时指定的动画上下文（可以通过 __bridge 把 “void *” 转换为 oc 的类型）
    // paramFinished - 一个 bool 类型，YES 代表动画正常结束
    
    UIImageView *imageView = (__bridge UIImageView *)paramContext;
    NSLog(@"%@, %i", paramAnimationId, [paramFinished boolValue]);
}

// 动画结束后
- (void)imageViewAnimationWillStart:(NSString *)paramAnimationId context:(void *)paramContext
{
    // paramAnimationId - beginAnimations 时指定的动画 id
    // paramContext - beginAnimations 时指定的动画上下文（可以通过 __bridge 把 “void *” 转换为 oc 的类型）
    
    UIImageView *imageView = (__bridge UIImageView *)paramContext;
    NSLog(@"%@", paramAnimationId);
}


// 实现动画效果的简单方法（通过 animateWithDuration）
- (void)startAnimation2
{
    // animateWithDuration - 执行一段动画
    // 第 1 个参数：动画时长
    // 第 2 个参数：动画的延迟开始时间
    // 第 3 个参数：动画选项，参见：UIViewAnimationOptions 枚举
    // 第 4 个参数：一个 block，用于设置动画完成后的结果
    // 第 5 个参数：一个 block，动画完成
    [UIView animateWithDuration:2.0f delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut animations:^(void)
    {
        self.imageView2.frame = CGRectMake(200, 300, 100, 100);
    } completion:^(BOOL finished)
    {
        // YES 代表动画正常结束
    }];
}


// 角度转弧度
- (float)degreesToRadians:(float)degrees
{
    return M_PI * degrees / 180.0;
}

@end
