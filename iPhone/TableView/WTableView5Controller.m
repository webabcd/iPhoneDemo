//
// 演示 cell 右侧扩展按钮（disclosure button）的应用
//
// 注：点击 cell 和点击 disclosure button 会触发不同的事件
//

#import "WTableView5Controller.h"

@interface WTableView5Controller () <UITableViewDataSource, UITableViewDelegate>
{
    // 数据源
    NSArray *_array;
}

@end

@implementation WTableView5Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据源
    _array = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
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
    
    
    // 让不同的 cell 显示不同的 disclosure button（UITableViewCellAccessoryCheckmark 枚举）
    // 通过 UITableViewCell 的 accessoryType 来实现
    if (indexPath.row % 6 == 0)
    {
        // 对勾
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (indexPath.row % 6 == 1)
    {
        // 叹号
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    else if (indexPath.row % 6 == 2)
    {
        // 叹号和右箭头（箭头不会触发 accessoryButtonTappedForRowWithIndexPath 事件）
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else if (indexPath.row % 6 == 3)
    {
        // 右箭头（箭头不会触发 accessoryButtonTappedForRowWithIndexPath 事件）
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row % 6 == 4)
    {
        // 无
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if (indexPath.row % 6 == 5)
    {
        // 自定义
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitle:@"展开" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        // 响应自定义 disclosure button 的点击事件，参看 buttonPressed: 函数
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        // 通过 UITableViewCell 的 accessoryView 来自定义 disclosure button
        cell.accessoryView = button;
    }
    
    return cell;
}

- (void)buttonPressed:(UIButton *)button
{
    // 获取被点击的自定义 disclosure button 的所属 UITableViewCell，然后就知道是哪个 cell 的 disclosure button 被点击了
    UITableViewCell *cell = (UITableViewCell *)button.superview;
    if (cell != nil)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        // 此 cell 在当前 section 中的行索引
        int row = [indexPath row];
        // 此 cell 中的文字内容
        NSString *rowValue = [_array objectAtIndex:row];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"customButton(%i: %@)", row, rowValue] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];

    }
}


#pragma mark -
#pragma mark UITableViewDelegate
// 内置 disclosure button 被点击了
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // 此 cell 在当前 section 中的行索引
    int row = [indexPath row];
    // 此 cell 中的文字内容
    NSString *rowValue = [_array objectAtIndex:row];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"accessoryButton(%i: %@)", row, rowValue] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertView show];
}

// cell 被选中时（点击 cell 和点击 disclosure button 会触发不同的事件）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 此 cell 在当前 section 中的行索引
    int row = [indexPath row];
    // 此 cell 中的文字内容
    NSString *rowValue = [_array objectAtIndex:row];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"cell(%i: %@)", row, rowValue] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertView show];
}

@end
