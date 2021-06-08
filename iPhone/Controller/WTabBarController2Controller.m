//
// 用于演示 TabBarController 中的某一个 tab
//

#import "WTabBarController2Controller.h"

@interface WTabBarController2Controller ()

@end

@implementation WTabBarController2Controller

// 从 stroyboard 加载的会通过 initWithCoder 初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // 定义本 tab 的 UITabBarItem（来自 UITabBarSystemItem 枚举）
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:20];
        
        //（来自 UITabBarSystemItem 枚举的 UITabBarItem 无法直接设置 title）
        self.title = @"bbb";
        
        self.tabBarItem = tabBarItem;
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}


@end
