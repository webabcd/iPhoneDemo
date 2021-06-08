//
// 演示 NSDate 的应用
//

#import "WDateController.h"

@interface WDateController ()

// 之前说过的，私有的也可以写这里，不用非要写在 .h 里
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WDateController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.lblMsg setNumberOfLines:0];
    
    NSString *result = @"";
    
    // 获取当前系统时间
    NSDate *date = [NSDate date];
    
    // 打印当前系统时间（utc-0）
    result = [result stringByAppendingFormat:@"%@", date];
    
    // 获取当前时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 当前时区与 utc-0 的偏移秒数，北京是：28800
    int offset = [zone secondsFromGMTForDate:date];
    // dateWithTimeIntervalSinceNow - 使当前日期偏移指定的秒数（本例中就得到了北京时间）
    result = [result stringByAppendingFormat:@"\n%@", [NSDate dateWithTimeIntervalSinceNow:offset]];
    
    // dateByAddingTimeInterval - 让指定的日期偏移指定的秒数
    result = [result stringByAppendingFormat:@"\n%@", [date dateByAddingTimeInterval:offset]];

    // timeIntervalSince1970 - 指定日期与 1970 的偏移秒数
    NSTimeInterval ts = date.timeIntervalSince1970;
    result = [result stringByAppendingFormat:@"\n%f", ts];
    
    // timeIntervalSinceDate - 获取两个日期相差的秒数
    result = [result stringByAppendingFormat:@"\n%f", [[date dateByAddingTimeInterval:offset] timeIntervalSinceDate:date]];
    
    
    // NSDateFormatter - 用于格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 将字符串转换为日期
    NSDate *myDate = [formatter dateFromString:@"2011-04-12 13:15:00"];
    // 将日期按照指定的格式转换为字符串
    result = [result stringByAppendingFormat:@"\n%@", [formatter stringFromDate:myDate]];
    
    self.lblMsg.text = result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
