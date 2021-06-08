//
// 用于演示 TabBarController 中的某一个 tab
//

#import "WTabBarController1Controller.h"

@interface WTabBarController1Controller ()

@end

@implementation WTabBarController1Controller

// 从 stroyboard 加载的会通过 initWithCoder 初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // 定义本 tab 的 UITabBarItem（注意，在 ios7 中图片的大小是有限制的）
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"aaa" image:[UIImage imageNamed:@"about_icon"] tag:10];
        
        // 选中的图片
        // tabBarItem.selectedImage = [UIImage imageNamed:@"channel_select.png"];
        
        // 图片下面文字的偏移量
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);

        // 设置 UITabBarItem 的 badge
        tabBarItem.badgeValue = @"3";
        
        // 设置 tab 文字的正常颜色和选中颜色
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
        
        self.tabBarItem = tabBarItem;
        
        // finishedSelectedImage - ios7 中已经弃用了
        // finishedUnselectedImage - ios7 中已经弃用了
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
