//
// 演示 UIDatePicker 的应用
//

#import "WDatePickerController.h"

@interface WDatePickerController ()

@end

@implementation WDatePickerController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 设置允许选择的最大值
    // self.datePicker.maximumDate
    // 设置允许选择的最小值
    // self.datePicker.minimumDate
    
    // target/action - UIDatePicker 的值发生变化是触发的事件
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
}

// UIDatePicker 的选中的 date 发生了变化
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    self.lblMsg.text = [NSString stringWithFormat:@"%@", datePicker.date];
}



- (IBAction)btnTimePressed:(id)sender
{
    // datePickerMode = UIDatePickerModeTime - 时间选择框
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    // 时间选择框的选择分钟的那一列，分钟的间隔（如果设置为 10，则可选择的分钟为 0, 10, 20, 30, 40, 50）
    self.datePicker.minuteInterval = 10;
}

- (IBAction)btnDatePressed:(id)sender
{
    // datePickerMode = UIDatePickerModeDate - 日期选择框
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

- (IBAction)btnDateAndTimePressed:(id)sender
{
    // datePickerMode = UIDatePickerModeDateAndTime - 日期和时间选择框
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    // 设置 UIDatePicker 当前选中的 date
    [self.datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:86400 * 3] animated:YES];
}

- (IBAction)btnCountDownTimerPressed:(id)sender
{
    // datePickerMode = UIDatePickerModeDateAndTime - 倒计时选择框
    self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    // 倒计时选择框上显示的时间（150 * 60 就是 2小时30分钟）
    self.datePicker.countDownDuration = 150 * 60;
}

@end
