//
//  ZWLeftTableViewCell.m
//  ZWTwoTableLinkage
//
//  Created by 郑亚伟 on 2017/3/10.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWLeftTableViewCell.h"

@interface ZWLeftTableViewCell ()
@property (nonatomic, strong) UIView *redView;
@end
#define ZWRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@implementation ZWLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.textColor = ZWRGBAColor(130, 130, 130, 1.0);
        self.nameLabel.highlightedTextColor = [UIColor redColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 5, 45)];
        self.redView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.redView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //根据tableViewCell是否选中设置红色按钮
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.nameLabel.highlighted = selected;
    self.redView.hidden = !selected;
}

@end
