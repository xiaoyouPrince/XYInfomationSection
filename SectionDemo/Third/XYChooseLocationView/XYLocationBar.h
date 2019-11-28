//
//  XYLocationBar.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/28.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYLocationBarItemView : UIButton
/** 对应的model */
@property (nonatomic, strong)       XYLocation * model;
@end

@interface XYLocationBar : UIScrollView

@end

NS_ASSUME_NONNULL_END
