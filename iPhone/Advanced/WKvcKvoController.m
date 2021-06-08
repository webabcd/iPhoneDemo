//
// 演示 kvc kvo 的应用
//
// kvc - key value coding（通过 key 访问 value，即通过属性名称来访问属性的值）
// kvo - key value observing（指定的对象的指定属性发生变化时，发出通知）
//
// NSObject 支持 kvc 和 kvo，kvc 的存在价值之一就是为了实现 kvo
//

#import "WKvcKvoController.h"

#include <mach/mach.h>

@interface WKvcKvoController ()

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@property (nonatomic, strong) NSString *name;

@end

@implementation WKvcKvoController

// 从 stroyboard 加载的会通过 initWithCoder 初始化
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // 注册 kvo（指定的对象的指定属性发生变化时，发出通知）
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.lblMsg setNumberOfLines:0];
    self.lblMsg.text = @"";
    
    self.name = @"webabcd";
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@\n", self.name];
    
    // 这就叫做 kvc，通过 key 访问 value，即通过属性名称来访问属性的值
    [self setValue:@"wanglei" forKey:@"name"];
    self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"%@\n", [self valueForKey:@"name"]];

}

// 收到 kvo 的通知
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"name"])
    {
        self.lblMsg.text = [self.lblMsg.text stringByAppendingFormat:@"kvo: %@, %@\n", [change valueForKey:@"old"], [change valueForKey:@"new"]];
    }
}

- (void)dealloc
{
    // 取消注册 kvo
    [self removeObserver:self forKeyPath:@"name"];
}



@end
