//
//  XYTaxBaseBottomView.h
//  DemoPersonalTax
//
//  Created by 渠晓友 on 2018/12/20.
//  Copyright © 2018年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TaxApplyConfirmBlock)(void);

@interface XYTaxBaseBottomView : UIView

@property(nonatomic , copy)  TaxApplyConfirmBlock block;


+ (instancetype)bottomView;

@end

NS_ASSUME_NONNULL_END
