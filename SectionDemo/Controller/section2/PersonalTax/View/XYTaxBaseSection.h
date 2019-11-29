//
//  XYTaxBaseSection.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//
//  设置组的一个headerView

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYTaxBaseSection : UIView

+ (instancetype)groupWithTitle:(NSString *)title icon:(nullable NSString *)iconName;

/// 使用第几组更新title
- (void)updateTitleWithIndex:(int)index;

/** 取消按钮点击回调 */
@property (nonatomic, copy)  void(^delteteBlock)(void);

@end

NS_ASSUME_NONNULL_END
