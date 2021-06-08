//
// 演示 UITextView 的应用
//
// 注意：UITextView 继承自 UIScrollView
//

#import "WTextViewController.h"

@interface WTextViewController ()

@end

@implementation WTextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 实例化一个 UITextView
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
    text.backgroundColor = [UIColor yellowColor];
    text.text = @"a\nb\nc\nd\ne\nf\ng\nh\ni\nj\nk\nl\nm\nn\no\np\nq\nr\ns\nt\nu\nv\nw\nx\ny\nz";
    // 是否需要滚动
    text.scrollEnabled = YES;
    

    // 以下这些属性，等写到 ScrollView 时再细说
    // text.contentInset, text.contentOffset, text.contentSize
    
    
    [self.view addSubview:text];
}

@end
