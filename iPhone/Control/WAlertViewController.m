//
// 演示 UIAlertView 的应用
//

#import "WAlertViewController.h"

@interface WAlertViewController ()<UIAlertViewDelegate>

@end

@implementation WAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 弹出一个 alertView
    //     otherButtonTitles 是个数组，可以支持多个
    //     delegate 可以用于响应按钮事件
    // 默认样式是：UIAlertViewStyleDefault，即没有任何输入框
    [[[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", @"ok2", nil] show];
    
    
    // 通过 setAlertViewStyle 设置 UIAlertView 的样式
    // UIAlertViewStylePlainTextInput - 有一个输入框的 UIAlertView
    UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alertView2 setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView2 show];
    
    
    
    // UIAlertViewStyleSecureTextInput - 有一个密码输入框的 UIAlertView
    // 如果要获取 UIAlertView 上的文本输入框，就通过 textFieldAtIndex: 即可
    UIAlertView *alertView3 = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alertView3 setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [alertView3 textFieldAtIndex:0].keyboardType = UIKeyboardTypeDecimalPad;
    [alertView3 show];
    
    
    // UIAlertViewStyleLoginAndPasswordInput - 有一个文本输入框和一个密码输入框的 UIAlertView
    UIAlertView *alertView4 = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alertView4 setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [alertView4 show];
}

// UIAlertView 中的按钮被点击后触发的事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // buttonIndex - 是按钮的在 UIAlertView 的全部按钮集合中的索引位置
    
    // 通过 buttonTitleAtIndex 获取指定索引位置的按钮的 title
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    self.lblMsg.text = [NSString stringWithFormat:@"button title: %@", buttonTitle];
    
    if (alertView.alertViewStyle != UIAlertViewStyleDefault)
    {
        // textFieldAtIndex - 获取指定索引位置的 UITextField
        NSString *text1 = [alertView textFieldAtIndex:0].text;
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\ntextField1: %@", text1];
    }
    
    if (alertView.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput)
    {
        NSString *text2 = [alertView textFieldAtIndex:1].text;
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"\ntextField2: %@", text2];
    }
}

@end
