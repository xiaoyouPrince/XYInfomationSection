//
//  PersonalTaxBaseViewController.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/25.
//  Copyright © 2019 渠晓友. All rights reserved.
//

//  个税相关基础内容封装，因为六个税种之间页面有很多相同的地方，统一处理
//  页面布局: header + [各自内容，子页面单独设置] + footer
//  

#import "XYInfomationBaseViewController.h"
#import "XYTaxBaseTaxinfoSection.h"

NS_ASSUME_NONNULL_BEGIN

#define kDescDefaultHeight 285  // 顶部描述默认的高度

typedef NS_ENUM(NSUInteger, TaxType) {
    TaxTypeChildEducation = 1,          // 子女教育 1
    TaxTypeMoreEducation,               // 继续教育 2
    TaxTypeHouseLoans,                  // 住房贷款 3
    TaxTypeHouseRent,                   // 住房租金 4
    TaxTypeDabingyiliao,                // 大病医疗 5
    TaxTypeAlimonyPay,                  // 赡养老人 6
    TaxTypeOther                        // 其他 7
};

@interface PersonalTaxBaseViewController : XYInfomationBaseViewController

/**
 个税类型
 */
@property(nonatomic , assign)   TaxType taxType;

/**
 提交数据，最终数据
 /// @note 此方法，仅仅在子类页面提交时使用
 */
@property(nonatomic , assign, readonly, getter=allSections)   NSMutableArray *allSections;


/// 由子类实现点击确定按钮，提交操作
- (void)ensureBtnClick;

@end

NS_ASSUME_NONNULL_END
