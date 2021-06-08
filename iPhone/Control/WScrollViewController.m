// 关于为 UIScrollView 中再加一个 panGestureRecognizer 也要详细写，见qipa停车
// UIScreenEdgePanGestureRecognizer 要写
// www.cnblogs.com/lexingyu/p/3702742.html


//
// 演示 UIScrollView 的应用
//
// 关于分页滚动效果请参看：WPageControlController.m
//

#import "WScrollViewController.h"

@interface WScrollViewController () <UIScrollViewDelegate>

@end

@implementation WScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 实例化一个 UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 200, 280, 200)];
    
    // 构造一个需要放到 UIScrollView 中的 UIView，并添加进 UIScrollView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
    imageView.image = [UIImage imageNamed:@"Son.jpg"];
    [scrollView addSubview:imageView];
    
    // 设置 contentSize，即需要滚动的内容的宽和高
    scrollView.contentSize = CGSizeMake(1000, 1000);
    
    // contentOffset 代表 UIScrollView 的左上角原点相对于 content 的左上角原点的偏移量
    scrollView.contentOffset = CGPointMake((1000 - 280) / 2, (1000 - 200) / 2); // 将内容居中
    
    // 一次拖动过程是否只允许向一个方向（水平或垂直）滚动，类似 win8 的 rail
    scrollView.directionalLockEnabled = NO;
    
    // 是否显示水平滚动条（拖动过程中是否显示）
    scrollView.showsHorizontalScrollIndicator = YES;
    // 是否显示垂直滚动条（拖动过程中是否显示）
    scrollView.showsVerticalScrollIndicator = YES;
    // 显示一下滚动条，但是过一会就会消失
    [scrollView flashScrollIndicators];
    // 滚动条的样式（UIScrollViewIndicatorStyleDefault, UIScrollViewIndicatorStyleBlack, UIScrollViewIndicatorStyleWhite）
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    
    
    // contentInset 相当于内容的 padding，4 个值分别是“上左下右”
    // scrollView.contentInset = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    
    // 设置 contentOffset，可以选择是否需要动画效果
    // scrollView setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>];
    
    
    // 获取内容的当前的显示区域（相对于内容左上角原点的位置）
    // 如果没有拖动的话，本例中的值就是：360, 400, 280, 200
    // CGRect visibleRect = [scrollView convertRect:scrollView.bounds toView:imageView];
    
    // 由程序控制，滚动到指定矩形区域
    // [scrollView scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>];
    
    
    // 设置 zoom 所允许的倍数，同时配合 UIScrollViewDelegate 协议中的 viewForZoomingInScrollView 即可完成 zoom
    // 模拟器上按住 option 键测试缩放
    scrollView.minimumZoomScale = 0.5f;
    scrollView.maximumZoomScale = 2.0f;
    
    // 由程序控制缩放
    // [scrollView setZoomScale:<#(CGFloat)#> animated:<#(BOOL)#>];
    // [scrollView zoomToRect:<#(CGRect)#> animated:<#(BOOL)#>];
    
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];

    
    // 以下是几个常用属性
    // scrollView.scrollEnabled - 是否支持滚动
    // scrollView.decelerationRate - 拖动松手后，惯性滚动的速率
    // scrollView.pagingEnabled - 拖动时，是否按照 ScrollView 的大小的整倍数滚动（即分页滚动）
    // scrollView.bounces - 是否允许滚出边界，然后来一个反弹的效果。NO 的话滚动到边界则立刻停止
    // scrollView.bouncesZoom - zoom 版的 bounces
    // scrollView.zoomScale - zoom 的比例
    // scrollView.delaysContentTouches - 是否延迟捕获内容（本例就是 imageView）的 touch 事件
    // scrollView.canCancelContentTouches - 是否可以取消内容（本例就是 imageView）的 touch 事件

    
    // 以下是几个只读的常用属性
    // scrollView.tracking - touch 后还没有拖动时是 YES，否则是 NO
    // scrollView.zoomBouncing - 当内容缩放到最大值或最小值时是 YES，否则是 NO
    // scrollView.zooming - 是否在缩放中
    // scrollView.decelerating - 拖动松手后，是否还在惯性滚动
}

#pragma mark -
#pragma mark UIScrollViewDelegate
// contentOffset 发生变化时所触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.lblMsg.text = [NSString stringWithFormat:@"contentOffset: %i,%i\n", (int)scrollView.contentOffset.x, (int)scrollView.contentOffset.y];
}

// 在这里设置需要被 zoom 的 UIView（之前要设置好 minimumZoomScale 属性和 maximumZoomScale 属性，然后就可以通过手势 zoom 了）
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return (UIView *)[scrollView.subviews objectAtIndex:0];
}

// zoom 发生变化时触发的事件
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *imageView = (UIImageView *)[scrollView.subviews objectAtIndex:0];
    self.lblMsg2.text = [NSString stringWithFormat:@"frame: %i,%i,%i,%i\n", (int)imageView.frame.origin.x, (int)imageView.frame.origin.y, (int)imageView.frame.size.width, (int)imageView.frame.size.height];
}

// zoom 完成后触发的事件（scale 是缩放倍数）
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.lblMsg2.text = [NSString stringWithFormat:@"scale: %f", scale];
}

// 开始拖拽时触发的事件（按住图片不动，然后拖动）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lblMsg3.text = @"开始拖拽";
}

// 拖拽完成后触发的事件（松手后即触发，而不是等动画停止）
// decelerate - 拖拽之后是否会出现减速的效果（拖拽松手后如果有惯性则此值为 YES，如果拖拽松手后没有惯性则此值为 NO）
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.lblMsg3.text = [self.lblMsg3.text stringByAppendingFormat:@" %@ %i", @"完成拖拽", decelerate];
}

// 拖拽松手后出现惯性减速时触发的事件 
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.lblMsg3.text = [self.lblMsg3.text stringByAppendingString:@" begin"];
}

// 拖拽松手后出现的惯性减速完成后触发的事件 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.lblMsg3.text = [self.lblMsg3.text stringByAppendingString:@" end"];
}

// 拖动后，点击顶部状态栏是否需要把 ScrollView 中的内容移到顶端
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // 默认返回 YES
    return YES;
}

// 拖动后，点击顶部状态栏，ScrollView 中的内容被移到顶端后所触发的事件
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    self.lblMsg4.text = @"ScrollView 中的内容被移到顶端";
}

@end
