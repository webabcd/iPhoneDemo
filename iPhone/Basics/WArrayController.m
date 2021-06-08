//
// 演示 NSArray, NSMutableArray 的应用
//

#import "WArrayController.h"

@interface WArrayController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WArrayController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
    
    // NSArray 的说明
    [self demoNSArray];
    // NSMutableArray 的说明
    [self demoNSMutableArray];
    
    self.lblMsg.text = @" NSArray - 有顺序但不可变的数组 \n NSMutableArray - 有顺序且可变的数组 \n Array内可以有重复数据，OrderedSet内不允许有重复数据";
}

- (void)demoNSArray
{
    // 实例化一个 NSArray, 并赋予初始数据，以“nil”收尾
    // NSArray *array = [NSArray arrayWithObjects:@"b", @"a", @"c", nil];
    
    // 实例化 NSArray 并赋值的简化方法
    NSArray *array = @[@"b", @"a", @"c"];
    
    // 数组中是否包含指定的元素
    bool containC = [array containsObject:@"c"];
    // 获取数组中的最后一个元素
    id lastObject = [array lastObject];
    // 获取数组中的第一个元素
    id firstObject = [array firstObject];
    // 获取数组中的元素的数量
    int count = [array count];
    // 获取数组中指定位置的元素
    id secondObject = [array objectAtIndex:1];
    
    // 获取指定对象的索引位置
    NSUInteger index = [array indexOfObject:@"a"];
    // 找不到则返回 NSNotFound
    if (index == NSNotFound) {}
    
    // 实例化一个 NSComparator 用于比较两个对象的大小，以便排序
    NSComparator comparator = ^(id obj1, id obj2)
    {
        NSString *first = (NSString *)obj1;
        NSString *second = (NSString *)obj2;
        
        return [first compare:second];
        
        // if (obj1 > obj2) return (NSComparisonResult)NSOrderedDescending
        // if (obj1 < obj2) return (NSComparisonResult)NSOrderedAscending
        // if (obj1 == obj2) return (NSComparisonResult)NSOrderedSame
    };
    
    // 通过 sortedArrayUsingComparator 排序，并返回排序后的数组
    NSArray *sortedArray = [array sortedArrayUsingComparator:comparator];
    
    // 将数组通过指定的连接符连接起来，并以字符串的形式输出
    NSString *result = [sortedArray componentsJoinedByString:@","];
    
    
    // foreach 数组
    for (NSString *string in array)
    {
        
    }
}

- (void)demoNSMutableArray
{
    // NSMutableArray - 继承自 NSArray

    // 实例化 NSMutableArray，并定义其可容纳的元素数（仅为优化用，没有其他实际意义）
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    // 添加元素
    [array addObject:@"d"];
    // 在指定的位置上添加元素
    [array insertObject:@"e" atIndex:0];
    // 移除指定位置上的元素
    [array removeObjectAtIndex:0];
    // 移除最后一个元素
    [array removeLastObject];
    
    // 复制数组（深度复制）
    id arrayCopy = [array copy];
}

@end
