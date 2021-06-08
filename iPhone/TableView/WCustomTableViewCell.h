//
// 继承 UITableViewCell，实现一个自定义的 cell
//

#import <UIKit/UIKit.h>

@interface WCustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end
