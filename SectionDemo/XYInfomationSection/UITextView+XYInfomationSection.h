//
//  UITextView+XYInfomationSection.h
//  SectionDemo
//
//  Created by 渠晓友 on 2020/1/7.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (XYInfomationSection)

/**
 Set textView's placeholder text. Default is nil.
 */
@property(nullable, nonatomic,copy) IBInspectable NSString    *placeholder;

@end

NS_ASSUME_NONNULL_END
