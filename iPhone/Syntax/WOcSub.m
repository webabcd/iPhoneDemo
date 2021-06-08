//
// 演示类继承的相关知识
//
// 本类用于演示子类
//

#import "WOcSub.h"

@implementation WOcSub

// 初始化
- (id)init
{
    self = [super init]; // 先初始化父类
    if (self) { // 非 nil
        self.name = [self.name stringByAppendingString:@" sub"];
    }
    return self;
}

// 重写父类的实例方法
- (NSString *)doSomething:(NSString *)param1 paramDescription:(NSString *)param2;
{
    return [NSString stringWithFormat:@"sub: %@, %@", param1, param2];
}

// 重写父类的静态方法
+ (NSString *)doStaticMethod
{
    return @"sub doStaticMethod";
}

@end
