//
// 演示如何让 UITableView 分组显示数据
//

#import <UIKit/UIKit.h>

@interface WTableView4Controller : UIViewController

// 为了演示分组数据，需要在 storyboard 中将此 tableview 的 Style 设置为 Grouped
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
