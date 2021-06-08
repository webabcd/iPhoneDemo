//
// 本例演示了如何使用一个协议委托
//

#import "WProtocolDelegateDemo.h"

@implementation WProtocolDelegateDemo

// 委托类型的属性
@synthesize myDelegate = _myDelegate;

- (void)method
{
    // code...
    
    // 调用委托的回调方法
    if (self.myDelegate)
    {
        [self.myDelegate callback:self];
    }
}

@end
