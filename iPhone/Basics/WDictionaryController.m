//
// 演示 NSDictionary, NSMutableDictionary 的应用
//

#import "WDictionaryController.h"

@interface WDictionaryController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WDictionaryController

- (void)viewDidLoad
{
    [super viewDidLoad];
	   
    [self.lblMsg setNumberOfLines:0];
    
    // 演示 NSDictionary
    [self demoNSDictionary];
    // 演示 NSMutableDictionary
    [self demoNSMutableDictionary];

    self.lblMsg.text = @"NSDictionary - 不可变字典表；NSMutableDictionary - 可变字典表";
}

- (void)demoNSDictionary
{
    // 实例化 NSDictionary，并赋予初始数据（注意：key 必须是引用类型），以“nil”收尾
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:1], @"webabcd",
                          [NSNumber numberWithInt:2], @"wanglei", nil];
    // 此句同上
    dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @(1), @"webabcd",
                          @(2), @"wanglei", nil];
    
    // 实例化 NSDictionary 并赋值的简化方法
    // NSDictionary *dict2 = @{@"x":@"webabcd", @"y":@"wanglei"};
    
    // 获取字典表的数据总数
    int count = [dict count];
    // 根据 key 获取 value
    id obj = [dict objectForKey:[NSNumber numberWithInt:1]];
    // 获取字典表中所有的 key
    NSArray *keys = [dict allKeys];
    // 获取字典表中所有的 value
    NSArray *values = [dict allValues];
    
    // foreach 字典表
    for (id key in dict)
    {
        id value = [dict objectForKey:key];
    }
}

- (void)demoNSMutableDictionary
{
    // NSMutableDictionary 继承自 NSDictionary
    
    // 实例化 NSMutableDictionary，并赋予初始数据（注意：key 必须是引用类型），以“nil”收尾
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:1], @"webabcd",
                          [NSNumber numberWithInt:2], @"wanglei", nil];
    
    // 更新指定 key 的 value
    [dict setObject:@"webabcd2" forKey:[NSNumber numberWithInt:1]];
    // 移除指定 key 的数据
    [dict removeObjectForKey:[NSNumber numberWithInt:1]];
    // 移除全部数据
    [dict removeAllObjects];
    
    // 在字典表中添加一个字典表数据ß
    [dict addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:1], @"webabcd",
                                    [NSNumber numberWithInt:2], @"wanglei", nil]];
}

@end
