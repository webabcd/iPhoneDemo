// 要写排序算法








//
// 演示 NSSet, NSMutableSet, NSOrderedSet, NSMutableOrderedSet 的应用
//

#import "WSetController.h"

@interface WSetController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WSetController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.lblMsg setNumberOfLines:0];
    
    // 演示 NSSet
    [self demoNSSet];
    // 演示 NSMutableSet
    [self demoNSMutableSet];
    // 演示 NSOrderedSet
    [self demoNSOrderedSet];
    // 演示 NSMutableOrderedSet
    [self demoNSMutableOrderedSet];
    
    self.lblMsg.text = @" NSSet - 无序且不可变数组 \n NSMutableSet - 无序但可变数组 \n NSOrderedSet - 可排序的 NSSet \n NSMutableOrderedSet - 可排序的 NSMutableSet \n Array内可以有重复数据，OrderedSet内不允许有重复数据";
}

- (void)demoNSSet
{
    // 实例化 NSSet，并赋予初始数据，以“nil”收尾
    NSSet *set = [NSSet setWithObjects:@"a", @"b", @"c", nil];
    // 数组的元素总数
    int count = [set count];
    // 数组中是否包含指定的元素
    bool containA = [set containsObject:@"a"];
    // 从数组中取一个元素
    id randomObj = [set anyObject];
    
    // foreach 数组
    for (NSString *string in set)
    {
        
    }
}

- (void)demoNSMutableSet
{
    // NSMutableSet 继承自 NSSet
    
    // 实例化 NSMutableSet，并赋予初始数据，以“nil”收尾
    NSMutableSet *set = [NSMutableSet setWithObjects:@"a", @"b", @"c", nil];
    // 添加一个元素
    [set addObject:@"d"];
    // 移除一个元素
    [set removeObject:@"d"];
    
    NSMutableSet *set2 = [NSMutableSet setWithObjects:@"a", @"b", @"c", nil];
    // 向 set 中添加 set2
    [set unionSet:set2];
    // 从 set 中移除 set2
    [set minusSet:set2];
    // 从 set 中移除 set2 中没有的元素（取交集）
    [set intersectSet:set2];
}

- (void)demoNSOrderedSet
{
    // 实例化 NSOrderedSet，并赋予初始数据，以“nil”收尾
    NSOrderedSet *set = [NSOrderedSet orderedSetWithObjects:@"a", @"b", @"c", nil];
    // 获取指定元素的索引位置
    int index = [set indexOfObject:@"a"];
    // 获取指定位置的元素
    id obj = [set objectAtIndex:0];
    // 获取第一个元素
    id firstObj = [set firstObject];
    // 获取最后一个元素
    id lashObj = [set lastObject];
    
    // 将 NSOrderedSet 转换为 NSArray
    NSArray *array = [set array];
    // 将 NSOrderedSet 转换为 NSSet
    NSSet *set2 = [set set];
}

- (void)demoNSMutableOrderedSet
{
    // NSMutableOrderedSet － 继承自 NSOrderedSet
    
    // 实例化 NSMutableOrderedSet，并赋予初始数据，以“nil”收尾
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithObjects:@"a", @"b", @"c", nil];
    // 在指定位置插入元素
    [set insertObject:@"d" atIndex:3];
    // 移除指定的元素
    [set removeObject:@"d"];
    // 添加元素
    [set addObject:@"d"];
    // 更新指定位置的元素
    [set setObject:@"x" atIndex:1];
}

@end
