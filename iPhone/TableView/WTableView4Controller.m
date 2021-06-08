//
// 演示如何让 UITableView 分组显示数据
//
// UITableView 一共有两种 style，分别是：UITableViewStylePlain 和 UITableViewStyleGrouped，需要在初始化时指定，指定后不能修改
//

#import "WTableView4Controller.h"

@interface WTableView4Controller ()<UITableViewDataSource>
{
    // 数据源
    NSDictionary *_items;
    
    // 保存 section header
    NSArray *_groups;
}

@end

@implementation WTableView4Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 加载 siteMap.plist 中的数据
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistUrl = [bundle URLForResource:@"siteMap" withExtension:@"plist"];
    
    // 拿到全部数据
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistUrl];
    _items = dictionary;
    
    // 拿到 section header 的数据
    _groups = [[_items allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        NSString *first = (NSString *)obj1;
        NSString *second = (NSString *)obj2;
        return [first compare:second];
    }];

    // style 是只读的，其只能在 init 初始化时指定，或 storyboard 中指定
    // self.tableView.style = UITableViewStyleGrouped;
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor orangeColor];
}


#pragma mark -
#pragma mark UITableViewDataSource
// 告诉 UITableView 一共要有几个 section（默认为 1 个）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_groups count];
}

// 指定的 section 一共有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [_groups objectAtIndex:section];
    return [[_items objectForKey:key] count];
}

// 此 section 的 header 的文本内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_groups objectAtIndex:section];
}

// 右侧索引列表的数据，不需要的话不实现就好
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexes = [[NSMutableArray alloc] initWithObjects:nil];
    for (NSString *item in _groups)
    {
        [indexes addObject:[[item componentsSeparatedByString:@"."] objectAtIndex:0]];
    }
    return indexes;
}

// 构造每个 row 的 cell（这是根据你的 numberOfSectionsInTableView 和 numberOfRowsInSection 的设置来决定如何调用这个函数的）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 当前需要构造的 cell 的所属的 section 的索引位置
    NSUInteger section = [indexPath section];
    // 当前需要构造的 cell 在其所属 section 中的索引位置
    NSUInteger row = [indexPath row];
    
    // 获取当前 section 的全部数据
    NSString *key = [_groups objectAtIndex:section];
    NSArray *items = [_items objectForKey:key];
    
    // 获取当前 section 的指定行的数据
    NSString *item = [items objectAtIndex:row];
    
    static NSString *reusableCellQueueId = @"WTableView2Controller_reusableCellQueueId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellQueueId];
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableCellQueueId];
    }
    
    cell.textLabel.text = [[item componentsSeparatedByString:@"|"] objectAtIndex:0];
    return cell;
}

@end