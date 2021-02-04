//
//  XYCustomCell.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/1/29.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYCustomCell.h"

@interface XYCustomCell()
/** titleLabel */
@property (nonatomic, weak)         UILabel * titleLabel;

@end
@implementation XYCustomCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 这里创建 cell 的 subView
    
    }
    return self;
}

- (void)setModel:(XYInfomationItem *)model
{
    [super setModel:model];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = model.title;
    titleLabel.textColor = UIColor.blackColor;
    [self addSubview:titleLabel];
    titleLabel.frame = CGRectMake(15, 0, 150, model.def_cellHeight);
    
    UIImageView *atatar = [[UIImageView alloc] init];
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 0; i < 14; i++) {
        UIImage *image = [UIImage imageNamed:[@"avatar_vip_golden_anim_" stringByAppendingFormat:@"%d",i]];
        [images addObject:image];
    }
    atatar.animationImages = images;
    atatar.animationDuration = 2;
    atatar.animationRepeatCount = 0;
    [atatar startAnimating];
    [self addSubview:atatar];
    atatar.frame = CGRectMake(115 + 10, (model.def_cellHeight - 30)/2.0, 30, 30);
    
    UIImageView *right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightArraw_gray2"]];
    [self addSubview:right];
    right.frame = CGRectMake(ScreenW - 10 - 10, (model.def_cellHeight - 10)/2.0, 10, 10);
}

@end
