//
// 演示 UILabel 的应用
//

#import "WLabelController.h"

@interface WLabelController ()

@end

@implementation WLabelController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // label 的初始大小为全屏，之后会修改为高度自适应
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    
    // label 的常用属性，顾名思义，不用细说
    label.text = @"i am a label  am a label  am a label  am a label  am a label  am a label";
    label.font = [UIFont fontWithName:@"Arial" size:24];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    
    // numberOfLines - 需要显示多少行，0 为不限制
    label.numberOfLines = 0;

    // NSLineBreakByWordWrapping - 按单词换行
    // NSLineBreakByCharWrapping - 按字符换行
    // NSLineBreakByClipping - 如果显示不下，就舍弃显示不下的部分
    // NSLineBreakByTruncatingTail - 如果显示不下，则后面加省略号。例：xyz...
    // NSLineBreakByTruncatingHead - 如果显示不下，则前面加省略号。例：...xyz
    // NSLineBreakByTruncatingMiddle - 如果显示不下，则中间加省略号。例：abc...xyz
    label.lineBreakMode = NSLineBreakByWordWrapping;


    // 高度自适应（让 label 的高度适应 label 的内容）
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGRect rect = label.frame;
    rect.size.height = size.height;
    rect.origin.y = 100;
    label.frame = rect;
    
    // 添加 label 控件
    [self.view addSubview:label];
}

@end
