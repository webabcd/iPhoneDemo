//
// 演示 Protocol 的用于 DataSource 的应用
//
// 这部分相当于 c# 的 interface
//

#import "WProtocolDataSourceController.h"

@interface WProtocolDataSourceController ()

@end

@implementation WProtocolDataSourceController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
 
    // id<WProtocolDataSource> 就相当于接口类型，WProtocolDataSourceDemo 实现了 WProtocolDataSource 协议
    id<WProtocolDataSource> demo = [[WProtocolDataSourceDemo alloc] init];
    
    // 调用 WProtocolDataSource 协议的方法
    self.lblMsg.text = [demo method:@"webabcd"];
}


@end
