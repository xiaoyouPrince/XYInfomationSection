//
//  XYInfoTextView.h
//  SectionDemo
//
//  Created by 渠晓友 on 2020/1/7.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYInfoTextView : UITextView
/**
 Set textView's placeholder text. Default is nil.
 */
@property(nullable, nonatomic,copy) IBInspectable NSString    *placeholder;
@property(nullable, nonatomic,copy) UIColor *placeholderColor;
@property(nullable, nonatomic,copy) UIFont *placeholderFont;

@end

NS_ASSUME_NONNULL_END
