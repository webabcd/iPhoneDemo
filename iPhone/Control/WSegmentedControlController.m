//
// 演示 UISegmentedControl 的应用
//

#import "WSegmentedControlController.h"

@interface WSegmentedControlController ()

@end

@implementation WSegmentedControlController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *array = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", nil];
    
    // 实例化 UISegmentedControl，并指定初始数据
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    segmentedControl.frame = CGRectMake(20, 100, 280, 50);
    
    // 设置被选中的 segment 的索引
    segmentedControl.selectedSegmentIndex = 1;
    // 设置主题颜色
    segmentedControl.tintColor = [UIColor orangeColor];
    // 设置样式
    // UISegmentedControlStyleBar, UISegmentedControlStyleBordered, UISegmentedControlStylePlain, UISegmentedControlStyleBezeled
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
    // 是否点击 segment 后只是闪一下（不会有选中效果）
    segmentedControl.momentary = NO;
    
    // 修改指定索引位置的 segment 的 title
    [segmentedControl setTitle:@"1" forSegmentAtIndex:0];
    // 在指定的索引位置上插入新的 segment
    [segmentedControl insertSegmentWithTitle:@"2" atIndex:1 animated:NO];
    // 删除指定索引位置的 segment
    [segmentedControl removeSegmentAtIndex:6 animated:NO];
    // 修改指定索引位置的 segment 的宽度
    [segmentedControl setWidth:80 forSegmentAtIndex:0];
    // 修改指定索引位置的 segment 的 enabled
    [segmentedControl setEnabled:NO forSegmentAtIndex:5];
    
    
    // 获取指定索引位置的 segment 的 title
    NSString *title = [segmentedControl titleForSegmentAtIndex:0];
    // 获取 UISegmentedControl 的 segment 的数量
    int count = segmentedControl.numberOfSegments;
    // 获取指定索引位置的 segment 的宽度
    int index = [segmentedControl widthForSegmentAtIndex:0];
    
    
    // 添加一个 target action，用于响应 UIControlEventValueChanged 事件（即选中不同的 segment 时所触发的事件）
    [segmentedControl addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:segmentedControl];
}

- (void)myAction:(UISegmentedControl *)segmentedControl
{
    // 获取被选中的 segment 的索引
    int index = segmentedControl.selectedSegmentIndex;
    NSString *msg = [NSString stringWithFormat:@"selected index: %i", index];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
