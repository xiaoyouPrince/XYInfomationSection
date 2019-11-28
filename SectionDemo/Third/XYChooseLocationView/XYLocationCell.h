//
//  XYLocationCell.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/29.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYLocationCell : UITableViewCell

/** 数据模型 */
@property (nonatomic, strong)       XYLocation * model;

@end

NS_ASSUME_NONNULL_END
