//
//  NSString+Tool.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/21.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Tool)


/// 校验是否为 yyyy-MM-dd 日期格式
- (BOOL)isDateFromat;

/// 校验是否为身份证
- (BOOL)isIDCard;
- (NSString *)birthdayFromIDCard;

@end

NS_ASSUME_NONNULL_END
