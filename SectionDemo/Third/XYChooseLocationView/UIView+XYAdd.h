//
//  UIView+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYAdd)

#pragma mark --- frame相关
@property CGFloat xy_x;
@property CGFloat xy_y;
@property CGFloat xy_width;
@property CGFloat xy_height;
@property CGFloat xy_top;
@property CGFloat xy_left;
@property CGFloat xy_right;
@property CGFloat xy_bottom;
@property CGFloat xy_centerX;
@property CGFloat xy_centerY;
@property CGPoint xy_origin;
@property CGSize  xy_size;
#pragma mark --- frame相关


/**
 通过xib快速加载view
 */
+ (instancetype)xy_viewFromXib;

/**
 添加渐变色
 @note 在调用之前，可先调用[view setNeedsLayout]; 和 \c [view layoutIfNeeded];确保渐变色正确添加
 */
- (void)xy_setGradientColors:(NSArray <UIColor *>*)colors;

@end
