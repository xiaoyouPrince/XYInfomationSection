//
//  XYTaxBaseCompanyInfoCell.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYTaxBaseCompanyInfoCell : UIView

/** 对应的公司model */
@property(nonatomic , strong)     XYTaxBaseCompany *model;

/** 是否被选中 */
@property(nonatomic , assign , readonly)     BOOL isChoosen;

/*!
 @abstract
 设置被选中，返回对应的 model
 */
- (XYTaxBaseCompany *)setSelected;

@end

NS_ASSUME_NONNULL_END
