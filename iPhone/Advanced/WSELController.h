//
// 演示 SEL @selector
//
// @selector 的类型是 SEL，其类似于函数指针，类似 c# 的委托。也可以实现反射的功能
//

#import <UIKit/UIKit.h>
#import "WMethodTest.h"

@interface WSELController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end
