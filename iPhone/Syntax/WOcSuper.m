//
// 演示类继承的相关知识
//
// 本类用于演示父类
//

#import "WOcSuper.h"

@implementation WOcSuper

// 属性
@synthesize name = _name;

// 初始化
- (id)init
{
    self = [super init];
    if (self) { // 非 nil
        _name = @"super";
    }
    return self;
}

// 实例方法
- (NSString *)doSomething:(NSString *)param1 paramDescription:(NSString *)param2;
{
    return [NSString stringWithFormat:@"super: %@, %@", param1, param2];
}

// 静态方法
+ (NSString *)doStaticMethod
{
    return @"super doStaticMethod";
}

@end
