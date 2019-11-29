//
//  XYTaxBaseSection.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxBaseSection.h"

@interface XYTaxBaseSection ()

/** title */
@property (nonatomic, copy)         NSString * title;

/** iconView */
@property (nonatomic, weak)         UIImageView * iconView;
/** titleLabel */
@property (nonatomic, weak)         UILabel * titleLabel;

/** deleteBtn */
@property (nonatomic, strong)       UIButton * deleteBtn;

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
    icon.image = [UIImage imageNamed:@"icon_tax_geshui"];
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
    
    // deleteBtn
    UIButton *deleteBtn = [UIButton new];
    [deleteBtn setImage:[UIImage imageNamed:@"visa_delete"] forState:UIControlStateNormal];
    deleteBtn.hidden = YES;
    self.deleteBtn = deleteBtn;
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-0);
    }];
    
}


+ (instancetype)groupWithTitle:(NSString *)title icon:(nullable NSString *)iconName
{    
    if (!iconName.length) {
        iconName = @"icon_tax_geshui";
    }
    
    XYTaxBaseSection *section = [[self alloc] init];
    section.title = title;
    section.titleLabel.text = title;
    section.iconView.image = [UIImage imageNamed:iconName];
    
    return section;
}

/// 使用第几组更新title
- (void)updateTitleWithIndex:(int)index
{
    // 第0组不变.后面的
    if (index > 0) {
        
        self.titleLabel.text = [self.title stringByAppendingFormat:@"(%d)",index+1];
        
        // 展示删除按钮
        self.deleteBtn.hidden = NO;
    }
}


- (void)deleteBtnClick:(UIButton *)sender{
    
    if (self.delteteBlock) {
        self.delteteBlock();
    }
}

@end
