//
//  XYInfomationTipCell.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/5/17.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYInfomationTipCell.h"
#import "Masonry.h"

@implementation XYInfomationTipCell
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
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setModel:(XYInfomationItem *)model{
    [super setModel:model];
    
    self.backgroundColor = UIColor.clearColor;
    _titleLabel.text = model.title;
    _titleLabel.font = model.titleFont;
    _titleLabel.textColor = model.titleColor;
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(model.tipEdgeInsets);
    }];
}
@end
