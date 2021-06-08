//
// 演示如何通过 UITableView 显示列表数据（多种内置样式）
//
// 与其说是 TableView 不如说是 ListView，因为每行其实只有一列
// UITableView 继承自 UIScrollView
//
//
// 每个 UITableView 从上到下分别是
// 1、table header
// 2、一个或多个 table section
// 3、table footer
//
// 每个 table section 从上到下分别是
// 1、section header
// 2、table cell
// 3、section footer
//

#import "WTableView1Controller.h"

// UITableView 有两个重要的协议，分别是：UITableViewDataSource 和 UITableViewDelegate
@interface WTableView1Controller () <UITableViewDataSource>
{
    // 数据源
    NSArray *_array;
    
    // 单元格样式
    UITableViewCellStyle _cellStyle;
}

@end

@implementation WTableView1Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据源
    _array = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    // 指定单元格的默认样式，UITableViewCellStyle 枚举
    _cellStyle = UITableViewCellStyleDefault;
 
    // 指定实现 UITableViewDataSource 协议的对象
    self.tableView.dataSource = self;

    // 设置 table header
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    headerLabel.text = @"table header";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.backgroundColor = [UIColor blueColor];
    self.tableView.tableHeaderView = headerLabel;
    
    // 设置 table footer
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    footerLabel.text = @"table footer";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.backgroundColor = [UIColor blueColor];
    self.tableView.tableFooterView = footerLabel;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
}


// 用于演示不同单元格样式的效果
// 不好描述，还是直接看 demo 吧
#pragma mark -
#pragma mark button action
- (IBAction)btnCellStyleDefault:(id)sender
{
    _cellStyle = UITableViewCellStyleDefault;
    // 改变样式后要重新加载数据
    [self.tableView reloadData];
}

- (IBAction)btnCellStyleSubtitle:(id)sender
{
    _cellStyle = UITableViewCellStyleSubtitle;
    // 改变样式后要重新加载数据
    [self.tableView reloadData];
}

- (IBAction)btnCellStyleValue1:(id)sender
{
    _cellStyle = UITableViewCellStyleValue1;
    // 改变样式后要重新加载数据
    [self.tableView reloadData];
}

- (IBAction)btnCellStyleValue2:(id)sender
{
    _cellStyle = UITableViewCellStyleValue2;
    // 改变样式后要重新加载数据
    [self.tableView reloadData];
}


#pragma mark -
#pragma mark UITableViewDataSource
// 返回指定的 section 的总行数（注意：默认只有一个 section）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

// 构造 cell 时（这是根据你的 numberOfSectionsInTableView 和 numberOfRowsInSection 的设置来决定如何调用这个函数的，本例只有一个 section，所以只设置了 numberOfRowsInSection）
// 返回指定 section 的指定 row 的 UITableViewCell，即设置指定 section 的指定 row 的 UITableViewCell
// NSIndexPath.section 代表当前 section 的索引位置
// NSIndexPath.row 代表当前行在当前 section 的索引位置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // static NSString *reusableCellQueueId = @"reusableCellQueueId";
    
    // 什么是可重用 cell 队列？
    // 一个 table 会有多个 cell，如果太多的话性能耗不起，由于每次能够显示的 cell 是有限的，所以 ios 会为 table 维护一个 cell 队列
    // 每次显示 cell 的时候先从 cell 队列中请求一个 cell 来显示，如果 cell 队列里没有可用的 cell，则创建一个新的 cell 使用，并把此 cell 放入 cell 队列
    // 我们要做的只是指定一个 cell 队列的名字即可
    
    // 为不同的 cell style 指定不同的 cell 队列名称（注意：这个队列对于 app 来说是全局的，所以指定名称的时候不要重复）
    NSString *reusableCellQueueId = [NSString stringWithFormat:@"WTableView1Controller_reusableCellQueueId_%i", _cellStyle];
    // 从 cell 队列中请求 cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellQueueId];
    
    // cell 队列中没有可用的 cell
    if (cell == nil)
    {
        // 按指定的 cell style 创建一个新的 cell，并将其放入指定的 cell 队列
        cell =[[UITableViewCell alloc] initWithStyle:_cellStyle reuseIdentifier:reusableCellQueueId];
    }
    
    // cell 的文字内容 1
    cell.textLabel.text = [_array objectAtIndex:[indexPath row]];
    // cell 的文字内容 2
    cell.detailTextLabel.text = @"detailText";
    // cell 的图标
    cell.imageView.image = [UIImage imageNamed:@"A.png"];
    // cell 的高亮图标（即 cell 被选中时的图标）
    cell.imageView.highlightedImage = [UIImage imageNamed:@"B.png"];
    
    // 返回我们为此 section 此 row 创建的 cell
    return cell;
}

@end
