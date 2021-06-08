//
// 演示如何 dump 出一个 UIView 内部的全部 UIView 层级结构
//

#import "WControlDumpController.h"

@interface WControlDumpController ()

@end

@implementation WControlDumpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISearchBar *label = [[UISearchBar alloc] init];
    [self.view addSubview:label];
    
    // 显示 self.view 的层级结构
    NSMutableString *outString = [[NSMutableString alloc] init];
    [self dumpView: self.view atIndent:0 into:outString];
    NSLog(@"The view tree:\n%@", outString);
    self.lblMsg.text = outString;

    /*
     
     self.view 的层级结构如下：
     
     [00] UIView
     --[01] _UILayoutGuide
     --[01] _UILayoutGuide
     --[01] UISearchBar
     ----[02] UIView
     ------[03] UISearchBarBackground
     ------[03] UISearchBarTextField
     --------[04] _UISearchBarSearchFieldBackgroundView
     ------[03] _UISearchBarShadowView
     
     由上可知，如果你想修改 UISearchBar 的背景的话就按照此层级结构找到 _UISearchBarSearchFieldBackgroundView 后进行修改
     
     */
}

// dump 一个 UIView
- (void)dumpView:(UIView *)myView atIndent:(int)indent into:(NSMutableString *)outString
{
    for (int i = 0; i < indent; i++)
    {
        [outString appendString:@"--"];
    }
    
    [outString appendFormat:@"[%02d] %@\n", indent, [[myView class] description]];
    for (UIView *view in [myView subviews])
    {
        [self dumpView:view atIndent:indent + 1 into:outString];
    }
}

@end
