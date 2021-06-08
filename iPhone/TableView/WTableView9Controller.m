//
// 演示如何在 UITableView 中拖动 cell 以完成 cell 排序的操作
//

#import "WTableView9Controller.h"

@interface WTableView9Controller () <UITableViewDataSource, UITableViewDelegate>
{
    // 数据源
    NSMutableArray *_array;
}

@property (nonatomic, strong) UIBarButtonItem *buttonEdit;

@end

@implementation WTableView9Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据源
    _array = [[NSMutableArray alloc] initWithArray:@[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
    
    // 让 tableView 处于编辑模式（只有处于编辑模式，才能拖动）
    self.editing = YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
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

// 指定的 cell 是否允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 指定的 cell 是否允许拖动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// cell 被拖动后，即 cell 排序发生变化时
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 对数据源做重新排序（tableView 的重新排序已经由系统做好了）
    NSString *text = [_array objectAtIndex:sourceIndexPath.row];
    [_array removeObjectAtIndex:sourceIndexPath.row];
    [_array insertObject:text atIndex:destinationIndexPath.row];
}


#pragma mark -
#pragma mark UITableViewDelegate
// cell 处于编辑模式时的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

@end
