//
// 演示 UIActionSheet 的应用
//

#import "WActionSheetController.h"

@interface WActionSheetController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@end

@implementation WActionSheetController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.lblMsg.text = @"";
}

- (IBAction)button1Pressed:(id)sender
{
    // destructiveButtonTitle - 是重点强调的按钮的显示文字（有自己独特的样式）
    // otherButtonTitles - 可以设置多个按钮
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"title" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"重点强调" otherButtonTitles:@"button1", @"button2", @"button3", nil];
    
    // 设置 UIActionSheet 的样式
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    // 在指定的 view 上弹出 UIActionSheet
    [self.actionSheet showInView:self.view];
    
    
    // 注意：
    // 1、在 ipad 上弹出 UIActionSheet 默认是居中显示，也可以指定在哪里弹，showFromToolbar:, showFromToolbar:, showFromBarButtonItem:animated:
    // 2、在 ipad 上弹出 UIActionSheet，如果向指定其具体位置的话就用 showFromRect:inView:animated:（默认会有一个向下的箭头，调整 rect 参数，除了会改变 UIActionSheet 的位置，也可能改变其箭头的方向和位置）
}

// 实现 UIActionSheetDelegate 协议（还有别的，详见文档）
#pragma mark -  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"clicked: %ld\n", buttonIndex];
}

@end
