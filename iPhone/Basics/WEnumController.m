//
// 用于演示如何使用枚举
//

#import "WEnumController.h"

@interface WEnumController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WEnumController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 使用 c 语言的枚举
    WMonthC monthC = MarC;
    
    // 使用 oc 语言的枚举
    enum WMonthOC monthOC = MarOC;
    
    self.lblMsg.text = [NSString stringWithFormat:@"%d, %d", monthC, monthOC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
