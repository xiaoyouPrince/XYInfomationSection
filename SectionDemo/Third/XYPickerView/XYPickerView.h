//
//  XYPickerView.h
//  XYPickerViewDemo
//
//  Created by 渠晓友 on 2018/10/31.
//  Copyright © 2018年 渠晓友. All rights reserved.
//
// 
//  一个简单的单列选择器控件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYPickerViewItem : NSObject
/** title */
@property (nonatomic, copy)         NSString * title;
/** code */
@property (nonatomic, copy)         NSString * code;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)modelWithDict:(NSDictionary *)dict;
@end

typedef void(^DoneBtnClickBlcok)(XYPickerViewItem *selectedItem);
@interface XYPickerView : UIView

// 一些可以动态设置的可选项
@property(nonatomic , copy)     UIColor *toolBarBgColor;
@property(nonatomic , copy)     NSString *title;
@property(nonatomic , copy)     UIColor *titleColor;
@property(nonatomic , copy)     NSString *cancelTitle;
@property(nonatomic , copy)     UIColor *cancelTitleColor;
@property(nonatomic , copy)     NSString *doneTitle;
@property(nonatomic , copy)     UIColor *doneTitleColor;
@property(nonatomic , copy)     UIColor *pickerBgColor;

/// 数据源，展示 Picker 之前必须设置
@property(nonatomic , strong)     NSArray <XYPickerViewItem *>*dataArray;

/// 用户点击确定回调，返回选中结果
@property(nonatomic , copy)     DoneBtnClickBlcok doneBlock;

/// 默认选中的行
@property(nonatomic , assign)     NSUInteger defaultSelectedRow;

/// 快速创建实例 && show
+ (instancetype)picker;
- (void)showPicker;

/// 快速创建 Picker 并展示
/// @param config 要展示picker的基本设置 @n 此处必须要设置picker数据源
/// @param result 选择结果回调
+ (instancetype)showPickerWithConfig:(void(^)(XYPickerView *picker))config
                              result:(DoneBtnClickBlcok)result;

@end

NS_ASSUME_NONNULL_END
