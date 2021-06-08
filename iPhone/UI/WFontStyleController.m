//
// 演示如何设置文字的样式（通过 NSAttributedString 实现）
//

#import "WFontStyleController.h"

@interface WFontStyleController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation WFontStyleController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 需要显示的文字
    NSString *displayString = @"i am webabcd";
    
    // 构造一个文字样式的字典表
    NSDictionary *fontAttributes1 = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:32.0f],
                                     NSForegroundColorAttributeName:[UIColor orangeColor],
                                     NSBackgroundColorAttributeName:[UIColor grayColor]};
    
    
    // 定义一个 NSShadow（给文字添加阴影效果）
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(5, 5);
    // 构造一个文字样式的字典表
    NSDictionary *fontAttributes2 = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:48.0f],
                                      NSForegroundColorAttributeName:[UIColor redColor],
                                      NSBackgroundColorAttributeName:[UIColor blueColor],
                                      NSShadowAttributeName:shadow};
    
    
    // 实例化 NSMutableAttributedString，并指定文字以及文字对应的样式字典
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:displayString];
    [attributedText setAttributes:fontAttributes1 range:[displayString rangeOfString:@"i am "]];
    [attributedText setAttributes:fontAttributes2 range:[displayString rangeOfString:@"webabcd"]];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    
    // 设置 UILabel 的 attributedText 属性，用于指定文字以及文字样式
    self.label.attributedText = [[NSAttributedString alloc] initWithAttributedString:attributedText];
    [self.label sizeToFit];
    
    
    // 将设置好的 UILabel 添加进来
    [self.view addSubview:self.label];
    

    for (NSString *familyName in [UIFont familyNames])
    {
        // 这里可以枚举出全部字体
        
        // 根据 familyName 设置字体
        // UIFont *font = [UIFont fontWithName:familyName size:24.0f];
    }
 
    
    // NSAttributedString 中支持的字体样式相关属性如下：
    // NSFontAttributeName
    // NSParagraphStyleAttributeName
    // NSForegroundColorAttributeName
    // NSUnderlineStyleAttributeName
    // NSSuperscriptAttributeName
    // NSBackgroundColorAttributeName
    // NSAttachmentAttributeName
    // NSLigatureAttributeName
    // NSBaselineOffsetAttributeName
    // NSKernAttributeName
    // NSLinkAttributeName
    // NSStrokeWidthAttributeName
    // NSStrokeColorAttributeName
    // NSUnderlineColorAttributeName
    // NSStrikethroughStyleAttributeName
    // NSStrikethroughColorAttributeName
    // NSShadowAttributeName
    // NSObliquenessAttributeName
    // NSExpansionAttributeName
    // NSCursorAttributeName
    // NSToolTipAttributeName
    // NSMarkedClauseSegmentAttributeName
}

@end
