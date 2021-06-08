//
// 演示 UIButton 的应用
//
// 本例演示的是动态创建按钮，需要拖拽的话和其他控件一样，按 ctrl 拖拽按钮到 @interface 里生成一个属性，然后按 ctrl 拖拽按钮到 @implementation 里生成一个 action
//
// 经典的 target action，简单的说就是：当某个事件发生时，调用那个对象的那个方法
// target - 目标（那个对象）
// action - 动作（那个方法）
//















// 可以设置背景，图标和文字，图标和文字可以在一行，可以不在一行，多看看资料吧




// 控件部分东西太多，自行看文档
// 加一个点击效果的那个



#import "WButtonController.h"

@interface WButtonController ()

@end

@implementation WButtonController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 根据按钮类型实例化一个按钮（在 ios7 中好多都没用了）
    //     UIButtonTypeSystem - 默认按钮
    //     UIButtonTypeDetailDisclosure - 叹号按钮
    //     UIButtonTypeContactAdd - 加号按钮
    //     UIButtonTypeRoundedRect - 圆角按钮
    //     还有好多其它的类型，但是在 ios7 中没看到有什么区别
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 100, 320, 30);
    
    // 设置按钮的标题文字
    [btn setTitle:@"我是按钮" forState:UIControlStateNormal];
    
    // 设置按钮文字的字体
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    // 设置按钮文字的水平方向的排列方式
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    // 参数 forState 是一个 UIControlState 枚举
    //     UIControlStateNormal -  正常
    //     UIControlStateHighlighted - 高亮
    //     UIControlStateDisabled - 禁用
    //     UIControlStateSelected - 选中
    
    
    // 设置按钮的前景图片
    // [btn setImage:<#(UIImage *)#> forState:<#(UIControlState)#>];
    // 设置按钮的背景图片
    // [btn setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>];
    // 设置按钮的标题文字颜色
    // [btn setTitleColor:<#(UIColor *)#> forState:<#(UIControlState)#>];
    // 设置按钮的标题文字的阴影的颜色，ios7 无效
    // [btn setTitleShadowColor:<#(UIColor *)#> forState:<#(UIControlState)#>];
    // 设置按钮的背景色
    // [btn setBackgroundColor:<#(UIColor *)#>];
    
    
    // 是否是选中状态
    btn.selected = YES;
    // 是否是高亮状态
    btn.highlighted = YES;
    // 是否是启用状态（NO 代表禁用）
    btn.enabled = YES;
    
    
    // 是否 touch 高亮（关于 UIButton 其他更多的属性懒得写了，请参见文档）
    btn.showsTouchWhenHighlighted = NO;
   
    
    // 为按钮增加 target action
    // 参数 forControlEvents 是一个 UIControlEvents 枚举
    // UIControlEventTouchUpInside - 相当于点击事件，其他事件参看文档吧
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 显示按钮控件
    [self.view addSubview:btn];
}

- (void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"按钮被按下了" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    
    [alertView show];
}

@end
