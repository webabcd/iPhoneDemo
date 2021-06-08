//
// 演示如何做 http 通信
//

#import "WHttpController.h"

@interface WHttpController ()

@end

@implementation WHttpController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.lblMsg setNumberOfLines:0];
    [self.lblMsg setLineBreakMode:NSLineBreakByCharWrapping];
    
    // url 编解码的 demo
    [self urlEncodeDemo];
    
    // http 通信的 demo
    [self httpDemo];
}

// url 编解码的 demo
- (void)urlEncodeDemo
{
    NSString *str = @"?&中文webabcd";
    
    // url 编解码的方式1（? & 等特殊字符不会编码）
    NSString *strEncode1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strDecode1 = [strEncode1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // url 编解码的方式2（可以指定需要编码的特殊字符）
    NSString *strEncode2 = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                        (__bridge CFStringRef)str,
                                                                                        NULL,
                                                                                        (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", // 指定需要编码的特殊字符
                                                                                        kCFStringEncodingUTF8);
    NSString *strDecode2 = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                        (__bridge CFStringRef)str,
                                                                                        (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8);
    
    self.lblMsg.text = strEncode1;
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:strDecode1];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:strEncode2];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:strDecode2];
}

// http 通信的 demo
- (void)httpDemo
{
    // 
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSString *dataString = @"param1=abc&param2=xyz";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [request setTimeoutInterval:30.0f];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //sendSynchronousRequest 同步   同步的也要好好写
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%d", error.code];
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingString:error.localizedDescription];
             });
         }
         else
         {
             int responseCode = [(NSHTTPURLResponse *)response statusCode];
             NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%d", responseCode];
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"\n"];
                 self.lblMsg.text = [self.lblMsg.text stringByAppendingString:result];
             });
         }
     }];
}

@end
