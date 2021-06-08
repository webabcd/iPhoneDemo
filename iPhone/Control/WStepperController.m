//
// 演示 UIStepper 的应用
//

#import "WStepperController.h"

@interface WStepperController ()

@end

@implementation WStepperController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化 UIStepper（无法指定宽度和高度）
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(20, 200, 10000, 10000)];
    
    // 按住加号或减号不松手时，value 是否需要持续变化
    stepper.autorepeat = YES;
    
    // YES - 只要用户的操作导致了 value 的值发生变化则立刻触发 UIControlEventValueChanged 事件
    // NO - 只有用户的操作导致了 value 的值发生变化，且用户松手了，才会触发 UIControlEventValueChanged 事件
    stepper.continuous = YES;
    
    // 当 value 值达到最大值后，再点击加号是否需要变为最小值；当 value 值达到最小值后，再点击减号是否需要变为最大值
    stepper.wraps = YES;
    // 最小值
    stepper.minimumValue = 0;
    // 最大值
    stepper.maximumValue = 100;
    // 点击加号或减号后 value 值的偏移量
    stepper.stepValue = 1;
    // UIStepper 的值
    stepper.value = 70;
    // UIStepper 的主题颜色
    stepper.tintColor = [UIColor redColor];
    
    
    // 设置不同状态时的背景图
    // [stepper setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>];
    // 设置不同状态时，加号的图片
    // [stepper setIncrementImage:<#(UIImage *)#> forState:<#(UIControlState)#>];
    // 设置不同状态时，减号的图片
    // [stepper setDecrementImage:<#(UIImage *)#> forState:<#(UIControlState)#>];
    // 根据左右的不同状态来设置中间分割线的图片
    // [stepper setDividerImage:<#(UIImage *)#> forLeftSegmentState:<#(UIControlState)#> rightSegmentState:<#(UIControlState)#>];
    
    // UIControlState 枚举有
    // UIControlStateNormal - 正常状态
    // UIControlStateHighlighted - 点击但没有松手
    // UIControlStateSelected - 点击且松手
    // UIControlStateDisabled - 禁用状态
    
    
    // 添加一个 target action，用于响应 UIControlEventValueChanged 事件（即 value 值发生变化时所触发的事件，当然也要结合 continuous 属性的设置）
    [stepper addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:stepper];
}

- (void)myAction:(UIStepper *)stepper
{
    self.lblMsg.text = [NSString stringWithFormat:@"%f", stepper.value];
}

@end
