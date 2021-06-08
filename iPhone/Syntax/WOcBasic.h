//
// 关于 Objective－C 的语法基础
//
// 本例演示如何开发一个具有基本功能的自定义类（.h 头文件）
//

// 导入 Foundation Framework
#import <Foundation/Foundation.h>

// @interface - 定义接口，即对外暴露的属性、方法等
// 自定义类一般继承自 NSObject
@interface WOcBasic : NSObject

// @property - 定义一个属性（@property 简化了属性的定义）
// * - 代表引用类型
// nonatomic - 线程不安全（atomic - 线程安全）
// strong - 关于 strong 和 weak 的详细说明请参见：WStrongWeakController.m
@property (strong, nonatomic) NSString *name;

// - 代表实例方法
// + 代表静态方法

// 定义一个没有参数的方法
- (NSString *)sayHello;
// 定义一个有两个参数的方法（注意：例子中的 paramDescription 用于描述第二个参数）
- (NSString *)sayHello:(NSString *)param1 paramDescription:(NSString *)param2;

@end
