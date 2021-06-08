//
// 关于 Objective－C 的语法基础
//
// 本例演示如何开发一个具有基本功能的自定义类（.m 实现文件）
//

// 导入头文件
#import "WOcBasic.h"

@interface WOcBasic ()
{
    // 定一个私有变量
    float _privateVariable;
}

// 定义一个私有属性
@property (nonatomic) int privateProperty;

@end

@implementation WOcBasic

// @synthesize － 实现在 @interface 中定义的属性（@synthesize 简化了属性的实现）
// 注：在 ios6 或以上版本中，已经不再需要 @synthesize 了
@synthesize name = _name;
@synthesize privateProperty = _privateProperty;

// 初始化
- (id)init
{
    self = [super init];
    if (self) // 非 nil
    {
        _privateProperty = 100;
        _privateVariable = 200;
    }
    return self;
}

// 属性 name 的 getter（函数名是约定的，不需要的话可以不写）
- (NSString *)name
{
    if (_name == nil)
        _name = @"webabcd(getter)";
    return _name;
}

// 属性 name 的 setter（函数名是约定的，不需要的话可以不写）
- (void)setName:(NSString *)n
{
    _name = [n stringByAppendingString: @"(setter)"];
}

// 实现头文件中定义的没有参数的方法
- (NSString *)sayHello
{
    return [NSString stringWithFormat:@"hello: %@, %i, %f", self.name, self.privateProperty, _privateVariable];
}

// 实现头文件中定义的有两个参数的方法（注意：例子中的 paramDescription 用于描述第二个参数）
- (NSString *)sayHello:(NSString *)param1 paramDescription:(NSString *)param2;
{
    return [NSString stringWithFormat:@"hello: %@, %@, %@", self.name, param1, param2];
}

@end
