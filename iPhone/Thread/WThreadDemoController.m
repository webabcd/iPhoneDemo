//
// 演示 NSThread 的应用
//

#import "WThreadDemoController.h"

@interface WThreadDemoController ()

@end

@implementation WThreadDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)buttonPressed:(id)sender
{
    // 实例化一个 NSThread，参数一看就知道是什么意思，就不细说了
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"http://images.cnblogs.com/mvpteam.gif"];
    // 设置优先级（0 - 1 之间，0 最低，1 最好，0.5 默认）
    thread.threadPriority = 0.5f;
    // 启动这个线程
    [thread start];
    
    
    // 停止指定的线程
    // [thread cancel];
    // 停止当前线程
    // [NSThread exit];
    
    
    // 直接启动一个线程
    // [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:@"http://images.cnblogs.com/mvpteam.gif"];
    
    // 获取当前线程
    // [NSThread currentThread];
    
    
    // 以下 self 的函数均来自 NSObject
    
    // 在 UI 线程上执行指定的函数
    // [self performSelectorOnMainThread:<#(SEL)#> withObject:<#(id)#> waitUntilDone:<#(BOOL)#>];
    
    // 在指定的线程上执行指定的函数
    // [self performSelector:<#(SEL)#> onThread:<#(NSThread *)#> withObject:<#(id)#> waitUntilDone:<#(BOOL)#>]
    
    // 在当前线程上，延迟执行指定的函数
    // [self performSelector:<#(SEL)#> withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>];
    
    // 新开一个线程，并执行指定的方法
    // [self performSelectorInBackground:@selector(downloadImage:) withObject:@"http://images.cnblogs.com/mvpteam.gif"];
}

- (void)downloadImage:(NSString *)imageUrl
{
    // 当前线程睡 3 秒
    [NSThread sleepForTimeInterval:3.0f];
    
    // 下载图片
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    if (image != nil)
    {
        // 在 UI 线程上显示图片
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
}

- (void)updateUI:(UIImage *)image
{
    self.imageView.image = image;
}


@end
