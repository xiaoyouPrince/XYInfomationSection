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

/// 通过数据直接快速创建contentView
/// @param dataArray 数据数组
/// @param itemConfig 对于每个item 进行额外设置的回调
/// @param sectionConfig 对于每个section 进行额外设置的回调
/// @param sectionDistance 每个 section 之间的间距
/// @param edgeInsets 内容整体的内边距
/// @param cellClickBlock cell 被点击的回调
- (void)setContentWithData:(NSArray *)dataArray
                itemConfig:(nullable void(^)(XYInfomationItem *item))itemConfig
             sectionConfig:(nullable void(^)(XYInfomationSection *section))sectionConfig
           sectionDistance:(CGFloat)sectionDistance
         contentEdgeInsets:(UIEdgeInsets)edgeInsets
            cellClickBlock:(SectionCellClickBlock)cellClickBlock;

@end

NS_ASSUME_NONNULL_END
