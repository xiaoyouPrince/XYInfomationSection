//
//  UITextView+XYInfomationSection.m
//  SectionDemo
//
//  Created by 渠晓友 on 2020/1/7.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "UITextView+XYInfomationSection.h"
#import <objc/runtime.h>

//@interface UITextView ()
//- (void)refreshPlaceholder;
//- (UILabel *)placeholderLabel;
//@end


const void *placeholderLabelKey = &placeholderLabelKey;

@implementation UITextView (XYInfomationSection)

#pragma mark - private

+ (void)xy_info_swizzlMethodwithOriginalSel:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
            class_addMethod(class,
                originalSelector,
                method_getImplementation(swizzledMethod),
                method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

+ (void)load
{
    // 修改几个系统方法
    // init awakeFromNib dealloc setText setFont layoutSubView delegate
    [self xy_info_swizzlMethodwithOriginalSel:@selector(init)
                             swizzledSelector:@selector(xy_info_init)];
    
    [self xy_info_swizzlMethodwithOriginalSel:@selector(awakeFromNib)
                             swizzledSelector:@selector(xy_info_awakeFromNib)];
    
    [self xy_info_swizzlMethodwithOriginalSel:@selector(setText:)
                             swizzledSelector:@selector(xy_info_setText:)];
    
    [self xy_info_swizzlMethodwithOriginalSel:@selector(setFont:)
                             swizzledSelector:@selector(xy_info_setFont:)];
    
    [self xy_info_swizzlMethodwithOriginalSel:@selector(layoutSubviews)
                             swizzledSelector:@selector(xy_info_layoutSubviews)];
    
    [self xy_info_swizzlMethodwithOriginalSel:@selector(delegate)
                             swizzledSelector:@selector(xy_info_delegate)];
    
}

- (instancetype)xy_info_init
{
    UITextView *tv = [self xy_info_init];
    [tv initialize];
    return tv;
}

- (void)xy_info_awakeFromNib
{
    [self xy_info_awakeFromNib];
    [self initialize];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)xy_info_dealloc
//{
//    [self xy_info_dealloc];
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)xy_info_setText:(NSString *)text
{
    [self xy_info_setText:text];
    [self refreshPlaceholder];
}

-(void)xy_info_setFont:(UIFont *)font
{
    [self xy_info_setFont:font];
    UILabel *placeHolderLabel = [self placeholderLabel];
    placeHolderLabel.font = self.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)xy_info_layoutSubviews
{
    [self xy_info_layoutSubviews];

    UILabel *placeHolderLabel = [self placeholderLabel];
    [placeHolderLabel sizeToFit];
    placeHolderLabel.frame = CGRectMake(8, 8, CGRectGetWidth(self.frame)-16, CGRectGetHeight(placeHolderLabel.frame));
}

//When any text changes on textField, the delegate getter is called. At this time we refresh the textView's placeholder
-(id<UITextViewDelegate>)xy_info_delegate
{
    [self refreshPlaceholder];
    return [self xy_info_delegate];
}

#pragma mark - set/get

- (UILabel *)placeholderLabel
{
    return objc_getAssociatedObject(self, placeholderLabelKey);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    // 添加一个默认的placeholderLabel
    UILabel *placeholderLabel = [self placeholderLabel];
    if (!placeholderLabel) {
        placeholderLabel = [UILabel new];
        objc_setAssociatedObject(self, placeholderLabelKey, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    placeholderLabel.text = placeholder;
}

- (NSString *)placeholder
{
    UILabel *placeholderLabel = [self placeholderLabel];
    return placeholderLabel.text;
}

#pragma mark - refreshPlaceholder

- (void)refreshPlaceholder
{
    UILabel *placeHolderLabel = [self placeholderLabel];
    if([[self text] length])
    {
        [placeHolderLabel setAlpha:0];
    }
    else
    {
        [placeHolderLabel setAlpha:1];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - private

@end
