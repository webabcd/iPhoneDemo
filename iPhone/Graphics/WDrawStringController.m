//
// 演示如何 draw string
//
// 本例通过 UIView 的 drawRect 来 draw 一个字符串，详细代码参见: WDrawStringView.m
//

#import "WDrawStringController.h"
#import "WDrawStringView.h"

@interface WDrawStringController ()

@property (nonatomic, strong) WDrawStringView *drawStringView;

@end

@implementation WDrawStringController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 将我们自定义的 UIView 添加进来（用于演示如何通过 UIView 的 drawRect 来 draw 一个字符串）
    self.drawStringView = [[WDrawStringView alloc] initWithFrame:CGRectMake(0, 100, 320, 100)];
    self.drawStringView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.drawStringView];
}

- (IBAction)buttonPressed:(id)sender
{
    // 每按一次按钮就调用一次 [UIView setNeedsDisplay]
    // 每调用一次 [UIView setNeedsDisplay]，UIView 会自动调用其内的 drawRect: 方法
    [self.drawStringView setNeedsDisplay];
}

@end
