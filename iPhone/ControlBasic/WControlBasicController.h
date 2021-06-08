//
// 控件基础：简述 bounds frame center 的含义
//

#import <UIKit/UIKit.h>

@interface WControlBasicController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *lblMsg;

@end


// 为了方便标记出哪部分是 frame，所以引入一个 UIView 画个图
@interface WControlBasicUIView : UIView

@end
