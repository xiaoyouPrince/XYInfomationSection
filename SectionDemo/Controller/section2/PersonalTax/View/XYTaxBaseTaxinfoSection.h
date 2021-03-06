//
//  XYTaxBaseTaxinfoSection.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/24.
//  Copyright © 2019 渠晓友. All rights reserved.
//
//  个税信息中一组一组的数据，header + 数据

#import <UIKit/UIKit.h>
#import "XYInfomationSection.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^XYTaxBaseTaxinfoSectionHandler)(XYInfomationCell *cell);

@interface XYTaxBaseTaxinfoSection : UIView

/// 默认不可以额外添加的组
+ (instancetype)taxSectionWithImage:(NSString *)imageName
                              title:(NSString *)title
                          infoItems:(NSArray <XYInfomationItem *>*)dataArray
                            handler:(nullable XYTaxBaseTaxinfoSectionHandler)handler;

/// 可以额外添加的组
+ (instancetype)taxSectionCanAddWithImage:(NSString *)imageName
                                    title:(NSString *)title
                                infoItems:(NSArray <XYInfomationItem *>*)dataArray
                                  handler:(nullable XYTaxBaseTaxinfoSectionHandler)handler;

/// 返回内部数据<当是可添加类型时 returns nil
- (NSArray <XYInfomationCell *>*)cellsArray;

@end

NS_ASSUME_NONNULL_END
