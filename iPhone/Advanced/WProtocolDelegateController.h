//
// 演示 Protocol 的用于 Delegate 的应用
//
// 这部分有点类似于 c# 的事件模型
//

#import <UIKit/UIKit.h>
#import "WProtocolDelegateDemo.h"

// 声明 WProtocolDelegateController 需要实现 WProtocolDelegate 协议
@interface WProtocolDelegateController : UIViewController<WProtocolDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end
