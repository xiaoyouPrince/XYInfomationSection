//
//  XYTaxBaseSection.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxBaseSection.h"

@interface XYTaxBaseSection ()

/** iconView */
@property (nonatomic, weak)         UIImageView * iconView;
/** titleLabel */
@property (nonatomic, weak)         UILabel * titleLabel;

@end

@implementation XYTaxBaseSection

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupContent];
}


- (void)setupContent{
    
    // defalutbgColor
    self.backgroundColor = UIColor.whiteColor;
    
    // iconView
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"icon_tax_renzhi"];
    [self addSubview:icon];
    self.iconView = icon;
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(icon.image.size);
    }];
    
    // titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon);
        make.left.equalTo(icon.mas_right).offset(10);
    }];
    
}


+ (instancetype)groupWithTitle:(NSString *)title icon:(nullable NSString *)iconName
{    
    if (!iconName.length) {
        iconName = @"icon_tax_renzhi";
    }
    
    XYTaxBaseSection *section = [[self alloc] init];
    section.titleLabel.text = title;
    section.iconView.image = [UIImage imageNamed:iconName];
    
    return section;
}

@end
