//
// 演示 Protocol 的用于 DataSource 的应用
//
// 这部分相当于 c# 的 interface
//

#import <UIKit/UIKit.h>
#import "WProtocolDataSource.h"
#import "WProtocolDataSourceDemo.h"

@interface WProtocolDataSourceController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end
