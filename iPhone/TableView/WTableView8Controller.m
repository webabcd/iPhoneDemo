//
// 演示如何在 UITableView 的编辑状态下，对 cell 做新增、删除和批量删除操作
//
// 注：本例仅演示批量删除
//

#import "WTableView8Controller.h"

@interface WTableView8Controller () <UITableViewDataSource, UITableViewDelegate>
{
    // 原始数据源
    NSMutableArray *_array;
    
    // 需要删除的数据
    NSMutableDictionary *_removeDict;
}

// 编辑按钮
@property (nonatomic, strong) UIBarButtonItem *buttonEdit;
// 取消按钮
@property (nonatomic, strong) UIBarButtonItem *buttonCancel;
// 删除按钮
@property (nonatomic, strong) UIBarButtonItem *buttonDelete;

@end

@implementation WTableView8Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 构造数据源
    _array = [[NSMutableArray alloc] initWithArray:@[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"]];
    // 初始化“需要删除的数据”
    _removeDict = [[NSMutableDictionary alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 初始化编辑按钮和取消按钮
    self.buttonEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(buttonEditPressed:)];
    self.buttonCancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(buttonCancelPressed:)];
    [self.navigationItem setRightBarButtonItem:self.buttonEdit];
    
    // 初始化删除按钮
    self.buttonDelete = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(buttonDeletePressed:)];
    [self.toolBar setItems:[[NSArray alloc] initWithObjects:self.buttonDelete, nil]];
 
    self.tableView.backgroundColor = [UIColor orangeColor];
}

// 编辑按钮被按下时
- (void)buttonEditPressed:(id)sender
{
    // 让 tableView 处于编辑模式
    [self.tableView setEditing:YES animated:YES];
    // 编辑按钮变为取消按钮
    [self.navigationItem setRightBarButtonItem:self.buttonCancel];
}

// 取消按钮被按下时
- (void)buttonCancelPressed:(id)sender
{
    // 让 tableView 退出编辑模式
    [self.tableView setEditing:NO animated:YES];
    // 取消按钮变为编辑按钮
    [self.navigationItem setRightBarButtonItem:self.buttonEdit];
    
    // 清空“需要删除的数据”
    [_removeDict removeAllObjects];
}

// 删除按钮被按下时
- (void)buttonDeletePressed:(id)sender
{
    // 删除数据源中“需要删除的数据”
    [_array removeObjectsInArray:_removeDict.allKeys];
    
    // 删除 tableView 中“需要删除的数据”
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:_removeDict.allValues] withRowAnimation:UITableViewRowAnimationFade];
    
    // 清空“需要删除的数据”
    [_removeDict removeAllObjects];
    
    
    // 注意：当你需要在 UITableView 中一次调用多遍 insert delete 时，需要将他们包裹在 beginUpdates 和 endUpdates 之中
    // [self.tableView beginUpdates];
    // [self.tableView endUpdates];
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

// 指定的 cell 是否允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 第 1 行不能编辑
    if (indexPath.row == 0)
        return NO;
    return YES;
}


#pragma mark -
#pragma mark UITableViewDelegate
// cell 处于编辑模式时的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 对 UITableViewCellEditingStyle 说明如下：
    //     UITableViewCellEditingStyleDelete - 支持滑动删除；或者当 tableView 处于编辑模式时，在 cell 的前面显示删除按钮
    //     UITableViewCellEditingStyleInsert - 当 tableView 处于编辑模式时，在 cell 的前面显示新增按钮
    //     UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert - 当 tableView 处于编辑模式时，在 cell 的前面显示复选框按钮
    //     UITableViewCellEditingStyleNone - 啥都没有
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

// cell 被选中时所触发的事件，本例用于更新“需要删除的数据”
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing)
        [_removeDict setObject:indexPath forKey:[_array objectAtIndex:indexPath.row]];
}

// cell 被取消选中时所触发的事件，本例用于更新“需要删除的数据”
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing)
        [_removeDict removeObjectForKey:[_array objectAtIndex:indexPath.row]];
}

@end