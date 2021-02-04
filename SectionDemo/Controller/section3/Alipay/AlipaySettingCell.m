//
//  AlipaySettingCell.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "AlipaySettingCell.h"

@implementation AlipaySettingCell
{
    UILabel *_titleLabel;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(XYInfomationItem *)model{
    [super setModel:model];
    
    _titleLabel.text = model.title;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.cellHeight);
    }];
}

@end
