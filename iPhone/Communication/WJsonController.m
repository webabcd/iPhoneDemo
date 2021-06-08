// 参数 error 为指针的指针，所以以 myError 要以 “&” 开头取地址 是不对的，他是引用类型









//
// 演示 json 的解析，以及 json 的生成
//

#import "WJsonController.h"

@interface WJsonController ()

@end

@implementation WJsonController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
    
    self.lblMsg.text = @"";
    
    // 反序列化到字典表（对象 json）
    NSDictionary *dict = [self parseJsonToDictionary];
    // 反序列化到数组（集合 json）
    NSArray *array = [self parseJsonToArray];
    
    // 由字典表序列化为 json
    [self parseObjectToJson:dict];
    // 由数组序列化为 json
    [self parseObjectToJson:array];
    
    
    // 反序列化时有个 options 参数，这里说明一下
    // NSJSONReadingMutableContainers - 反序列化为可变对象，即 NSMutableDictionary 或 NSMutableArray
    // NSJSONReadingMutableLeaves - 叶子上的值将被封装为 NSMutableString
    // NSJSONReadingAllowFragments - 凡序列化 json 的顶级对象，而不是数组或字典
    
    // 序列化时有个 options 参数，这里说明一下
    // NSJSONWritingPrettyPrinted - 该换行就换行，该有空格就有空格，以便 json 更易读
}

- (NSDictionary *)parseJsonToDictionary
{
    NSError *myError;
    
    // json 字符串
    NSString *jsonString = @"{\"key1\":\"value1\", \"key2\":\"value2\"}";
    // 把 json 字符串转换为 NSData
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 将 json 转换为 NSDictionary（参数 error 为指针的指针，所以以 myError 要以 “&” 开头取地址）
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    
    if (dict != nil && myError == nil)
    {
        for (NSString *key in dict)
        {
            self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"key:%@, value:%@\n", key, [dict valueForKey:key]];
        }
    }
    
    return dict;
}

- (NSArray *)parseJsonToArray
{
    NSError *myError;
    
    // json 字符串
    NSString *jsonString = @"[\"abc\", \"xyz\"]";
    // 把 json 字符串转换为 NSData
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 将 json 转换为 NSArray（参数 error 为指针的指针，所以以 myError 要以 “&” 开头取地址）
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
    
    if (array != nil && myError == nil)
    {
        for (NSString *str in array)
        {
            self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@\n", str];
        }
    }
    
    return array;
}

- (void)parseObjectToJson:(id)obj
{
    NSError *myError;
    
    // 判断指定的对象是否能被序列化
    if ([NSJSONSerialization isValidJSONObject:obj])
    {
        // 将需要序列化的对象转换为 NSData（参数 error 为指针的指针，所以以 myError 要以 “&” 开头取地址）
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&myError];
        
        if (data != nil && myError == nil)
        {
            // 将 NSData 转换为字符串，就是序列化后的 json 字符串
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@\n", json];
        }
    }
}

@end
