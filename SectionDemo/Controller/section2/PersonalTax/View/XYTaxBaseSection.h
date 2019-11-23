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

@end

NS_ASSUME_NONNULL_END
