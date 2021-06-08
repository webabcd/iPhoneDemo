//
// 演示 UIColor 的应用
//

#import "WColorController.h"

@interface WColorController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation WColorController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    
    // 按照 rgba 的方式实例化 UIColor
    UIColor *color = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.5f];
    self.view.backgroundColor = color;
    
    CGColorRef colorRef = color.CGColor;
    // 获取指定 UIColor 的颜色组成
    const CGFloat *colorComponents = CGColorGetComponents(colorRef);
    // 获取指定 UIColor 的颜色组成的组件总数（比如 rgba 就是 4 个）
    NSUInteger colorComponentsCount = CGColorGetNumberOfComponents(colorRef);
    
    self.label.text = @"";
    for (int i=0; i<colorComponentsCount; i++)
    {
        // 得到一个 UIColor 的 rgba 值
        self.label.text = [self.label.text stringByAppendingFormat:@"%0.2f\n", colorComponents[i]];
    }
}

@end
