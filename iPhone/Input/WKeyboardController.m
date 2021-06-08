// - (BOOL)textFieldShouldReturn:(UITextField *)textField 可用于捕获按键，比如回车键



// [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];



// resign 此 view 下的的所有 textField 的 first responder
// [self.view endEditing:YES];





//
// 演示虚拟键盘的应用
//

#import "WKeyboardController.h"

@interface WKeyboardController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation WKeyboardController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化一个 UITextView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 250)];
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor blueColor];


    // 软键盘的布局（UIKeyboardType 枚举：全键盘，url键盘，数字键盘，电话键盘等）
    self.textView.keyboardType = UIKeyboardAppearanceDefault;
    // 软键盘的外观（UIKeyboardAppearance 枚举：亮色，暗色等）
    self.textView.keyboardAppearance = UIKeyboardAppearanceLight;
    // return 键的外观（UIReturnKeyType 枚举：join按钮，search按钮等）
    self.textView.returnKeyType = UIReturnKeyDefault;
    

    // 将此文本框设置为 first responder，即获得焦点（弹出软键盘）
    [self.textView becomeFirstResponder];
    
    [self.view addSubview:self.textView];
    
    
    // 通过 NSNotificationCenter 来监听软键盘的显示和隐藏
    // UIKeyboardWillShowNotification, UIKeyboardDidShowNotification, UIKeyboardWillHideNotification, UIKeyboardDidHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIKeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIKeyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIKeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIKeyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];

    
    // 定义一个 UITapGestureRecognizer，以便点击空白区域时，隐藏软键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)onTap:(UITapGestureRecognizer *)tapGesture
{
    // 隐藏软键盘
    [self.textView resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    // 移除本页的全部通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onUIKeyboardWillShowNotification:(NSNotification *)notification
{
    // 获取通知过来的 userInfo
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取 userInfo 中的全部信息
    NSString *result = @"";
    NSArray *keys = [userInfo allKeys];
    for (int i=0; i<keys.count; i++)
    {
        NSString *key = [keys objectAtIndex:i];
        NSString *value = [userInfo objectForKey:key];
        result = [result stringByAppendingFormat:@"%@:%@\n", key, value];
    }
    self.textView.text = result;
    
    // userInfo 中的信息包括如下：
    // UIKeyboardCenterBeginUserInfoKey:NSPoint: {160, 676}
    // UIKeyboardFrameEndUserInfoKey:NSRect: {{0, 352}, {320, 216}} // 键盘弹出后的位置和大小
    // UIKeyboardCenterEndUserInfoKey:NSPoint: {160, 460}
    // UIKeyboardAnimationDurationUserInfoKey:0.25 // 弹出键盘动画的持续时间
    // UIKeyboardFrameChangedByUserInteraction:0
    // UIKeyboardBoundsUserInfoKey:NSRect: {{0, 0}, {320, 216}}
    // UIKeyboardAnimationCurveUserInfoKey:7
}

- (void)onUIKeyboardDidShowNotification:(NSNotification *)notification
{
    // 获取软键盘的位置和大小
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    
    self.textView.text = [NSString stringWithFormat:@"%@\n %1.0f, %1.0f, %1.0f, %1.0f", @"UIKeyboardDidShowNotification", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

- (void)onUIKeyboardWillHideNotification:(NSNotification *)notification
{
    // 获取软键盘的位置和大小
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    
    self.textView.text = [NSString stringWithFormat:@"%@\n %1.0f, %1.0f, %1.0f, %1.0f", @"UIKeyboardWillHideNotification", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

- (void)onUIKeyboardDidHideNotification:(NSNotification *)notification
{
    // 获取软键盘的位置和大小
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    
    self.textView.text = [NSString stringWithFormat:@"%@\n %1.0f, %1.0f, %1.0f, %1.0f", @"UIKeyboardDidHideNotification", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

@end
