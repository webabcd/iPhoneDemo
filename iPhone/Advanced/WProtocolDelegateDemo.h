//
// 本例演示了如何定义一个用于委托的 Protocol
//
// 为了方便，将协议和类定义到一个文件里了
//

#import <Foundation/Foundation.h>

// oc 也是 c，有先后顺序，如果没有这一行把类名提前，那么 @protocol 中就不认识 WProtocolDelegateDemo 了
@class WProtocolDelegateDemo;


// 协议定义
@protocol WProtocolDelegate<NSObject>

// 定义一个本协议必须要实现的方法，即如下的用于回调的方法
- (void)callback:(WProtocolDelegateDemo *)sender; // sender 一般标记为 id

@end


// 类定义
@interface WProtocolDelegateDemo : NSObject

// 定义一个属性
// id<WProtocolDelegate> - 代表赋值给 myDelegate 的对象必须要实现 WProtocolDelegate 协议
@property (nonatomic, weak) id<WProtocolDelegate> myDelegate;

- (void)method;

@end
