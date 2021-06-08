//
// 演示 UIPickerView 的应用
//
// row - 行
// component - 列
//

#import "WPickerViewController.h"

@interface WPickerViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation WPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 是否突出显示选中的项（ios7 中无效）
    self.pickerView.showsSelectionIndicator = YES;
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    // 刷新全部列
    // [self.pickerView reloadAllComponents];
    // 刷新指定的列
    // [self.pickerView reloadComponent:<#(NSInteger)#>];
}


#pragma mark -
#pragma mark UIPickerViewDataSource
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}


#pragma mark -
#pragma mark UIPickerViewDelegate
// 指定行指定列中显示的文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"row:%d, col:%d", (int)row, (int)component];
}

// 指定行指定列显示的 UIView
// - (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

// 指定列的行高
// - (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

// 指定列的宽度
// - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component


// 某一行某一列被选中
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.lblMsg.text = [NSString stringWithFormat:@"row:%d, col:%d", (int)row, (int)component];
}

@end
