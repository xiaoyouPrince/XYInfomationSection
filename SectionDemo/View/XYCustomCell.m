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
        self.backgroundColor = UIColor.greenColor;
        
        
        UIView *s = [UIView new];
        s.backgroundColor = UIColor.yellowColor;
        [self addSubview:s];
        s.frame = CGRectMake(100, 10, 40, 40);
    
    }
    return self;
}

- (void)setModel:(XYInfomationItem *)model
{
    [super setModel:model];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = model.title;
    titleLabel.textColor = model.titleColor;
    [self addSubview:titleLabel];
    titleLabel.frame = CGRectMake(200, 0, 100, model.def_cellHeight);
    
//    self.titleLabel.text = @"Test@implementation XYCustomCell@implementation XYCustomCell@implementation XYCustomCell@implementation XYCustomCell@implementation XYCustomCell@implementation XYCustomCell";
}

@end
