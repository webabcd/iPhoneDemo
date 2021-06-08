//
// 用于演示如何使用结构体
//

#import "WStructController.h"


@interface WStructController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WStructController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 使用 c 语言的结构体
    WPointC pointC;
    pointC.x = 100;
    pointC.y = 200;
    
    // 使用 oc 语言的结构体
    struct WPointOC pointOC;
    pointOC.x = 300;
    pointOC.y = 400;
    
    self.lblMsg.text = [NSString stringWithFormat:@"%i, %i, %i, %i", pointC.x, pointC.y, pointOC.x, pointOC.y];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
