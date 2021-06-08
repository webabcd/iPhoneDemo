//
// 演示 Block 的应用
//
// Block 相当于函数指针，类似 C# 中的委托
//

#import "WBlockController.h"

@interface WBlockController ()

@end

@implementation WBlockController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 通过 NSArray 的 sortedArrayUsingComparator 方法演示 Block 的应用
    [self demo1];
    
    // 自定义一个 block 并调用
    [self demo2];
    
    // 演示自定义 block 的应用
    [self demo3];
}

- (void)demo1
{
    // 要想在 block 中
    __block int count = 0;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"c", @"a", @"d", @"b", nil];
    
    // 通过 block 排序数组
    // ^ 代表 block，NSComparisonResult 代表返回值的类型，obj1和obj2是需要排序比较的两个对象
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        NSString *first = (NSString *)obj1;
        NSString *second = (NSString *)obj2;
        
        // 默认情况 block 对外部变量只有只读的权限，如果需要在 block 中读写外部变量，需要在声明外部变量的时候加上 __block
        // 注：如果 block 在 getter 或 setter 中，则不需要 __blcok 也可以对相应的属性变量（如：_privateVariable）读写
        count++;
        
        return [first compare:second];
    }];
    
    self.lblMsg.text = [NSString stringWithFormat:@"%@; 运算次数:%i\n", [sortedArray componentsJoinedByString:@","], count];
}


// 通过 typeof 定义一个 block
// int 代表 block 的返回值的类型
// ^ 代表是 block
// double num 代表 block 接收的参数
typedef int (^MyBlock)(double num);

- (void)demo2
{
    // 实例化一个 blcok
    MyBlock myBlock = ^(double num)
    {
        return (int)num;
    };
    // 调用 block
    int i = myBlock(12.3);
    
    // 定义 block 与实例化 block 在一起
    int (^myBlock2)(double) = ^(double num)
    {
        return (int)num;
    };
    // 调用 blcok
    int i2 = myBlock2(12.3);
    
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%i, %i\n", i, i2];
}


- (void)demo3
{
    // 通过 block 将 double 转换为 int（inline 方式）
    int i = [self convertDoubleToInt:12.3 usingBlockObject:^int(double num)
    {
        return (int)num;
    }];
    
    // 调用 block 时，可以不指定返回类型，系统会自己猜（inline 方式）
    int i2 = [self convertDoubleToInt:12.3 usingBlockObject:^(double num)
    {
        return (int)num;
    }];
    
    // 非 inline 方式调用 block
    int i3 = [self convertDoubleToInt:12.3 usingBlockObject:execBlock];
    
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%i, %i, %i\n", i, i2, i3];

}

// 用于演示非 inline 方式调用 block
MyBlock execBlock = ^(double num)
{
    // 注：对于非 inline 方式，这里时不能使用 self 的（inline 方式是可以的）
    return (int)num;
};



// 定一个方法，用于通过 block 将 double 转换为 int
- (int)convertDoubleToInt:(double)num usingBlockObject:(MyBlock)blockObject
{
    return blockObject(num);
}

@end
