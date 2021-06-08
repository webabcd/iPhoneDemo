//
// 演示 UISlider 的应用
//

#import "WSliderController.h"

@interface WSliderController ()

@end

@implementation WSliderController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 演示 slider 的基本用法
    [self demo1];
    // 演示如何自定义 slider 的外观
    [self demo2];
}

- (void)demo1
{
    // 最小值
    self.slider.minimumValue = 0.0f;
    // 最大值
    self.slider.maximumValue = 100.0f;
    // 当前值
    self.slider.value = 30.0f;
    
    // target/action 用于捕获 value 的变化事件
    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

// slider 的 value 发生变化时触发的事件
- (void)sliderValueChanged:(UISlider *)slider
{
    // 打印 slider 的当前的 value 值
    self.lblMsg.text = [NSString stringWithFormat:@"%1.1f", slider.value];
}



- (void)demo2
{
    self.slider2.minimumValue = 0.0f;
    self.slider2.maximumValue = 100.0f;
    self.slider2.value = 30.0f;
    
    // thumb 左侧的颜色值
    self.slider2.minimumTrackTintColor = [UIColor redColor];
    // thumb 右侧的颜色值
    self.slider2.maximumTrackTintColor = [UIColor greenColor];
    // thumb 的颜色值（ios7 无效）
    self.slider2.thumbTintColor = [UIColor orangeColor];
    // slider 左侧的提示图片
    self.slider2.minimumValueImage = [UIImage imageNamed:@"A.png"];
    // slider 右侧的提示图片
    self.slider2.maximumValueImage = [UIImage imageNamed:@"B.png"];
    
    [self.slider2 addTarget:self action:@selector(slider2ValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)slider2ValueChanged:(UISlider *)slider
{
    self.lblMsg2.text = [NSString stringWithFormat:@"%1.1f", slider.value];
}

@end
