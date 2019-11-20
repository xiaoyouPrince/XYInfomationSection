//
//  DataTool.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, copy)   NSString *nationCode;
@property (nonatomic, copy)   NSString *conAddr;
@property (nonatomic, copy)   NSString *custName;
@property (nonatomic, copy)   NSString *cerType;
@property (nonatomic, copy)   NSString *homePostalcode;
@property (nonatomic, assign) NSInteger record;
@property (nonatomic, copy)   NSString *sex;
@property (nonatomic, copy)   NSString *conTel;     ///< 联系电话
@property (nonatomic, copy)   NSString *conType;    ///< 联系方式
@property (nonatomic, copy)   NSString *conTypeCode; ///< 联系方式码
@property (nonatomic, copy)   NSString *birthDate;
@property (nonatomic, copy)   NSString *householdAddr;
@property (nonatomic, copy)   NSString *marStatusCode;
@property (nonatomic, copy)   NSString *nation;
@property (nonatomic, copy)   NSString *poliLan;
@property (nonatomic, copy)   NSString *poliLanCode;
@property (nonatomic, copy)   NSString *uniqNo;
@property (nonatomic, copy)   NSString *empName;
@property (nonatomic, copy)   NSString *marStatus;
@property (nonatomic, copy)   NSString *idCardNo;
@property (nonatomic, copy)   NSString *highDegreeCode;
@property (nonatomic, copy)   NSString *cerTypeCode;
@property (nonatomic, copy)   NSString *ywName;
@property (nonatomic, copy)   NSString *userName;
@property (nonatomic, copy)   NSString *highDegree;
@end

/*!
 
 @abstract
 全局的数据工具类
 
 */

NS_ASSUME_NONNULL_BEGIN


@interface DataTool : NSObject

+ (UserModel *)userModel;

/// 根据要请求的数据key返回对应数据数组
+ (NSArray *)dataArrayForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

@implementation NSDate (extension)

- (NSString *_Nullable)stringWithFormat:(NSString *_Nullable)format{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    
    return [fmt stringFromDate:self];
}

@end

