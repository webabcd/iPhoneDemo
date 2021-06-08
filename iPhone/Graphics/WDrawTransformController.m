//
// 演示 Transform 的应用
//
// 详见：WDrawTransformView.m
//

#import "WDrawTransformController.h"
#import "WDrawTransformView.h"

@interface WDrawTransformController ()

@end

@implementation WDrawTransformController

- (void)viewDidLoad
{
    [super viewDidLoad];

    WDrawTransformView *view = [[WDrawTransformView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [self.view addSubview:view];
}


@end
