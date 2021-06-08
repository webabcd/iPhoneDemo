//
// 演示 NSOperation 和 NSOperationQueue 的应用
//
// NSOperationQueue 是线程池，NSOperation 是可以加入到线程池中的任务
// NSOperation 有两个系统定义的子类：NSInvocationOperation（执行一个 SEL） 和 NSBlockOperation（执行一个或多个 block，多个 block 并发执行）
// 通过继承 NSOperation 可实现自定义的 operation，详细内容查文档或者网上搜索吧
//

#import "WOperationDemoController.h"

@interface WOperationDemoController ()

@end

@implementation WOperationDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)buttonPressed:(id)sender
{
    // 实例化一个 NSInvocationOperation，并指定 SEL
    NSInvocationOperation *opInvocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"http://images.cnblogs.com/mvpteam.gif"];
    
    // 实例化一个 NSBlockOperation，在一个 NSBlockOperation 中可以添加多个 block（多个 block 并发执行）
    NSBlockOperation *opBlock = [NSBlockOperation blockOperationWithBlock:^
    {
        NSLog(@"block1");
    }];
    [opBlock addExecutionBlock:^
    {
        NSLog(@"block2");
    }];
    
    // 实例化一个 NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 设置队列中可包含的 operation 的最大数量（默认是 －1，无限制）
    queue.maxConcurrentOperationCount = 10;
    
    // 将 operation 加入线程池
    [queue addOperation:opInvocation];
    [queue addOperation:opBlock];
    
    // 停止线程池中的全部 operation
    // [queue cancelAllOperations];
    
    // 线程池中的 operation 的总数
    // [queue operationCount];
    
    // 获取线程池中的全部 operation
    // [queue.operations];
    
    // 停止指定的 operation
    // [opInvocation cancel];
    // [opBlock cancel];
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
