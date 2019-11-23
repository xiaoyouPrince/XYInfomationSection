//
//  XYMoreEducationNewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYMoreEducationNewController.h"

@implementation XYMoreEducationNewController

static NSMutableArray *_allSections = nil;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _allSections = @[].mutableCopy;
    }
    return self;
}

- (void)getSectionFormView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:XYInfomationSection.class]) {
            [_allSections addObject:subView];
            continue;
        }else
        {
            [self getSectionFormView:subView];
        }
        
    }
}

- (void)ensureBtnClick
{
    NSLog(@"实现父类的点击确定按钮页面。。。。。。。。%@",self);
    
    // 校验参数 - 遍历所有XYInfomationSection
    
    [_allSections removeAllObjects];
    [self getSectionFormView:self.view];
    for (XYInfomationSection *section in _allSections) {
        NSLog(@"内容为 : %@", section.contentKeyValues);
    }
    
}

@end
