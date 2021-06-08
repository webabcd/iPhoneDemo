//
// 演示如何实现过渡效果
//
// 本例演示显示不同的 view 时的过渡效果
//

#import "WTransitionDemoController.h"

@interface WTransitionDemoController ()

@end

@implementation WTransitionDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化 2 个 view（一个红色的view，一个绿色的view），用于演示显示不同的 view 时的过渡效果
    UIView *redView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    redView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:redView atIndex:0];
    
    UIView *greenView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view insertSubview:greenView atIndex:0];
}


#pragma mark -
#pragma mark setAnimationTransition
// 演示 UIViewAnimationTransitionFlipFromLeft 过渡动画（通过 setAnimationTransition）
- (IBAction)button1Pressed:(id)sender
{
    [UIView beginAnimations:@"myAnimation" context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    // 设置过渡效果
    // 第 1 个参数：过渡动画的类型（UIViewAnimationTransition 枚举）
    //   UIViewAnimationTransitionNone - 无
    //   UIViewAnimationTransitionFlipFromLeft, UIViewAnimationTransitionFlipFromRight - 中线旋转
    //   UIViewAnimationTransitionCurlUp, UIViewAnimationTransitionCurlDown - 翻页
    // 第 2 个参数：过渡效果所应用到的 view
    // 第 3 个参数：过渡中，是否将 view 以图片的方式缓存，以提高效率
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    // 设置动画完成后的结果
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    [UIView commitAnimations];
}

// 演示 UIViewAnimationTransitionCurlUp 过渡动画（通过 setAnimationTransition）
- (IBAction)button2Pressed:(id)sender
{
    [UIView beginAnimations:@"myAnimation" context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    // 设置过渡效果
    // 第 1 个参数：过渡动画的类型（UIViewAnimationTransition 枚举）
    //   UIViewAnimationTransitionNone - 无
    //   UIViewAnimationTransitionFlipFromLeft, UIViewAnimationTransitionFlipFromRight - 中线旋转
    //   UIViewAnimationTransitionCurlUp, UIViewAnimationTransitionCurlDown - 翻页
    // 第 2 个参数：过渡效果所应用到的 view
    // 第 3 个参数：过渡中，是否将 view 以图片的方式缓存，以提高效率
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    
    // 设置动画完成后的结果
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark CATransition
// 演示 kCATransitionMoveIn, kCATransitionFromTop 过渡动画（通过 CATransition）
- (IBAction)button3Pressed:(id)sender
{
    // CATransition - 过渡动画
    CATransition *transition = [CATransition animation];
    // 过渡动画的时长
    transition.duration = 2.0f;
    // 过渡动画的类型
    //   kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal
    //   @"cube", @"suckEffect", @"oglFlip", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose";
    transition.type = kCATransitionMoveIn;
    // 过渡动画的子类型
    //   kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom;
    transition.subtype = kCATransitionFromTop;
    
    // 动画开始的位置（0 - 1 之间）
    // transition.startProgress = 0.3;
    // 动画结束的位置（0 - 1 之间），最终还是会转到最终位置（即 1 的位置）
    // transition.endProgress = 0.7;
    
    // 设置动画完成后的结果
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    // 开始过渡动画
    // 第 1 个参数：CATransition
    // 第 2 个参数：动画的 id
    [self.view.layer addAnimation:transition forKey:@"myAnimation"];
}

// 演示 cube, kCATransitionFromTop 过渡动画（通过 CATransition）
- (IBAction)button4Pressed:(id)sender
{
    // CATransition - 过渡动画
    CATransition *transition = [CATransition animation];
    // 过渡动画的时长
    transition.duration = 2.0f;
    // 过渡动画的类型
    //   kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal
    //   @"cube", @"suckEffect", @"oglFlip", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"cameraIrisHollowOpen", @"cameraIrisHollowClose";
    transition.type = @"cube";
    // 过渡动画的子类型
    //   kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom;
    transition.subtype = kCATransitionFromLeft;
    
    // 动画开始的位置（0 - 1 之间）
    // transition.startProgress = 0.3;
    // 动画结束的位置（0 - 1 之间），最终还是会转到最终位置（即 1 的位置）
    // transition.endProgress = 0.7;
    
    // 设置动画完成后的结果
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    // 开始过渡动画
    // 第 1 个参数：CATransition
    // 第 2 个参数：动画的 id
    [self.view.layer addAnimation:transition forKey:@"myAnimation"];
}


#pragma mark -
#pragma mark transitionWithView
// 实现过渡效果的简单方法（通过 transitionWithView）
- (IBAction)button5Pressed:(id)sender
{
    // transitionWithView - 执行一段过渡动画效果
    // 第 1 个参数：过渡效果所应用到的 view
    // 第 2 个参数：过渡动画时长
    // 第 3 个参数：过渡动画选项，参见：UIViewAnimationOptions 枚举
    // 第 4 个参数：一个 block，用于设置过渡动画完成后的结果
    // 第 5 个参数：一个 block，过渡动画完成
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromLeft animations:^
    {
        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    } completion:^(BOOL finished)
    {
       // YES 代表过渡动画正常结束
    }];
}

@end
