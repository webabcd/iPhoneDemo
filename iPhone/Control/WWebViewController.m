//
// 演示 UIWebView 的应用
//

#import "WWebViewController.h"

@interface WWebViewController ()<UIWebViewDelegate>

@end

@implementation WWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 演示如何使用 UIWebView 加载远程网页，以及如何监听网页加载开始事件和网页加载完成事件
    [self demo1];
    
    // 演示如何使用 UIWebView 加载本地网页，以及 UIWebView 如何和 javascript 交互（相关的 html 代码详见：Supporting Files/forWebView.html）
    [self demo2];
}

- (void)demo1
{
    // 实例化一个 UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 100, 280, 100)];
    // 是否让网页缩放以适应容器的大小
    webView.scalesPageToFit = YES;
    // UIWebViewDelegate 协议
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    // 加载指定的网页（注：UIWebView 被 add 到窗口后再 loadRequest）
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://webabcd.cnblogs.com"]];
    [webView loadRequest:request];
}

- (void)demo2
{
    // 实例化一个 UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 300, 280, 100)];
    webView.scalesPageToFit = NO;
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    // 以 utf-8 的方式加载本地网页（即通过加载 html 字符串的方式实现）
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"forWebView.html"];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}


#pragma mark -
#pragma mark UIWebViewDelegate 协议
// 开始加载 html
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

// html 加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    
    // file 开头的肯定是本地文件
    if ([webView.request.URL.absoluteString rangeOfString:@"file:"].location == 0)
    {
        // stringByEvaluatingJavaScriptFromString - oc 调用 js，即在 html 中执行 javascript，返回值为 js 返回的数据
        NSString *jsResult = [webView stringByEvaluatingJavaScriptFromString:@"hello('webabcd');"];
        NSLog(@"oc call js return value: %@", jsResult);
    }
}

// html 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"failed");
}

// 当网页将要发生跳转时插一脚，返回 YES 则允许跳转，返回 NO 则禁止跳转
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request.URL: %@", request.URL.absoluteString);
    
    // 如果将要跳转的 url 以 jstooc 开头，则认为是 js 调用 oc 的自定义协议，即可实现 javascript 调用 objective-c
    if ([request.URL.absoluteString rangeOfString:@"jstooc:"].location == 0)
    {
        NSString *jsonString = [request.URL.absoluteString substringFromIndex:7];
        jsonString = [jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSError *myError;
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
        if (dict != nil && myError == nil)
        {
        }
        [[[UIAlertView alloc] initWithTitle:@"js to oc" message:request.URL.absoluteString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
        
        // 由于认为这个是 js 调用 oc，所以不需要跳转
        return NO;
    }
    else
    {
        // 允许跳转
        return YES;
    }
}


@end
