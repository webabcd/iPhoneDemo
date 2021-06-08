//
// 演示 值类型 的应用
//

#import "WValueTypeController.h"

@interface WValueTypeController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WValueTypeController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
    
    // 与其他语言的一个区别，bool 类型的值是 YES 或 NO
    BOOL bTrue = YES; // 大写 BOOL - oc 中的布尔类型（类似的比如 NSInteger 是 oc 中的整型）
    bool bFalse = NO; // 小写 bool - c 中的布尔类型（类似的比如 int 是 c 中的整型）
    
    // 将数字值类型转换为数字引用类型
    NSNumber *num = [NSNumber numberWithFloat:1.23];
    // 将数字引用类型转换为数字值类型
    float f = [num floatValue];
    
    // 将结构体转换为引用类型（NSValue）
    NSValue *pointObject = [NSValue valueWithCGPoint:CGPointMake(1.0, 2.0)];
    // 将引用类型（NSValue）转换为结构体
    CGPoint pointß = [pointObject CGPointValue];
    
    self.lblMsg.text = @"int float double 之类的和其他语言都差不多";
    
    // CGFloat 与 float 的区别
    // 当 32 位环境时 CGFloat 是 float，当 64 位环境时 CGFloat 是 double
    // CGFLOAT_IS_DOUBLE - 判断当前环境下 CGFloat 是否是 double
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
