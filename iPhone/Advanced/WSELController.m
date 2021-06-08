//
// 演示 SEL @selector
//
// @selector 的类型是 SEL，有点像函数指针，有点类似 c# 的委托（block 更像函数指针，更类似 c# 的委托）
// @selector 还有一个作用：用来实现反射的功能
//

#import "WSELController.h"

@interface WSELController ()

@end

@implementation WSELController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
    
    // 通过 @selector 调用没有参数的函数
    id result = [self performSelector:@selector(method)];
    self.lblMsg.text = [NSString stringWithFormat:@"%@", result];
    
    // 通过 @selector 调用有多个参数的函数
    id result2 = [self performSelector:@selector(method2:second:) withObject:@"abc" withObject:@"xyz"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\n%@", result2];
    
    
    // 通过字符串的方式定义一个 @selector
    SEL mySelector = NSSelectorFromString(@"method:");
    // 获取指定的 SEL 的字符串含义
    // NSString * str = NSStringFromSelector(mySelector);
    
    // 通过 @selector 的方式调用其他类的函数（相当于反射）
    WMethodTest *test = [[WMethodTest alloc] init];
    id result3 = [test performSelector:mySelector withObject:@"webabcd"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\n%@", result3];
    
    
    
    // 另外：performSelector 可以用于延迟执行
    // [self performSelector:<#(SEL)#> withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>];
}

// 没有参数的方法
- (NSString *)method
{
    return @"method";
}

// 有两个参数的方法
- (NSString *)method2:(NSString *)param1 second:(NSString *)param2
{
    return [NSString stringWithFormat:@"%@, %@", param1, param2];
}

@end
