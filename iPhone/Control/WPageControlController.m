//
// 演示 UIPageControl 的应用
//
// 注：如需要自定义小点点的话，则继承 UIPageControl，然后通过 [UIPageControl.subviews objectAtIndex:index] 获取到 UIImageView 后修改图片即可
//

#import "WPageControlController.h"

@interface WPageControlController ()<UIScrollViewDelegate>
{
    // 用于显示小点点的控件
    UIPageControl *pageControl;
    
    // 用于实现分页滚动的控件
    UIScrollView *scrollView;
}

@end

@implementation WPageControlController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化 UIPageControl（用于显示小点点的控件）
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, 300, 300, 20)];
    pageControl.backgroundColor = [UIColor orangeColor];
    // 小点点的数量
    pageControl.numberOfPages = 10;
    // 当前显示的小点点的索引位置
    pageControl.currentPage = 0;
    // 如果只有一个点的话是否隐藏
    pageControl.hidesForSinglePage = YES;
    
    // 未被选中的小点点的颜色
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    // 被选中的小点点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    // 调整 UIPageControl 的尺寸，以适合小点点们
    // [pageControl sizeToFit];
    // 根据小点点的数量，获取 UIPageControl 的一个合适的尺寸
    // [pageControl sizeForNumberOfPages:<#(NSInteger)#>];
    
    // target/action
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:pageControl];
    self.view.backgroundColor = [UIColor blueColor];
    
    
    
    // 实例化 UIScrollView（用于实现分页滚动的控件）
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    scrollView.contentSize = CGSizeMake(3000, 200);
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.delegate = self;
    
    // 为 UIScrollView 的每一页添加内容
    for (int i=0; i<10; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * 300, 0, 300, 100)];
        label.text = [NSString stringWithFormat:@"label %i", i];
        [scrollView addSubview:label];
    }
    
    [self.view addSubview:scrollView];
}


// UIPageControl 的 currentPage 发生变化了，则自动滚动 UIScrollView
- (void)changePage:(id)sender
{
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(300 * page, 0) animated:YES];
}


// UIScrollView 翻页了，则自动修改 UIPageControl 的 currentPage
- (void)scrollViewDidScroll:(UIScrollView *)myScrollView { }
- (void)scrollViewDidEndDecelerating:(UIScrollView *)myScrollView
{
    int page = scrollView.contentOffset.x / 300;
    pageControl.currentPage = page;
}

@end
