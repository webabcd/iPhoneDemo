//
// 本例演示了如何去实现一个 Protocol
//

#import "WProtocolDataSourceDemo.h"

@implementation WProtocolDataSourceDemo

// 实现 WProtocolDataSource 协议
- (NSString *)method: (NSString *)name
{
    return [NSString stringWithFormat:@"hello: %@", name];
}

@end
