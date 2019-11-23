//
//  XYTaxBaseCompanySection.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYTaxBaseCompanySection : UIView

/** 用户所在职过的公司信息 */
@property(nonatomic , strong)     NSArray <XYTaxBaseCompany *>*companies;

/** 返回选中的公司信息，默认是第一个 */
@property(nonatomic , strong)     XYTaxBaseCompany *selectedCompany;

@end

NS_ASSUME_NONNULL_END
