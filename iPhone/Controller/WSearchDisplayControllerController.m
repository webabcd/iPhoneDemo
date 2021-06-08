//
// 演示 UISearchDisplayController 的应用
//
// 注：UISearchDisplayController 其实并不是一个 Controller，因为他的父类是 NSObject，它里面整合了 UISearchBar 和 UITableView
//
//
// 结构如下：
// UISearchDisplayController 管理一个 UISearchBar 和一个用于显示搜索结果的 UITableView
// UISearchDisplayController 之外有一个用于显示原始数据的 UITableView，和一个与 UISearchDisplayController 共用的 UISearchBar
// 也就是说整个场景有 3 个控件：2 个 UITableView 和 1 个 UISearchBar
//

#import "WSearchDisplayControllerController.h"

@interface WSearchDisplayControllerController ()<UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UISearchDisplayController *mySearchDisplayController;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;

// 原始 tableview 的数据源
@property (nonatomic, strong) NSArray *array1;
// 搜索结果 tableview 的数据源
@property (nonatomic, strong) NSMutableArray *array2;

@end

@implementation WSearchDisplayControllerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 构造原始 tableview 的数据源
    self.array1 = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    // 构造搜索结果 tableview 的数据源
    self.array2 = [[NSMutableArray alloc] initWithArray:[self.array1 copy]];
    
    // 实例化 UISearchBar
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar sizeToFit]; // 没这句的话 UITableView 可能会被 UISearchBar 遮住一点
    
    // 实例化用于显示原始数据的 tableview
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.searchBar;

    // 将用于显示原始数据的 tableview 添加进来
    [self.view addSubview:self.tableView];
    
    // 实例化 UISearchDisplayController（第一个参数：UISearchBar 对象；第二个参数：管理原始数据的 Controller）
    self.mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.mySearchDisplayController.delegate = self;
    self.mySearchDisplayController.searchResultsDataSource = self; // 搜索结果的 tableview 的 DataSource
    self.mySearchDisplayController.searchResultsDelegate = self; // 搜索结果的 tableview 的 Delegate
    
    // for ios7
    self.edgesForExtendedLayout = UIRectEdgeNone;
}



#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) // 显示原始数据的 tableview
    {
        return self.array1.count;
    }
    else if (tableView == self.mySearchDisplayController.searchResultsTableView) // 显示搜索结果的 tableview
    {
        return self.array2.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) // 显示原始数据的 tableview
    {
        static NSString *reusableCellQueueId = @"WSearchDisplayControllerController_reusableCellQueueId1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellQueueId];
    
        if (cell == nil)
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellQueueId];
    
        cell.textLabel.text = [self.array1 objectAtIndex:[indexPath row]];
        
        return cell;
    }
    else if (tableView == self.mySearchDisplayController.searchResultsTableView) // 显示搜索结果的 tableview
    {
        static NSString *reusableCellQueueId = @"WSearchDisplayControllerController_reusableCellQueueId2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellQueueId];
        
        if (cell == nil)
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellQueueId];
        
        cell.textLabel.text = [self.array2 objectAtIndex:[indexPath row]];
        
        return cell;
    }
    
    return nil;
}

// 在 UISearchBar 中每输入一个字符后触发的事件
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.array2 removeObjectAtIndex:0];

    return YES;
}

@end
