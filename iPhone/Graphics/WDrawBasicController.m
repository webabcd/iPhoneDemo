//
// 演示 CGContext 的基础
//
// 详见：WDrawBasicView.m
//

#import "WDrawBasicController.h"
#import "WDrawBasicView.h"

@interface WDrawBasicController ()

@end

@implementation WDrawBasicController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    WDrawBasicView *view = [[WDrawBasicView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [self.view addSubview:view];
}

@end
