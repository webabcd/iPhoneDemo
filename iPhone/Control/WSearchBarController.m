//
// 演示 UISearchBar 的应用
//

#import "WSearchBarController.h"

@interface WSearchBarController ()<UISearchBarDelegate>

@end

@implementation WSearchBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // UISearchBar 的样式
    self.searchBar.barStyle = UIBarStyleDefault;
    
    // UISearchBar 输入框上面显示的文字
    self.searchBar.prompt = @"prompt";
    // 输入框内的 placeholder
    self.searchBar.placeholder = @"placeholder";
    // 输入框中的内容
    // self.searchBar.text = @"text";
    
    // 是否显示 cancel 按钮
    self.searchBar.showsCancelButton = YES;
    // 在没有文字的时候，输入框右侧显示的一个 search 按钮
    self.searchBar.showsSearchResultsButton = YES;
    // search 按钮是否是选中状态
    // self.searchBar.searchResultsButtonSelected = YES;
    // 在没有文字的时候，输入框右侧显示的一个书型的按钮
    // self.searchBar.showsBookmarkButton = YES;
    
    // 输入框获取到焦点后，弹出的键盘类型
    self.searchBar.keyboardType = UIKeyboardTypeEmailAddress;
    
    // 取消输入框焦点
    // [self.searchBar resignFirstResponder];
    
    // 修改颜色 ios6 以上
    self.searchBar.barTintColor = [UIColor redColor];
    
    // 修改 cancel 按钮的文字（如何查看一个 UIView 的层级结构参看：ControlBasic/WControlDumpController）
    for (id view in ((UIView *)[self.searchBar.subviews objectAtIndex:0]).subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    self.searchBar.delegate = self;
    
    // 是否显示 UISearchBar 输入框下面的分类文字
    self.searchBar.showsScopeBar = YES;
    // UISearchBar 输入框下面的分类文字的数据源
    self.searchBar.scopeButtonTitles = [[NSArray alloc] initWithObjects:@"webabcd 01", @"webabcd 02", @"webabcd 03", nil];
    // UISearchBar 输入框下面的分类文字集合中被选中的文字的索引位置
    self.searchBar.selectedScopeButtonIndex = 1;
}

#pragma mark -
#pragma mark UISearchBarDelegate
// searchBar.showsBookmarkButton 被点击的时候
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarBookmarkButtonClicked";
}

// searchBar.showsCancelButton 被点击的时候
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarCancelButtonClicked";
}

// searchBar.showsSearchResultsButton 被点击的时候
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarResultsListButtonClicked";
    [self.searchBar resignFirstResponder]; // 取消输入框焦点，收起软键盘
}


// 虚拟键盘上的 search 按钮被点击的时候
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarSearchButtonClicked";
    [self.searchBar resignFirstResponder]; // 取消输入框焦点，收起软键盘
}

// UISearchBar 输入框下面的分类文字集合，选中的文字发生改变时
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    self.lblMsg.text = [NSString stringWithFormat:@"scope button index: %d", (int)selectedScope];
}


// 是否应该处于编辑状态
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarShouldBeginEditing";
    // 应该处于编辑状态（弹出软键盘）
    return YES;
    
    // 如果返回 NO 则不会弹出软键盘
}

// 开始输入文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarTextDidBeginEditing";
}

// 是否应该处于编辑完成状态
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarShouldEndEditing";
    // 应该处于编辑完成状态（收起软键盘）
    return YES;
    
    // 如果返回 NO 则不会收起软键盘
}

// 输入完成
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.lblMsg.text = @"searchBarTextDidEndEditing";
}

// 文字发生变化时
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.lblMsg.text = @"textDidChange";
}


@end
