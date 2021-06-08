//
// 演示如何获取当前语言类型，以及如何动态设置当前语言
//
// 注：无法直接改变当前语言，但是可以获取指定语言的本地化资源
//











// 程序名称如何国际化









#import "WLocalizationDemoController.h"

@interface WLocalizationDemoController ()

@end

@implementation WLocalizationDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 获取当前设备支持的全部语言集合，其中第 1 个语言为设备当前的语言
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [userDefaults objectForKey:@"AppleLanguages"];
    
    self.lblMsg.text = [languages componentsJoinedByString:@","];
}


// 获取英文的本地化资源
- (IBAction)btnChangeLanguage:(id)sender
{
    // 获取指定语言的 NSBundle 信息（本例为获取 en.lproj 内的信息）
    NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    // 强制使用英文的本地化信息（第 3 个参数是 .strings 文件的文件名，如果是 Localizable.strings 的话那么写 nil 就行）
    self.lblMsg.text = [bundle localizedStringForKey:@"welcome" value:nil table:nil];
    
    
    // 获取指定语言的本地化图片或文件（本例为获取 en.lproj 内的图片）
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *imagePath = [resourcePath stringByAppendingPathComponent:@"en.lproj/localizationImage.png"];
    self.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
}

@end
