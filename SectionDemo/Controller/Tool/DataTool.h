//
//  DataTool.h
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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

@interface XYTaxBaseCompany : NSObject
//nsrsbh": "15151515151212",
//"qymc": "企业名称",
//"lzrq": "20181010"
/** 纳税人识别号 */
@property(nonatomic , copy)     NSString *nsrsbh;
/** 企业名称 */
@property(nonatomic , copy)     NSString *qymc;
/** 入职日期 */
@property(nonatomic , copy)     NSString *rzrq;

@end

/*!
 
 @abstract
 全局的数据工具类
 
 */

@interface DataTool : NSObject

+ (UserModel *)userModel;

/// 根据要请求的数据key返回对应数据数组
+ (NSArray *)dataArrayForKey:(NSString *)key;

/// 返回个税入口页面列表数据
+ (NSArray *)dataArrayForPersonTaxEntrance;

/// 返回个税纳税人历史供职公司信息
+ (NSArray *)dataArrayForPersonTaxCompanies;


/// 通过对应的父级别ID返回子集别城市
/// @param pid 父级id
+ (NSArray *)cityArrayForPid:(NSString *)pid;

/// 返回支付宝页面数据
+ (NSArray *)AliPayData;
+ (NSArray *)AliPaySettingData;

/// 微信数据
+ (NSArray *)WechatPrivateData;

/// 微博数据
+ (NSArray *)WeiBoData;

/// 自定义数据
+ (NSArray *)customData;

@end

@implementation NSDate (extension)

- (NSString *_Nullable)stringWithFormat:(NSString *_Nullable)format{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    
    return [fmt stringFromDate:self];
}

@end

@interface UIColor (extension)
+ (UIColor *)colorWithHex:(NSString *)hex;
@end
@implementation UIColor (extension)

+ (UIColor *)colorWithHex:(NSString *)hex{
    NSString *r = [hex substringWithRange:NSMakeRange(0, 2)];
    NSString *g = [hex substringWithRange:NSMakeRange(2, 2)];
    NSString *b = [hex substringWithRange:NSMakeRange(4, 2)];
    
    float rf = 0;
    float gf = 0;
    float bf = 0;
    
    NSScanner *scanner = [NSScanner scannerWithString:r];
    [scanner scanFloat:&rf];
    
    scanner = [NSScanner scannerWithString:g];
    [scanner scanFloat:&gf];
    
    scanner = [NSScanner scannerWithString:b];
    [scanner scanFloat:&bf];
    
    return [UIColor colorWithRed:rf/255.0 green:gf/255.0 blue:bf/255.0 alpha:1.0];
}

@end

NS_ASSUME_NONNULL_END

