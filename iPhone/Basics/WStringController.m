//
// 演示 NSString 的应用
//
// 注：内容实在是太多了，要养成查看文档的习惯
// 另：NSMutableString 就是一个可变的 NSString，其继承自 NSString
//
// @"" - 是 oc 字符串； “” － 是 c 字符串
//

#import "WStringController.h"

@interface WStringController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WStringController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self.lblMsg setNumberOfLines:0];

    // 格式化字符串
    NSString *result = [NSString stringWithFormat:@"%@", @"webabcd"];
    
    // 拼接字符串
    result = [result stringByAppendingString:@"\nwanglei"];
    
    // 拼接一个格式化后的字符串
    result = [result stringByAppendingFormat:@"\n%@", @"webabcd"];
    
    // 替换字符串
    result = [result stringByReplacingOccurrencesOfString:@"web" withString:@"net"];
    
    // rangeOfString - 获取某个字符串在指定字符串中的位置索引，本例的结果为：8
    result = [result stringByAppendingFormat:@"\n%i", [result rangeOfString:@"wang"].location];
    
    // substringFromIndex - 截取指定范围的字符串 (substringFromIndex, substringToIndex, substringWithRange)
    result = [result stringByAppendingFormat:@"\n%@", [result substringFromIndex:8]];
    
    // componentsSeparatedByString - 按指定分隔符分割字符串，返回一个数组
    result = [result stringByAppendingFormat:@"\n%@", [result componentsSeparatedByString:@"\n"]];
    
    // lowercaseString - 将字符串转换为小写
    result = [result lowercaseString];
    
    // 字符串转换为整型
    int xxx = [@"123" intValue];
    // 整型转换为字符串
    result = [result stringByAppendingFormat:@"\n%i", xxx];

    // 常用格式化参数说明（参考 c 的格式化）
    // %@ - 对象
    // %d, %i - 整数（%2d 的意思是：整数部分如果不到2位则用空格代替; %02d 的意思是：整数部分如果不到2位则用“0”代替）
    // %u - 无符号整数
    // %f - 浮点型（%2.3f 的意思是：小数部分保留3位，整数部分如果不到2位则用空格代替）
    // %x - 十六进制
    // %o - 八进制
    // %zu - size_t 类型
    // %p - Pointer 类型
    // %e - 浮点型（科学计算法）
    // %s - c 语言的 string
    // %c - char 类型
    // %li, %ld - 长整型
    // %lu - 无符号长整型
    
    self.lblMsg.text = result;
    
    // NSString 转换为 NSData
    NSData *nsData = [@"webabcd" dataUsingEncoding:NSUTF8StringEncoding];
    // NSData 转换为 NSString
    NSString *nsString = [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];

    // NSString 转换为 NSMutableString
    NSMutableString *mutableString = [@"abc" mutableCopy];
    
    // 判断字符串是否相等要用 isEqualToString
    BOOL isEqual = [@"abc" isEqualToString:@"abc"];
    
    // trim 字符串（whitespaceCharacterSet - 去掉两端的空白字符串； whitespaceAndNewlineCharacterSet - 去掉两端的空白字符串和换行字符串）
    NSString * trimmedString = [@" ab c " stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 结果是 @"abc"
    
    // 是否以指定的字符串开头
    // [result hasPrefix:(NSString *)];
    // 是否以指定的字符串结尾
    // [result hasSuffix:<#(NSString *)#>];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
