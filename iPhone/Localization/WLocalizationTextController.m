//
// 字符串的本地化
//
// 1、新建一个 String File 文件（File, New, File..., Resource, String File）
// 2、选中 .strings 文件，然后在右侧 inspector 窗口中本地化它
// 3、英文文件在 en.lproj 文件夹内，中文文件在 zh-Hans.lproj 文件夹内
//

#import "WLocalizationTextController.h"

@interface WLocalizationTextController ()

@end

@implementation WLocalizationTextController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 在 Localizable.strings（English） 中设置 "welcome"="welcome to ios";
    // 在 Localizable.strings（Chinese(Simplified)）中设置 "welcome"="欢迎";
    
    
    // 对于 Localizable.strings 文件来说，获取其本地化字符串用 NSLocalizedString 即可
    NSString *welcome = NSLocalizedString(@"welcome", nil);
    self.lblMsg.text = welcome;
    
    
    // 对于非 Localizable.strings 文件来说，获取其本地化字符串需要用 NSLocalizedStringFromTable
    // 比如对于 tableName.strings 文件来说，获取其本地化字符串方式如下（第二个参数就是 .strings 文件的文件名）
    // NSString *welcome = NSLocalizedStringFromTable(@"welcome", @"tableName", nil);
}

@end
