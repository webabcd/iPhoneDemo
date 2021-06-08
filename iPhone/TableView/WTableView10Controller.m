//
// 演示如何通过 UITableViewController 实现下拉刷新
//
// 注意：
// 1、这里需要继承的是 UITableViewController, 而不是 UIViewController
// 2、仅 ios6 或以上支持
// 3、建议使用第三方开源库来实现下拉刷新：EGOTableViewPullRefresh
//


#import "WTableView10Controller.h"

@interface WTableView10Controller () <UITableViewDataSource>
{
    // 数据源
    NSArray *_array;
}

@end

@implementation WTableView10Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据源
    _array = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];

    
    // 初始化 UITableViewController 的 UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    // 设置 UIRefreshControl 的颜色
    self.refreshControl.tintColor = [UIColor blueColor];
    // 设置 UIRefreshControl 的显示文本
    // self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    // target/action，用于捕获当 UIRefreshControl 显示时触发的事件
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
}

// UIRefreshControl 显示了
- (void)refreshTableView:(id)sender
{
    // 模拟长时任务
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delayInSeconds);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        // 2 秒后隐藏 UIRefreshControl（通过 endRefreshing 停止 UIRefreshControl）
        [self.refreshControl endRefreshing];
        
    });
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableCellQueueId = @"WTableView5Controller_reusableCellQueueId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellQueueId];
    
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellQueueId];
    }
    
    cell.textLabel.text = [_array objectAtIndex:[indexPath row]];
    cell.detailTextLabel.text = @"detailText";
    
    return cell;
}


@end