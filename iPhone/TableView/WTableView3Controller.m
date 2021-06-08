//
// 演示如何自定义 UITableView 的单元格样式
//
// 自定义的 cell 参见：WCustomTableViewCell
//

#import "WTableView3Controller.h"

@interface WTableView3Controller () <UITableViewDataSource, UITableViewDelegate>
{
    // 数据源
    NSArray *_array;
    
    // cell 队列 id
    NSString *_reusableCellQueueId;
}

@end

@implementation WTableView3Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 构造数据
    _array = @[@"webabcd 01", @"webabcd 02", @"webabcd 03", @"webabcd 04", @"webabcd 05", @"webabcd 06", @"webabcd 07", @"webabcd 08", @"webabcd 09", @"webabcd 10", @"webabcd 11", @"webabcd 12", @"webabcd 13", @"webabcd 14", @"webabcd 15", @"webabcd 16", @"webabcd 17", @"webabcd 18", @"webabcd 19", @"webabcd 20"];
    
    
    // 指定 cell 队列 id，注意：此值要于你 nib 中的 UITableViewCell 中的 Identifier 中的值一致（在 attributes inspector 设置）
    _reusableCellQueueId = @"CustomTableViewCell";
    // 加载 nib
    UINib *nib = [UINib nibWithNibName:@"WCustomTableViewCell" bundle:nil];
    // 注册此 nib 到指定的 cell 队列
    [self.tableView registerNib:nib forCellReuseIdentifier:_reusableCellQueueId];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从 cell 队列中取出 WCustomTableViewCell（注意：只要之前注册了 nib，则肯定能取出）
    WCustomTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:_reusableCellQueueId];
    
    myCell.label1.text = [_array objectAtIndex:[indexPath row]];
    myCell.label2.text = @"subTitle";
    myCell.imageView.image = [UIImage imageNamed:@"A.png"];
    myCell.imageView.highlightedImage = [UIImage imageNamed:@"B.png"];
    
    return myCell;
}


#pragma mark -
#pragma mark UITableViewDelegate
// 指定 cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end