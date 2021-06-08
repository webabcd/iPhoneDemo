//
// 演示如何通过 Core Graphics 绘制各种形状
//
// 详见：WDrawShapeView.m
//

#import "WDrawShapeController.h"
#import "WDrawShapeView.h"

@interface WDrawShapeController ()

@end

@implementation WDrawShapeController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    WDrawShapeView *view = [[WDrawShapeView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
    [self.view addSubview:view];
}


@end
