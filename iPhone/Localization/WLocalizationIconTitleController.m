//
// Icon Title 的本地化
//

#import "WLocalizationIconTitleController.h"

@interface WLocalizationIconTitleController ()

@end

@implementation WLocalizationIconTitleController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 在 InfoPlist.strings（English） 中设置 CFBundleDisplayName="study ios";
    // 在 InfoPlist.strings（Chinese(Simplified)）中设置 CFBundleDisplayName="学习 ios";
    
    // 默认标题在 xxx-Info.plish 中的 Bundle display name 指定的，默认是 ${PRODUCT_NAME}
}


@end
