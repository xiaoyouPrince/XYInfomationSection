//
//  XYLocationCell.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/29.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import "XYLocationCell.h"

@interface XYLocationCell ()

/** titleLabel */
@property (nonatomic, weak)         UILabel * titleLabel;
/** selectionMark */
@property (nonatomic, strong)       UIImageView * selectionMark;
@end

@implementation XYLocationCell

- (UIImageView *)selectionMark
{
    if (!_selectionMark) {
        _selectionMark = [[UIImageView alloc] init];
        _selectionMark.image = [[UIImage imageNamed:@"icon_mark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _selectionMark.tintColor = HEXCOLOR(0xd92427);
    }
    return _selectionMark;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = UIColor.blackColor;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(0);
            make.left.equalTo(self).offset(15);
        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.selected) {
        [self.contentView addSubview:self.selectionMark];
        self.titleLabel.textColor = HEXCOLOR(0xd92427);
        [self.selectionMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel).offset(0);
            make.left.equalTo(self.titleLabel.mas_right).offset(15);
        }];
    }else
    {
        self.titleLabel.textColor = HEXCOLOR(0x000000);
        if ([self.contentView.subviews containsObject:self.selectionMark]) {
            [self.selectionMark removeFromSuperview];
        }
    }
}

- (void)setModel:(XYLocation *)model
{
    _model = model;
    
    self.titleLabel.text = model.name;
}

@end
