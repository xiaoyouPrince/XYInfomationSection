//
//  XYExtendBtn.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYExtendBtn.h"

#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

@implementation XYExtendBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    
    // self.边框 ，self.size = {60,22}
    ViewBorderRadius(self, 11, 1, HEXCOLOR(0x1371fe));
    self.userInteractionEnabled = NO;
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12];
    self.titleLabel.textColor = HEXCOLOR(0x1471fe);
    self.titleLabel.text = @"展开";
    [self addSubview:self.titleLabel];
    
    self.imageView = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"icon_extend_down"];
    self.imageView.image = image;
    [self addSubview:self.imageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).multipliedBy(0.75);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.size.mas_equalTo(image.size);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
}


/**
 设置合并还是收起来
 
 @param fold  YES:Fold  <->  NO:unFold
 */
- (void)setFold:(BOOL)fold{
    
    if (fold) { // 合并
        self.titleLabel.text = @"展开";
        self.imageView.transform = CGAffineTransformIdentity;
    }else
    {
        self.titleLabel.text = @"合并";
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
}


@end
