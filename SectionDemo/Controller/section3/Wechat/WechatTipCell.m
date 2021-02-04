//
//  WechatTipCell.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "WechatTipCell.h"

@implementation WechatTipCell
{
    UILabel *_titleLabel;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = UIColor.lightGrayColor;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.numberOfLines = 3;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).equalTo(@15);
            make.right.equalTo(self).equalTo(@-15);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(XYInfomationItem *)model{
    [super setModel:model];
    
    self.backgroundColor = HEXCOLOR(0xf6f6f6);
    _titleLabel.text = model.title;
    [_titleLabel sizeToFit];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect bounds = [model.title boundingRectWithSize:CGSizeMake(ScreenW - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]} context:nil];
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bounds.size.height + 10);
    }];
}

@end
