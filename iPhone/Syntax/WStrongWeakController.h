//
// 演示 strong 和 weak 的概念
//

#import <UIKit/UIKit.h>

@interface WStrongWeakController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end
