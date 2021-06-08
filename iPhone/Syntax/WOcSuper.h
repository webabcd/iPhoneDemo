//
// 演示类继承的相关知识
//
// 本类用于演示父类
//

#import <Foundation/Foundation.h>

@interface WOcSuper : NSObject

@property (nonatomic) NSString *name;

- (NSString *)doSomething:(NSString *)param1 paramDescription:(NSString *)param2;

+ (NSString *)doStaticMethod;

@end
