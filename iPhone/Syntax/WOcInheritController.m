//
// 用于演示类继承
//

#import "WOcInheritController.h"

@interface WOcInheritController ()

@property (strong, nonatomic) WOcSuper *ocSuper;
@property (strong, nonatomic) WOcSub *ocSub;

@end

@implementation WOcInheritController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 分配内存空间，初始化
    self.ocSuper = [[WOcSuper alloc] init];
    self.ocSub = [[WOcSub alloc] init];
    
    // 调用父类的方法
    self.lblMsg.text = [self.ocSuper doSomething:@"param1" paramDescription:@"param2"];
    self.lblMsg2.text = [WOcSuper doStaticMethod];
    
    // 调用子类的方法
    self.lblMsg3.text = [self.ocSub doSomething:@"param1" paramDescription:@"param2"];
    self.lblMsg4.text = [WOcSub doStaticMethod];
    
    // 调用属性
    self.lblMsg5.text = self.ocSub.name;
    
    // id 是一个可以指向任何类型的指针，相当于 object
    id obj = self.ocSub;
    
    // isKindOfClass - 对象是否是指定的类型（包括继承）
    bool a = [obj isKindOfClass:[WOcSuper class]]; // true
    
    // isMemberOfClass - 对象是否是指定的类型（不包括继承）
    bool b = [obj isMemberOfClass:[WOcSuper class]]; // false
    
    // @selector - 方法名
    SEL s1 = @selector(doSomething:paramDescription:); // 方法有多个参数（有一个参数的话就是类似：“method:”）
    SEL s2 = @selector(doStaticMethod); // 方法没有参数（有一个参数的话就是类似：“method:”）
    
    // respondsToSelector - 对象是否有指定的方法
    bool c = [obj respondsToSelector:s1]; // true
    bool d = [WOcSub respondsToSelector:s2]; // ture

    self.lblMsg6.text = [NSString stringWithFormat:@"%i, %i, %i, %i", a, b, c, d];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
