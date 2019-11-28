//
//  XYChooseLocationView.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/26.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

//  一个多级联动选择地区的 View

#import <UIKit/UIKit.h>
#import "XYLocation.h"
#import "XYLocationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseLocationView : UIView

/**
 
 1. 设置可选择等级  省市区，省市 默认无限
 2. 必须设置第一级别的id
 3. 自定义 title
 
 */


/** 想要设置的 title */
@property (nonatomic, copy)         NSString * title;


/** 第一组基础数据 dataArray */
@property (nonatomic, strong)       NSArray <XYLocation *>* baseDataArray;

/** 选择完毕，回调 */
@property (nonatomic, copy)         void(^finishChooseBlock)(NSArray *locations);


@end

NS_ASSUME_NONNULL_END
