//
//  XYLocationBar.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/28.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import "XYLocationBar.h"
#import "UIView+XYAdd.h"

@implementation XYLocationBarItemView

- (void)setModel:(XYLocation *)model
{
    _model = model;
    [self setTitle:model.name forState:UIControlStateNormal];
    
    [self sizeToFit];
}

@end

@implementation XYLocationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 遍历自己内容，根据编号，重新布局
    for (UIButton *subView in self.subviews) {
        [subView sizeToFit];
        subView.selected = NO;
        
        if (subView.tag == 0) {
            subView.xy_centerY = self.xy_height/2;
            subView.xy_left = 15;
        }else
        {
            UIView *formarView = self.subviews[subView.tag-1];
            subView.xy_centerY = self.xy_height/2;
            subView.xy_left = formarView.xy_right + 15;
        }
    }
    
    self.contentSize = CGSizeMake(self.subviews.lastObject.xy_right + 15, 0);
    if (self.xy_width > self.contentSize.width) {
        self.contentOffset = CGPointZero;
    }
}

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    
    [subview sizeToFit];
    if (self.xy_width < self.contentSize.width) {
        self.contentOffset = CGPointMake(self.contentSize.width + subview.xy_width + 15 - self.xy_width, 0);
    }
}

@end
