//
//  XYDatePickerView.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/21.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYDatePickerView : UIView

@property (nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime, ignored UIDatePickerModeCountDownTimer

@property (nonatomic, strong) NSDate *date;        // default is current date when picker created. Ignored in countdown timer mode. for that mode, picker starts at 0:00
@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

@property (nonatomic) NSInteger      minuteInterval;    // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
@property (nonatomic, copy)         NSString * title;   // title

/// 快速创建实例 && show
+ (instancetype)datePicker;
- (void)show;

/// 快速创建 datePicker 并展示
/// @param config 要展示 datePicker 的基本设置 @n 此处必须要设置picker数据源
/// @param result 选择结果回调,返回的是NSDate *
+ (instancetype)showDatePickerWithConfig:(void(^)(XYDatePickerView *datePicker))config
                                  result:(void(^)(NSDate *choosenDate))result;

@end

NS_ASSUME_NONNULL_END
