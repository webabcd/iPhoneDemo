// 还要写如何监听用户输入事件




//
// 演示 UITextField 的应用
//

#import "WTextFieldController.h"

@interface WTextFieldController ()<UITextFieldDelegate>

@end

@implementation WTextFieldController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 实例化一个 UITextField
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 280, 100)];
    
    // 设置文本框的边框样式
    // UITextBorderStyleNone, UITextBorderStyleRoundedRect, UITextBorderStyleLine, UITextBorderStyleBezel
    text.borderStyle = UITextBorderStyleRoundedRect;
    // 背景色
    text.backgroundColor = [UIColor yellowColor];
    // 前景色
    text.textColor = [UIColor redColor];
    
    // 当没有输入内容时的水印文字提示
    text.placeholder = @"placeholder";
    // 内容
    // text.text = @"abc";
    // 是否是密码框（即每输入一个字符就变成一个圆点）
    // text.secureTextEntry = YES;

    // 清空按钮（文本框中的一个叉号）的显示方式
    // UITextFieldViewModeWhileEditing - 编辑时显示
    // UITextFieldViewModeUnlessEditing － 非编辑时显示
    // UITextFieldViewModeAlways - 总是显示
    // UITextFieldViewModeNever - 从不显示
    text.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 再次编辑时是否清空内容
    text.clearsOnBeginEditing = YES;
    
    // 文字的水平对齐方式
    text.textAlignment = NSTextAlignmentLeft;
    // 文字的垂直对齐方式
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    // 自动大小写的模式
    // ITextAutocapitalizationTypeNone - 不自动大写
    // UITextAutocapitalizationTypeWords - 单词首字母自动大写
    // UITextAutocapitalizationTypeSentences - 句子首字母自动大写
    // UITextAutocapitalizationTypeAllCharacters - 全部自动大写
    text.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // 设置文本框的左侧的图片（设置右侧图片用 rightView）
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Son.jpg"]];
    text.leftView = imageView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
    // 软键盘的布局（UIKeyboardType 枚举：全键盘，url键盘，数字键盘，电话键盘等）
    text.keyboardType = UIKeyboardAppearanceDefault;
    // 软键盘的外观（UIKeyboardAppearance 枚举：亮色，暗色等）
    text.keyboardAppearance = UIKeyboardAppearanceLight;
    // return 键的外观（UIReturnKeyType 枚举：join按钮，search按钮等）
    text.returnKeyType = UIReturnKeyDefault;
    
    // 是否可用（NO － 为禁用）
    text.enabled = YES;
    text.delegate = self;
    // 将此文本框设置为 first responder，即获得焦点（弹出软键盘）
    [text becomeFirstResponder];
    
    // 显示文本框
    [self.view addSubview:text];
    
    
    // 通过 NSNotificationCenter 来监听软键盘的显示和隐藏
    // UIKeyboardWillShowNotification, UIKeyboardDidShowNotification, UIKeyboardWillHideNotification, UIKeyboardDidHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uiKeyboardShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)uiKeyboardShow:(NSNotification *)notification
{
    // 获取软键盘的位置和大小
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    
    // 在 3.5 寸模拟器上显示为：0.000000, 264.000000, 320.000000, 216.000000
    NSLog(@"%f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}


#pragma mark -
#pragma mark UITextFieldDelegate
// 用户按下了 return 键
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 取消文本框的焦点（收起软键盘）
    [textField resignFirstResponder];
    
    // 是否允许用户按下 return 键后结束编辑
    return YES;
}

// 指定输入框是否可被修改
// YES - 可以修改，默认值； NO - 只读，不会出现软键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// 输入框获取到焦点时，所执行的方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

// 当编辑结束时，是否允许结束此次编辑
// YES - 退出编辑模式，失去 first responder，默认值； NO - 继续维持编辑模式
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

// 失去 first responder 时执行
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

// 是否允许用户点击“叉号”清空全部数据
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

@end
