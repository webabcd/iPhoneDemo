//
// 演示 UIPageViewController 的应用
//

#import "WPageViewControllerController.h"
#import "WPageViewContentController.h"

@interface WPageViewControllerController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// 是否处于翻页动画之中
@property (nonatomic) BOOL pageIsAnimating;

// UIPageViewController
@property (nonatomic, strong) UIPageViewController *pageViewController;
// 每一页的内容数组，每一页的内容都是一个 WPageViewContentController 对象（参见 WPageViewContentController.m）
@property (nonatomic, strong) NSMutableArray *pageContents;

@end

@implementation WPageViewControllerController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.pageIsAnimating = NO;
    
    NSArray *array = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    // 初始化内容数组
    self.pageContents = [[NSMutableArray alloc] init];
    for (NSString *str in array)
    {
        // 每一页的内容都是一个 WPageViewContentController 对象
        UIStoryboard *s = [UIStoryboard storyboardWithName:@"Controller" bundle:nil];
        WPageViewContentController *pageContent = [s instantiateViewControllerWithIdentifier:@"PageViewContent"];
        pageContent.displayString = str;
        
        [self.pageContents addObject:pageContent];
    }
    
    
    NSDictionary *options= [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
    // 实例化 UIPageViewController
    //     第 1 个参数：翻页方式。UIPageViewControllerTransitionStylePageCurl - 书籍翻页，UIPageViewControllerTransitionStyleScroll - 滚动翻页
    //     第 2 个参数：翻页方向。UIPageViewControllerNavigationOrientationHorizontal - 水平翻页， UIPageViewControllerNavigationOrientationVertical - 垂直翻页
    //     第 3 个参数：
    //         当 UIPageViewControllerTransitionStylePageCurl 时 key 是 UIPageViewControllerOptionSpineLocationKey，可以设置书脊的大小（一个 UIPageViewControllerSpineLocation 枚举）
    //         当 UIPageViewControllerTransitionStyleScroll 时 key 是 UIPageViewControllerOptionInterPageSpacingKey，可以设置两页间的间距（一个浮点型）
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
 
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.pageViewController.view.frame = self.view.bounds;
    
    
    // 指定 UIPageViewController 的初始显示数据（如果每次显示 1 页，则指定 1 个即可；如果每次显示 2 页，则需要指定 2 个）
    WPageViewContentController *firstPageContent = (WPageViewContentController *)[self.pageContents objectAtIndex:0];
    [self.pageViewController setViewControllers:@[firstPageContent] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    // 将 UIPageViewController 添加进来
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark UIPageViewControllerDataSource
// 翻下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    // 上一次的翻页动画结束后才能进行下一步，否则会出现 “Unbalanced calls to begin/end appearance transitions”
    if (self.pageIsAnimating)
        return nil;
    
    NSUInteger index = [self.pageContents indexOfObject:viewController];
    if (index == self.pageContents.count - 1 || index == NSNotFound)
        return nil;
    
    return (WPageViewContentController *)[self.pageContents objectAtIndex:++index];
}

// 翻上一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    // 上一次的翻页动画结束后才能进行下一步，否则会出现 “Unbalanced calls to begin/end appearance transitions”
    if (self.pageIsAnimating)
        return nil;
    
    NSUInteger index = [self.pageContents indexOfObject:viewController];
    if (index == 0 || index == NSNotFound)
        return nil;
    
    return (WPageViewContentController *)[self.pageContents objectAtIndex:--index];
}


#pragma mark -
#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    // 翻页动画开始
    self.pageIsAnimating = YES;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // 翻页操作完成或被取消，则翻页动画结束
    if (finished || completed)
    {
        self.pageIsAnimating = NO;
    }
}

@end
