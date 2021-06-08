//
// 本例演示了如何定义一个用于 DataSource 的 Protocol
//

#import <Foundation/Foundation.h>

// 声明一个 Protocol（“<NSObject> 代表实现这个 Protocol 的类必须继承自 NSObject”）
@protocol WProtocolDataSource <NSObject>

// @required - 代表实现这个 Protocol 时必须要实现的成员。默认就是 @required
@required
- (NSString *)method: (NSString *)name;

// @optional - 代表实现这个 Protocol 时可选实现的成员
@optional
- (void)method2;

@end
