//
//  XYExtendBtn.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

/*!
 
 @abstract
 用于个税申请页面的，header头部描述，展开和合并功能的button
 
 默认不接受用户事件，当设置 addtarget:action:之后接收用户事件
 
 size = {60,22};
 
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYExtendBtn : UIControl

/** titleLabel */
@property(nonatomic , strong)     UILabel *titleLabel;
/** imageView */
@property(nonatomic , strong)     UIImageView *imageView;

/**
 设置合并还是收起来

 @param fold  YES:Fold  <->  NO:unFold
 */
- (void)setFold:(BOOL)fold;

@end

NS_ASSUME_NONNULL_END
