//
// 演示填充、渐变、阴影的应用
//

#import "WDrawFillController.h"
#import "WDrawFillView.h"

@interface WDrawFillController ()

@end

@implementation WDrawFillController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    WDrawFillView *view = [[WDrawFillView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [self.view addSubview:view];
}

@end
