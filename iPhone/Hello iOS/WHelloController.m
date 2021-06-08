//
// 没什么可说的 Hello World
//

#import "WHelloController.h"

@interface WHelloController ()

@end

@implementation WHelloController

- (IBAction)btnHelloPressed:(id)sender
{
    self.lblMsg.text = [@"hello: " stringByAppendingString:(self.name)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.name = @"webabcd";
}

// 收到内存不够用的警告时所调用的方法（注意: viewWillUnload 和 viewDidUnload 在 ios6 以上已经被弃用了）
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
