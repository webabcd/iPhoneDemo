//
// 没什么可说的 Hello World
//
//
// 开发模式：MVC
//
//
// cocoa touch 包括：
// Foundation - 数字、字符串、集合、日期、线程等。类前缀：NS
// UIKit（UIKit 属 cocoa touch，AppKit 属 cocoa） - 界面相关，如控件、事件、画图等。类前缀：UI
//
//
// 新建项目时各个字段的说明如下：
// Product Name(项目名称): iPhone
// Organization Name(组织名称): webabcd
// Company Identifier(公司标识): webabcd.cnblogs.com
// Class Prefix(类前缀，oc 没有 namespace 或 package 的概念，需要用类前缀来区分): W
// Devices(iPhone 或 iPad 或 Universal): iPhone
//
//
// 在代码上按住 option 键可以查看文档
// 在代码上按住 command 然后单机鼠标可以转到对应的头文件
//
//
// storyboard 的简短说明
// 在 Custom Class 中写上对应的 controller 类的名字，就可以把 view 和 controller 关联起来
// 按住 ctrl 拖动（或者右键拖动）控件到 controller 可以让 controller 生成一个 IBOutlet 属性，并与 view 中的控件关联（也可以让 storyboard 中的控件关联 controller 中的已有的 IBOutlet）
// Storyboard ID 用于找到指定的 storyboard
// 想要查看与创建 storyboard 中的 UIView 与 controller 的关联的话，还可以通过 storyboard 编辑界面的右侧窗口的上窗口的 connections inspector 来实现（可以拖拽小圆点）
// 另外，新建 xib 后，第一件事就是在 File's Owner 中设置 Custom Class 中的 Class 为你对应的 Controller，然后再在其 connections inspector 中拖拽 view 与 xib 中的 view 关联
//
//
// xib 就是 xml 方式的 nib
// 无论是 nib 还是 storyboard，拖控件进来后，别忘了在 “identity inspector” 中的 class 中指明其关联的类
//
//
// 在项目中建文件夹的方法
// 新建文件时，可以选择文件的保存路径，保存到想要保存的文件夹内即可
// 先在 Finder 中建立好文件夹和文件，然后通过 Add Files to "xxx" 选择对应的文件夹，即可把文件夹和其中的文件一并引入
//
//
// 遇到一个你不熟悉的类，要养成看头文件的习惯，还不会再去查文档
//
//
// 如果出现 EXC_BAD_ACCESS 错误，一般是因为试图访问一个已经被销毁的对象
//


#import <UIKit/UIKit.h>

@interface WHelloController : UIViewController

// 注意本行代码的左侧编辑器中有个圆点，鼠标经过它后，storyboard 中的对应的控件就会被突出显示
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnHello;


@property(strong, nonatomic) NSString *name;

- (IBAction)btnHelloPressed:(id)sender;

@end
