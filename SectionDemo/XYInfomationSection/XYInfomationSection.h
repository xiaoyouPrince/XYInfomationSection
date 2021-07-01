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

/** 是否开启性能优化， default is NO
    @Discussion开启性能优化后，不会创建被设置为 \b折叠 的cell，同样获取所有参数时候也会忽略被折叠的cell
    @note 具体场景如: 是否有配偶. 展开组仍需要监听内部证件类型、证件号码 并自动填充生日信息
 */
@property (nonatomic, assign, getter=isImprovePerformance)      BOOL improvePerformance;

/** 获取 section 中内部所有的参数 key-values
    @note 如果开启 improvePerformance = YES 则取值也忽略折叠项目
 */
@property(nonatomic , strong , readonly)     NSDictionary *contentKeyValues;

#pragma mark - 编辑模式、长按滑动

/*--------------------------------------------------------*/
/// @name 编辑模式，cell 是否支持长按排序相关接口
/*--------------------------------------------------------*/

/// 设置为编辑模式，支持长按排序， default is NO
@property (nonatomic, assign, getter=isEditMode)     BOOL editMode;

/** cell 长按选中之后可自定义设置cell 样式，入参为被选中 cel l截图
    @Discussion 自定义被长按选中的cell 样式，入参为当前被选中cell截图，返回值为 UIView  对象，如无需自定义就不用实现此 block
    @Discussion 返回值可以直接为修改过的原截图，也可以是自定义 view
 */
@property (nonatomic, copy)         UIView *(^customMovableCellwithSnap)(UIImageView *cellSnap);

// 某个 cell 是否支持被移动，在item 内设置

/** UI 移动操作完成回调
    @Discussion cell 移动完成会回调此 block， 可在此 Block 中确定更新完是否使用新数据。
    @Discussion 默认不实现此 block 就会使用新数据。如果请求网络，则刷新数据即可。
    @Discussion 示例代码:
    @code
     section.sectionCellHasMoved = ^(XYInfomationSection * _Nonnull section, NSArray * _Nonnull oldData) {
         /// 执行具体操作，确定是否可以移动成功,成功/失败需手动刷新数据
         if (success) {
            // 确定可以成功，无需刷新
         }else{ // 如确定移动失败，就需要手动使用旧数据刷新 section
             [section refreshSectionWithDataArray:oldData];
         }
     };
    @endcode
 */
@property (nonatomic, copy)        void (^sectionCellHasMoved)(XYInfomationSection *section, NSArray *oldData);

/// 直接移动 内部cell
/// @param fromIndex fromIndex
/// @param toIndex toIndex
- (void)moveCellFrom:(NSInteger)fromIndex to:(NSInteger)toIndex;
- (void)moveCellFrom:(NSInteger)fromIndex to:(NSInteger)toIndex completed:(nullable dispatch_block_t)completed;


@end

NS_ASSUME_NONNULL_END
