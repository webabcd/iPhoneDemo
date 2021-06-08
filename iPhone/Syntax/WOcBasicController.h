//
// 关于 controller 的基础
//
// Model 层来自 WOcBasic
//

// 导入 UIKit Framework
#import <UIKit/UIKit.h>
#import "WOcBasic.h"

// controller 一般继承自 UIViewController
@interface WOcBasicController : UIViewController

// 在 storyboard 中按住 ctrl 然后把控件拖进来（拖到 .m 里的 @interface 中也是可以的）
// IB 代表 Interface Builder，IBOutlet 用于告诉编辑器其关联了 View 中的指定的控件（相似的还有 IBAction），其代码的左侧编辑器中会有个圆点，鼠标经过它后，storyboard 中的对应的控件就会被突出显示
// weak - 在 controller 这里是要标记成 weak 指向的，因为在 view 中有个 strong 指向他，如果 view 不指向他了，那么这里的也就没用了，所以需要标记为 weak。一般来说 IBOutlet 的都是 weak 的
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg2;

@end
