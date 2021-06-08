//
// 演示 strong 和 weak 的概念
//
// strong 基本与 retain 一样，某个对象每次有一个 strong 类型的指向他，则该对象的引用计数器加 1，当该对象的引用次数为 0 时则被释放
// weak 类型指向某一对象时，其引用计数器不变
// 也就是说，当某个对象没有任何 strong 类型指向他时则被释放
//

#import "WStrongWeakController.h"

@interface WStrongWeakController ()

// 用于演示什么是 strong
@property (nonatomic, strong) NSString *string1;
@property (nonatomic, strong) NSString *string2;

// 用于演示什么是 weak
@property (nonatomic, strong) NSString *string3;
@property (nonatomic, weak) NSString *string4;

@end

@implementation WStrongWeakController

@synthesize string1;
@synthesize string2;

@synthesize string3;
@synthesize string4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lblMsg.text =@"";

    // 演示什么是 strong
    [self demo1];
    
    // 演示什么是 weak
    [self demo2];
    
    // 另外补充说明一下，加强理解
    // 定一个变量（用 __strong 标识），其默认就是 strong 的，没问题
    // __strong NSString *str = [[NSString alloc] initWithUTF8String:"webabcd"];
    // 定一个 weak 类型的变量（用 __weak 标识），由于没有 strong 类型的指向，所以这个永远不可能存在的，编译器就会直接告诉你错误
    // __weak NSString *str = [[NSString alloc] initWithUTF8String:"webabcd"];
}

- (void)demo1
{
    // string1 和 string2 都是 strong 的
    
    // 在 stack 上存放 string1 的指针，假设其内存地址为：0x11
    // 在 heap 上存放 string1 所指向的内容（即字符串“webabcd”），假设其地址为：0x21
    self.string1 = [[NSString alloc] initWithUTF8String:"webabcd"];
    
    // 在 stack 上存放 string2 的指针，假设其内存地址为：0x12
    // string2 指针指向 0x21
    self.string2 = self.string1;
    
    // 让 string1 指针指向空地址
    // 由于 0x21 依然有一个 strong 类型的 string2 指向着他，所以 0x21 不会被释放
    self.string1 = nil;
    
    // 结果是：string1 是 null； string2 是 "webabcd"
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"string1:%@, string2:%@\n", self.string1, self
            .string2];
}

- (void)demo2
{
    // string3 是 strong 的
    // string4 是 weak 的
    
    // 在 stack 上存放 string3 的指针，假设其内存地址为：0x11
    // 在 heap 上存放 string3 所指向的内容（即字符串“webabcd”），假设其地址为：0x21
    self.string3 = [[NSString alloc] initWithUTF8String:"webabcd"];
    
    // 在 stack 上存放 string4 的指针，假设其内存地址为：0x12
    // string4 指针指向 0x21
    self.string4 = self.string3;
    
    // 让 string3 指针指向空地址
    // 那么目前指向 0x21 的只有一个 weak 类型的 string4 了，也就是说已经没有 strong 类型的指向 0x21 了，所以 0x21 会被释放
    self.string3 = nil;
    
    // 结果是：string3 是 null； string4 是 null
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"string3:%@, string4:%@\n", self.string3, self
            .string4];
}

@end
