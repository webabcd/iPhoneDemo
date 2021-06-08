//
// 继承 UITableViewCell，实现一个自定义的 cell
//
// 注意：对应的 nib 参见 WCustomTableViewCell.xib
//

#import "WCustomTableViewCell.h"

@implementation WCustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
