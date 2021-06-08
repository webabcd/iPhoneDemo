//
// 图片的本地化
//
// 1、选中图片文件，然后在右侧 inspector 窗口中本地化它
// 2、英文图片在 en.lproj 文件夹内，中文图片在 zh-Hans.lproj 文件夹内
// 3、其他类型的文件的本地化也是类似的
//

#import "WLocalizationImageController.h"

@interface WLocalizationImageController ()

@end

@implementation WLocalizationImageController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 正常使用就好（只要你之前设置好了，图片就会自动本地化）
    self.imageView.image = [UIImage imageNamed:@"localizationImage"];
    
    
    // 另一个图片本地化的方法如下：
    // 1、自定义文件命名规则
    // 2、按照自定义的文件命名规则引用图片
}

@end
