//
//  XYInfomationBaseViewController.h
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/6/19.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

//  一个基础的VC样例，可以以此来创建

#import <UIKit/UIKit.h>
#import "XYInfomationSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYInfomationBaseViewController : UIViewController

/// @note 子类中请勿重写以下属性和自动合成相关方法
/// @note 相关方法赋值参数View，在入参之前需要自行设置好高度约束


@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIView  *headerView;
@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic, strong) UIView  *footerView;

- (void)setHeaderView:(UIView * _Nonnull)headerView;
- (void)setContentView:(UIView * _Nonnull)contentView;
- (void)setFooterView:(UIView * _Nonnull)footerView;

- (void)setHeaderView:(UIView * _Nonnull)headerView edgeInsets:(UIEdgeInsets)edgeInsets;
- (void)setContentView:(UIView * _Nonnull)contentView edgeInsets:(UIEdgeInsets)edgeInsets;
- (void)setFooterView:(UIView * _Nonnull)footerView edgeInsets:(UIEdgeInsets)edgeInsets;

@end

NS_ASSUME_NONNULL_END
