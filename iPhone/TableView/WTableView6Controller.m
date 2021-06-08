//
// 演示如何为 cell 增加上下文菜单
//
// 此处演示的 cell 上下文菜单均是内置支持的上下文菜单类型
//

#import "WTableView6Controller.h"

@interface WTableView6Controller () <UITableViewDataSource, UITableViewDelegate>
{
    // 数据源
    NSArray *_array;
}

@end

@implementation WTableView6Controller

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
 
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate
// 是否应该显示此 cell 的上下文菜单
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// long press 某一行，就会显示上下文菜单
// long press 某一行后，此行的所有可能支持的内置上下文菜单类型都会执行一下此函数
-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    // 显示支持的全部内置上下文菜单类型
    NSLog(@"%@", NSStringFromSelector(action));
    // cut: copy: select: selectAll: paste: delete: _promptForReplace: _showTextStyleOptions: _define: _addShortcut: _accessibilitySpeak: _accessibilitySpeakLanguageSelection: _accessibilityPauseSpeaking: makeTextWritingDirectionRightToLeft: makeTextWritingDirectionLeftToRight:
    
    // 需要支持此类型的上下文菜单，则返回会 YES
    if (action == @selector(copy:))
        return YES;
    
    return NO;
}

// 上下文菜单中的按钮被 tap 的时候
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    // 判断此上下文菜单按钮的类型
    if (action == @selector(copy:))
    {
        // 实现 copy 文本到剪切板
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setString:cell.textLabel.text];
    }
}

@end