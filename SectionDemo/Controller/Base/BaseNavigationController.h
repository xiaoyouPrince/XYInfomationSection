//
//  BaseNavigationController.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/26.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationController : UINavigationController

/**
 设置导航栏透明，默认在pop当前页面或者push新页面会恢复默认
 */
- (void)setNavBarTransparent;
/**
 设置导航栏透明

 @param autoReset 是否在pop当前页面或者push新页面会恢复默认
 */
- (void)setNavBarTransparentWithAutoReset:(BOOL)autoReset;

@end

NS_ASSUME_NONNULL_END
