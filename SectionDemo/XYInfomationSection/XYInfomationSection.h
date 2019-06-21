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

/** dataArray : 存放XYInfomationItem对象的数据源 */
@property(nonatomic , strong)     NSArray <XYInfomationItem *>*dataArray;

/** cell被点击的时候回调 @note 这里只有在cellType为choose时候会调用，如果是input类型那就直接调用键盘进行输入了 */
@property(nonatomic , copy)     SectionCellClickBlock cellClickBlock;

/** 使用数据源刷新 section UI */
- (void)refreshSectionWithDataArray:(NSArray *)dataArray;

/** 获取 section 中内部所有的参数 key-values */
@property(nonatomic , strong , readonly)     NSDictionary *contentKeyValues;

@end

NS_ASSUME_NONNULL_END
