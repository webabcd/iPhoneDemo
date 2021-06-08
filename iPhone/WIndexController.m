//
//  WIndexController.m
//  iPhone
//
//  Created by iMac on 9/26/13.
//  Copyright (c) 2013 webabcd. All rights reserved.
//

#import "WIndexController.h"

@interface WIndexController ()

@end

@implementation WIndexController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistUrl = [bundle URLForResource:@"siteMap" withExtension:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistUrl];
    self.items = dictionary;
    NSArray *keys = [self.items allKeys];
    self.groups = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *first = (NSString *)obj1;
        NSString *second = (NSString *)obj2;
        return [first compare:second];
    }];
    
    
    // 本例是 app 的入口，直接将 Navigation Controller 拖进来即可
    // 如果需要自己创建 NavigationController 则通过 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:<#(UIViewController *)#>]; 然后 [self.view addSubview:self.navigationController.view]; 即可
    // 指定导航栏的 title
    self.navigationItem.title = @"webabcd ios";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnNavigate:(UIButton *)sender
{
   //[self.navigationController popToRootViewControllerAnimated:YES]; // 返回首页
    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *controller = [s instantiateViewControllerWithIdentifier:@"aaa"];
    [self.navigationController pushViewController:controller animated:YES];

    //WHelloController *helloController = [self.storyboard instantiateViewControllerWithIdentifier:@"aaa"];
    //[self.navigationController pushViewController:helloController animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [self.groups objectAtIndex:section];
    NSString *storyboardName = [[key componentsSeparatedByString:@"."] objectAtIndex:1];
    NSArray *items = [self.items objectForKey:key];
    NSString *item = [items objectAtIndex:row];
    NSLog(@"c: %@, d: %@", key, item);
    
    NSString *storyboardId = [[item componentsSeparatedByString:@"|"] objectAtIndex:1];
    
    UIStoryboard *s = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

    UIViewController *controller = [s instantiateViewControllerWithIdentifier:storyboardId];
   // UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:storyboardId];
    [self.navigationController pushViewController:controller animated:YES];

}

// 写一下这个 pragma mark 是干嘛的
#pragma mark -
#pragma mark table view data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 这个方法用来告诉表格有几个分组
    return [self.groups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.groups objectAtIndex:section];
    NSArray *items = [self.items objectForKey:key];
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [self.groups objectAtIndex:section];
    NSArray *items = [self.items objectForKey:key];
    
    static NSString *GroupedTableIdentifier = @"GroupedTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GroupedTableIdentifier];
    
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GroupedTableIdentifier];
    }
    
    cell.textLabel.text = [[[items objectAtIndex:row] componentsSeparatedByString:@"|"] objectAtIndex:0];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.groups objectAtIndex:section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexes = [[NSMutableArray alloc] initWithObjects:nil];
    for (NSString *item in self.groups)
    {
        [indexes addObject:[[item componentsSeparatedByString:@"."] objectAtIndex:0]];
    }
    return indexes;
}


@end
