//
//  XYInfomationSection.h
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/5/23.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYInfomationCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SectionCellClickBlock)(NSInteger index,XYInfomationCell *cell);

@interface XYInfomationSection : UIView

/// 分割线内边距
/// @note 需要在设置数据源之前设置
@property (nonatomic) UIEdgeInsets separatorInset;
/// 分割线颜色
/// @note 需要在设置数据源之前设置
@property (nonatomic) UIColor* separatorColor;
/// 内部 cell 间距高度
/// @Discussion 此属性设置后默认self.bgColor=.clear 且 cell.bgColor=.white
/// @note 需要在设置数据源之前设置
@property (nonatomic) CGFloat separatorHeight;

/** dataArray : 存放XYInfomationItem对象的数据源 */
@property(nonatomic , strong)     NSArray <XYInfomationItem *>*dataArray;

/** cell被点击的时候回调 @note 这里只有在cellType为choose时候会调用，如果是input类型那就直接调用键盘进行输入了 */
@property(nonatomic , copy)     SectionCellClickBlock cellClickBlock;

/** 使用数据源刷新 section UI */
- (void)refreshSectionWithDataArray:(NSArray <XYInfomationItem *> *)dataArray;

+ (instancetype)sectionWithData:(NSArray <XYInfomationItem *> *)dataArray;

/** 快速创建最原始没有圆角的section对象 */
+ (instancetype)sectionForOriginal;
- (instancetype)initForOriginal;

/** 折叠数据 */
- (void)foldCellWithIndexs:(NSArray <NSNumber *>*)indexs;  // 要折叠的项目
- (void)foldCellWithoutIndexs:(NSArray <NSNumber *>*)indexs;  // 要避免折叠的项目
/** 展开数据 */
- (void)unfoldAllCells;

/** 获取 section 中内部所有的参数 key-values */
@property(nonatomic , strong , readonly)     NSDictionary *contentKeyValues;

@end

NS_ASSUME_NONNULL_END
