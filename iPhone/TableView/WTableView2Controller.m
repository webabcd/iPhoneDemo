//
// 演示如何通过 UITableView 显示列表数据（定义样式和行为）
//

#import "WTableView2Controller.h"

@interface WTableView2Controller ()<UITableViewDataSource, UITableViewDelegate>
{
    // 数据源
    NSArray *_array;
}

@end

@implementation WTableView2Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据源
    _array = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
}


// 实现 UITableViewDataSource 协议，详细说明请见 WTableView1Controller
#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableCellQueueId = @"WTableView2Controller_reusableCellQueueId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellQueueId];
    
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellQueueId];
    }
    
    // 下面这些对于不变的应该放到 if (cell == nil){} 中去做
    cell.textLabel.text = [_array objectAtIndex:[indexPath row]];
    cell.detailTextLabel.text = @"detailText";
    cell.imageView.image = [UIImage imageNamed:@"A.png"];
    cell.imageView.highlightedImage = [UIImage imageNamed:@"B.png"];
    
    return cell;
}


// 以下介绍一部分 UITableViewDelegate 协议，更多的请参看文档
#pragma mark -
#pragma mark UITableViewDelegate
// 指定 cell 的缩进级别，以自动实现缩进效果
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 返回的数值越大，缩进则越大
    int level = [indexPath row];
    return level;
}

// cell 将要被选中时
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 偶数行允许被选中，奇数行不允许被选中
    int row = [indexPath row];
    if (row % 2 ==0)
        return nil; // 奇数行不允许被选中
    return indexPath; // 偶数行允许被选中
}

// cell 被选中时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 此 cell 在当前 section 中的行索引
    int row = [indexPath row];
    // 此 cell 中的文字内容
    NSString *rowValue = [_array objectAtIndex:row];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%i: %@", row, rowValue] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertView show];
    
    // 取消 cell 的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 指定 cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
