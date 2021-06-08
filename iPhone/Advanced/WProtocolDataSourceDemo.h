//
// 本例演示了如何去实现一个 Protocol
//

#import <Foundation/Foundation.h>
#import "WProtocolDataSource.h"

// <> 里的就是类需要实现的 Protocol，有多个需要实现的协议的话就用“,”分隔
@interface WProtocolDataSourceDemo : NSObject<WProtocolDataSource>

- (NSString *)method:(NSString *)name;

@end
