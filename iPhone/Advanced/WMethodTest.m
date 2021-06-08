//
// 一个具有一个方法的类，用于演示 SEL @selector
//

#import "WMethodTest.h"

@implementation WMethodTest

- (NSString *)method:(NSString*)name
{
    return [NSString stringWithFormat:@"hello: %@", name];
}

@end
