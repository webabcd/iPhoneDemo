//
// 演示 copy 的概念
//
// 让 copy 所标记的指针指向一个已有内容的时候，会自动把这个已有内容通过 NSCopying 协议复制到一个新的地址，然后指向这个新的地址
//

#import "WCopyController.h"

@interface WCopyController ()

@property (nonatomic, strong) NSString *string1;
@property (nonatomic, strong) NSString *string2;

// 用于演示 copy 的作用
// 要想使 copy 有效，其所标记的类必须实现 NSCopying 协议（所幸 Foundation Framework 中的大部分类都实现了 NSCopying 和 NSMutableCopying）
@property (nonatomic, strong) NSString *string3;
@property (nonatomic, copy) NSString *string4;

@end

@implementation WCopyController

@synthesize string1;
@synthesize string2;

@synthesize string3;
@synthesize string4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lblMsg.text =@"";
    
    // 先看一下 storng 的效果
    [self demo1];
    
    // 再对比看一下 copy 的效果
    [self demo2];
}

- (void)demo1
{
    // string1 和 string2 都是 strong 的
    
    // 在 stack 上存放 str 的指针，假设其内存地址为：0x11
    // 在 heap 上存放 str 所指向的内容（即字符串“webabcd”），假设其地址为：0x21
    NSMutableString *str = [[NSMutableString alloc] initWithUTF8String:"webabcd"];
    
    // 在 stack 上存放 string1 的指针，假设其内存地址为：0x12
    // string1 指针指向 0x21
    self.string1 = str;
    
    // 在 stack 上存放 string2 的指针，假设其内存地址为：0x13
    // string2 指针指向 0x21
    self.string2 = str;
    
    // 0x21 的内容被修改了
    [str appendString:@" is wanglei"];
    
    // 由于 str string1 string2 全部指向 0x21，所以他们全变成新的内容了
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"str:%@\nstring1:%@\nstring2:%@\n\n", str, self.string1, self.string2];
}

- (void)demo2
{
    // string3 是 strong 的
    // string4 是 copy 的
    
    // 在 stack 上存放 str 的指针，假设其内存地址为：0x11
    // 在 heap 上存放 str 所指向的内容（即字符串“webabcd”），假设其地址为：0x21
    NSMutableString *str = [[NSMutableString alloc] initWithUTF8String:"webabcd"];
    
    // 在 stack 上存放 string3 的指针，假设其内存地址为：0x12
    // string3 指针指向 0x21
    self.string3 = str;
    
    // 由于 string4 是 copy 类型的，所以
    // 在 stack 上存放 string4 的指针，假设其内存地址为：0x13
    // 复制 0x21 的内容到一个假设的地址：0x22
    // string4 指针指向 0x22
    self.string4 = str;
    
    // 0x21 的内容被修改了，但是不会影响 0x22 的内容
    [str appendString:@" is wanglei"];
    
    // 所以 str string3 是修改后的内容，string4 是老的内容
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"str:%@\nstring3:%@\nstring4:%@\n", str, self.string3, self.string4];
}

@end
