//
// 关于 controller 的基础
//
// Model 层来自 WOcBasic
//

#import "WOcBasicController.h"

@interface WOcBasicController ()

@property (strong, nonatomic) WOcBasic *ocBasic;

@end

@implementation WOcBasicController

// 初始化 controller，在初次创建 UIViewController 或重新恢复时都会调用
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 让 Label 可以 wrap
    [self.lblMsg setNumberOfLines:0];
    [self.lblMsg2 setNumberOfLines:0];

    // alloc - 分配内存空间；init - 调用 c 的 init 方法以初始化
    self.ocBasic = [[WOcBasic alloc] init];
    
    // 调用 WOcBasic 的 sayHello 方法（没有参数）
    [self lblMsg].text = [self.ocBasic sayHello]; // 对于属性来说 self.lblMsg 同 [self lblMsg]
    
    self.ocBasic.name = @"wanglei";
    // 调用 WOcBasic 的 sayHello 方法（两个参数），也就是说支持方法重载
    self.lblMsg2.text = [self.ocBasic sayHello:@"p1" paramDescription:@"p2"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
