//
// 演示 xml 的解析
//
// 通过 NSXMLParser 解析 xml 类似于 android 中的 SAX 方式解析 xml
//

#import "WXmlController.h"

@interface WXmlController ()

@end

@implementation WXmlController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.lblMsg.numberOfLines = 0;
    
    self.lblMsg.text = @"";
    // 需要解析的 xml 字符串
    NSString *xmlString = @"<books><book id=\"1\"><title>abc</title><author>xyz</author></book><book id=\"2\"><title>abc2</title><author>xyz2</author></book></books>";
    
    // 将 xml 字符串转换为 NSData
    NSData *data = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 实例化 NSXMLParser，并指定 delegate
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    
    // 开始解析 xml，解析完成后返回一个 bool 类型的  以告知是否解析成功
    bool isOk = parser.parse;
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"解析是否成功: %d", isOk];
}

// 开始解析前
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"开始解析\n"];
}

// 当解析器对象遇到 xml 的开始标记时，就会调用这个方法
// 例如遇到了 <book id=\"1\"> 就会调用这个方法，其中的属性全部保存在 attributeDict 中
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    // elementName - 元素名称
    if ([elementName isEqualToString:@"book"])
    {
        // attributeDict - 保存了对应的 elementName 中的全部属性集合
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"book id: %@\n", [attributeDict objectForKey:@"id"]];
    }
    else
    {
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@: ", elementName];
    }
}

// 当解析器找到了开始标记和结束标记之间的字符串时，调用这个方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@\n", string];
}

// 当解析器找到了开始标记和结束标记之间的 CDATA 时，调用这个方法
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    
}

// 当解析器遇到了 xml 的结束标记时，调用这个方法（也就是一段开闭 xml 的完成）
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

// 解析完成后
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.lblMsg.text = [self.lblMsg.text stringByAppendingString:@"解析完成\n"];
}

@end
