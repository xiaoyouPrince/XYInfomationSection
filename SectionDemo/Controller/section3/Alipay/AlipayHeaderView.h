//
//  AlipayHeaderView.h
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/3.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlipayHeaderView : UIView
+ (instancetype)viewWithHeaderImage:(NSString *)imageName
                               name:(NSString *)name
                              phone:(NSString *)phone;
@end

NS_ASSUME_NONNULL_END
