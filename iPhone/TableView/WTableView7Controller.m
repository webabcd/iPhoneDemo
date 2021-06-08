//
// 演示如何实现 cell 的滑动删除
//

#import "WTableView7Controller.h"
#import "WTableView5Controller.h"

@interface WTableView7Controller () <UITableViewDataSource, UITableViewDelegate>
{
    // 数据源
    NSMutableArray *_array;
}

@end

@implementation WTableView7Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据源
    _array = [[NSMutableArray alloc] initWithArray:@[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
}

// 从此页离开的时候，要将 tableView 的 editing 设置为 NO，否则会出现异常
- (void)viewWillDisappear:(BOOL)animated
{
    self.tableView.editing = NO;
    [super viewWillDisappear:animated];
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

// 当用户动过滑动删除，或者 cell 前面的删除按钮删除时，所触发的事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row < _array.count)
        {
            // 删除数据源中对应的数据
            [_array removeObjectAtIndex:indexPath.row];
            // 删除 tableView 中对应的数据
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            // 关于 tableView 的 row 和 section 增删操作还有一些常用的函数如下：
            // [self.tableView insertRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
            // [self.tableView deleteSections:<#(NSIndexSet *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
            // [self.tableView insertSections:<#(NSIndexSet *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
        }
    }
}


#pragma mark -
#pragma mark UITableViewDelegate
// 返回 cell 在编辑模式下的样式，只是想滑动删除的话返回 UITableViewCellEditingStyleDelete 即可，更多内容参见 WTableView8Controller
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// 滑动删除的删除按钮上显示的文本内容
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
