//
//  DataTool.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "DataTool.h"
#import "MySwitch.h"
#import "FMDB.h"

@implementation UserModel
MJCodingImplementation;
@end

@implementation XYTaxBaseCompany
MJCodingImplementation;
@end

@interface DataTool ()
@property(nonatomic , strong)     NSArray *citiesArray;
@end

@implementation DataTool

+ (UserModel *)userModel
{
    NSDictionary *user = @{
                           @"nationCode":@"1",
                           @"custName":@"戴姆勒大中华区投资有限公司",
                           @"cerType":@"身份证",
                           @"conAddr":@"北京市朝阳区酒仙桥街道南十里居15号院17楼",
                           @"conType":@"手机",
                           @"record":@0,
                           @"homePostalcode":@"100016",
                           @"sex":@"女性",
                           @"householdAddr":@"四川",
                           @"birthDate":@"1985-04-03",
                           @"conTel":@"18687096189",
                           @"marStatusCode":@"2",
                           @"nation":@"汉族",
                           @"poliLan":@"群众",
                           @"poliLanCode":@"1",
                           @"uniqNo":@"5863808",
                           @"empName":@"王佚江",
                           @"conTypeCode":@"3",
                           @"marStatus":@"已婚",
                           @"idCardNo":@"513127198504030225",
                           @"highDegreeCode":@"12",
                           @"cerTypeCode":@"1",
                           @"ywName":@"业务19部",
                           @"userName":@"张胜楠",
                           @"highDegree":@"硕士"
                           };
    
    UserModel *userModel = [UserModel mj_objectWithKeyValues:user];
    return userModel;
}

+ (NSArray *)dataArrayForKey:(NSString *)key
{
    /// 性别类型
    if ([key isEqualToString:@"memberSex"]) {
        return [self sexArray];
    }
    
    /// 用户证件类型[子女，配偶]
    if ([key isEqualToString:@"sfzjlx"] ||
        [key isEqualToString:@"nsrposfzjlx"] ||
        [key isEqualToString:@"czrsfzjlx"]
        ) {
        
        return [self cardTypeArray];
    }
    
    /// 用户关系类型
    if ([key isEqualToString:@"relationShip"] ||
        [key isEqualToString:@"ynsrgx"]) {
        return [self relationShipArray];
    }
    
    /// 选择国籍【子女国籍，o配偶国籍，受教育国家】
    if ([key isEqualToString:@"nsrpogj"] ||
        [key isEqualToString:@"gjhdqsz"] ||
        [key isEqualToString:@"jdgjhdqsz"]) {
        return [self counttiesArray];
    }
    
    /// 是否有配偶，是否独生子女
    if ([key isEqualToString:@"sfypo"] ||
        [key isEqualToString:@"sfgzkc"] ||  // 是否婚前贷款且婚后平均分配
        [key isEqualToString:@"dkrsfbr"]    // 是否本人贷款
        ) {
        return [self boolArray];
    }
    
    /// 教育部分
    /// 教育阶段
    if ([key isEqualToString:@"sjyjd"] ||
        [key isEqualToString:@"xljxjyjd"]
        ) {
        return [self jyjdArray];
    }
    
    /// 教育阶段
    if ([key isEqualToString:@"fpbl"]) {
        return [self fpblArray];
    }
    
    /// 继续教育类型
    if ([key isEqualToString:@"jxjyqk"]) {
        return [self jxjylxArray];
    }
    
    /// 职业继续教育类型的具体类型
    if ([key isEqualToString:@"fxljxjylx"]) {
        return [self zyjxjylxArray];
    }
    
    /// 职业继续教育类型的证书名称
    if ([key isEqualToString:@"zsmc"]) {
        return [self zsmcArray];
    }
    
    /// 房贷
    /// 房屋产权类型
    if ([key isEqualToString:@"fwzslx"]) {
        return [self fwzslxArray];
    }
    
    /// 房屋产权类型
    if ([key isEqualToString:@"fdlx"]) {
        return [self fdlxArray];
    }
    
    /// 租房相关
    /// 出租方类型
    if ([key isEqualToString:@"czflx"]) {
        return [self czflxArray];
    }
    
    
    /// 赡养老人
    /// 纳税人身份类型
    if ([key isEqualToString:@"nsrsf"]) {
        return [self nsrsfArray];
    }
    
    /// 纳税人身份类型
    if ([key isEqualToString:@"ftfs"]) {
        return [self ftfsArray];
    }
    
    
    return [self citiesArray];
}


/// 出租方类型
+ (NSArray *)czflxArray
{
    NSArray *array = @[
        @{
            @"title": @"个人",
            @"code": @"1"
        },
        @{
            @"title": @"企业",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 纳税人身份类型
+ (NSArray *)nsrsfArray
{
    NSArray *array = @[
        @{
            @"title": @"独生子女",
            @"code": @"1"
        },
        @{
            @"title": @"非独生子女",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 纳税人身份类型
+ (NSArray *)ftfsArray
{
    NSArray *array = @[
        @{
            @"title": @"平均分配",
            @"code": @"1"
        },
        @{
            @"title": @"协商分配",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 贷款类型
+ (NSArray *)fdlxArray
{
    NSArray *array = @[
        @{
            @"title": @"公积金贷款",
            @"code": @"1"
        },
        @{
            @"title": @"商业贷款",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 房屋产权证明类型
+ (NSArray *)fwzslxArray
{
    NSArray *array = @[
        @{
            @"title": @"房屋所有权证",
            @"code": @"1"
        },
        @{
            @"title": @"不动产权证",
            @"code": @"2"
        },
        @{
            @"title": @"房屋买卖合同",
            @"code": @"3"
        },
        @{
            @"title": @"房屋预售合同",
            @"code": @"4"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 返回继续教育类型数据
+ (NSArray *)jxjylxArray
{
    NSArray *array = @[
        @{
            @"title": @"学历学位继续教育",
            @"code": @"1"
        },
        @{
            @"title": @"职业资格继续教育",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 返回继续教育类型数据
+ (NSArray *)zyjxjylxArray
{
    NSArray *array = @[
        @{
            @"title": @"技能人员职业资格",
            @"code": @"1"
        },
        @{
            @"title": @"专业技术人员职业资格",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 返回职业继续教育类型-证书名称
+ (NSArray *)zsmcArray
{
    NSArray *array = @[
        @{
            @"title": @"电工证",
            @"code": @"1"
        },
        @{
            @"title": @"催乳师证",
            @"code": @"2"
        },
        @{
            @"title": @"厨师证",
            @"code": @"3"
        },
        @{
            @"title": @"挖掘机证",
            @"code": @"4"
        },
        @{
            @"title": @"消防工程师证",
            @"code": @"5"
        },
        @{
            @"title": @"建筑工程师证",
            @"code": @"6"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 返回是否类型的数据
+ (NSArray *)boolArray
{
    NSArray *array = @[
        @{
            @"title": @"是",
            @"code": @"1"
        },
        @{
            @"title": @"否",
            @"code": @"2"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

+ (NSArray *)counttiesArray{
    NSArray *array = @[
        @{
            @"title": @"中国",
            @"code": @"1"
        },
        @{
            @"title": @"美国",
            @"code": @"2"
        },
        @{
            @"title": @"日本",
            @"code": @"3"
        },
        @{
            @"title": @"韩国",
            @"code": @"4"
        },
        @{
            @"title": @"俄罗斯",
            @"code": @"5"
        },
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

+ (NSArray *)jyjdArray{
    NSArray *array = @[
        @{
            @"title": @"学前教育",
            @"code": @"1"
        },
        @{
            @"title": @"义务教育",
            @"code": @"2"
        },
        @{
            @"title": @"高等教育",
            @"code": @"3"
        },
        @{
            @"title": @"博硕教育",
            @"code": @"4"
        },
        @{
            @"title": @"PhD",
            @"code": @"5"
        },
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 分配比例
+ (NSArray *)fpblArray{
    NSArray *array = @[
        @{
            @"title": @"0%",
            @"code": @"1"
        },
        @{
            @"title": @"50%",
            @"code": @"2"
        },
        @{
            @"title": @"100%",
            @"code": @"3"
        }
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}


/// 用户证件类型
+ (NSArray *)cardTypeArray
{
    
    NSArray *array = @[
        @{
            @"title": @"身份证",
            @"code": @"1"
        },
        @{
            @"title": @"军官证",
            @"code": @"2"
        },
        @{
            @"title": @"护照",
            @"code": @"3"
        },
        @{
            @"title": @"海外侨胞证",
            @"code": @"4"
        },
        @{
            @"title": @"台湾同胞证",
            @"code": @"5"
        },
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 用户关系类型
+ (NSArray *)relationShipArray
{
    
    NSArray *array = @[
        @{
            @"title": @"父亲",
            @"code": @"1"
        },
        @{
            @"title": @"母亲",
            @"code": @"2"
        },
        @{
            @"title": @"夫/妻",
            @"code": @"3"
        },
        @{
            @"title": @"儿子",
            @"code": @"4"
        },
        @{
            @"title": @"女儿",
            @"code": @"5"
        },
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}


/// 返回用户性别类型
+ (NSArray *)sexArray
{
    
    NSArray *array = @[
        @{
            @"title": @"男",
            @"code": @"1"
        },
        @{
            @"title": @"女",
            @"code": @"2"
        },
        @{
            @"title": @"不明性别",
            @"code": @"3"
        },
        @{
            @"title": @"变性人",
            @"code": @"4"
        },
        @{
            @"title": @"死变态",
            @"code": @"5"
        },
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}

/// 返回城市列表
+ (NSArray *)citiesArray
{
    
    NSArray *array = @[
        
        @{
            @"title": @"北京",
            @"code": @"1"
        },
        @{
            @"title": @"上海",
            @"code": @"2"
        },
        @{
            @"title": @"广州",
            @"code": @"3"
        },
        @{
            @"title": @"深圳",
            @"code": @"4"
        },
        @{
            @"title": @"定州",
            @"code": @"5"
        },
    ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        XYPickerViewItem *item = [XYPickerViewItem modelWithDict:dict];
        [arrayM addObject:item];
    }
    return arrayM;
}


+ (NSArray *)dataArrayForPersonTaxEntrance
{
    // 一共六种个税报销减免
    
    NSArray *array = @[
        @{
            @"image": @"icon_znjy",
            @"title": @"子女教育",
            @"titleKey": @"XYChildEducationNewController",
            @"value": @"",
            @"taxType": @"1",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_jxjy",
            @"title": @"继续教育",
            @"titleKey": @"XYMoreEducationNewController",
            @"value": @"",
            @"taxType": @"2",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_zfdkxx",
            @"title": @"住房贷款利息",
            @"titleKey": @"XYHouseLoansController",
            @"value": @"",
            @"taxType": @"3",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_zfzj",
            @"title": @"住房租金",
            @"titleKey": @"XYHouseRentNewController",
            @"value": @"",
            @"taxType": @"4",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_dbyl",
            @"title": @"大病医疗",
            @"titleKey": @"XYDabingyiliaoController",
            @"value": @"",
            @"taxType": @"5",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_sylr",
            @"title": @"赡养老人",
            @"titleKey": @"XYAlimonyPayController",
            @"value": @"",
            @"taxType": @"6",
            @"valueCode": @""
        }
    ];
    
    return array;
}

+ (NSArray *)dataArrayForPersonTaxCompanies
{
    // 历史供职信息有可能是多个或者0个
    NSDictionary *dict1 = @{
                           @"nsrsbh" : @"15151515151212",
                           @"qymc" : @"百度网络科技有限公司",
                           @"rzrq" : @"20181010"
                           };
    NSDictionary *dict2 = @{
                            @"nsrsbh" : @"1234567890",
                            @"qymc" : @"灵虎科技有限公司",
                            @"rzrq" : @"20181010"
                            };
    NSDictionary *dict3 = @{
                           @"nsrsbh" : @"15151515151212",
                           @"qymc" : @"北京外企科技有限公司",
                           @"lzrq" : @"20181010"
                           };
    NSDictionary *dict4 = @{
                            @"nsrsbh" : @"1234567890",
                            @"qymc" : @"阿里巴巴有限公司",
                            @"rzrq" : @"20181010"
                            };
    
    NSArray *array = @[dict1, dict2, dict3, dict4];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (int i = 0; i < arc4random()%4; i++) {
        XYTaxBaseCompany *company = [XYTaxBaseCompany mj_objectWithKeyValues:array[i]];
        [arrayM addObject:company];
    }
    
    return arrayM;
}

+ (NSArray *)cityArrayForPid:(NSString *)pid
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityArray" ofType:@"sqlite"];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_allCities WHERE pid = (?)",pid];
    
        while (rs.next) {
            long cid = [rs longForColumn:@"id"];
            long pid = [rs longForColumn:@"pid"];
            NSString * name = [rs stringForColumn:@"name"];
            NSMutableDictionary *dict = @{}.mutableCopy;
            
            [dict setValue:@(cid) forKey:@"id"];
            [dict setValue:@(pid) forKey:@"pid"];
            [dict setValue:name forKey:@"name"];
            [arrayM addObject:dict];
        }
    }];
    
    return arrayM;
}


+ (NSArray *)AliPayData{
    
    NSArray *section1 = @[
        @{
            @"imageName": @"ali_1",
            @"title": @"会员",
            @"titleKey": @"CommonViewController",
            @"value": @"600积分待领取",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50
        },
        @{
            @"imageName": @"ali_2",
            @"title": @"商家服务",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50
        }
    ];
    NSArray *section2 = @[
        @{
            @"imageName": @"ali_3",
            @"title": @"转账",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_4",
            @"title": @"所有资产",
            @"titleKey": @"CommonViewController",
            @"value": @"账户保障免费升级",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.greenColor
        },
        @{
            @"imageName": @"ali_5",
            @"title": @"余额",
            @"titleKey": @"CommonViewController",
            @"value": @"0.00",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_6",
            @"title": @"余额宝",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_7",
            @"title": @"花呗",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_8",
            @"title": @"余利宝",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_9",
            @"title": @"银行卡",
            @"titleKey": @"CommonViewController",
            @"value": @"穷逼就银行卡多",
            @"type": @1,
            @"valueCode": @""
        }
    ];
    NSArray *section3 = @[
        @{
            @"imageName": @"ali_10",
            @"title": @"芝麻信用",
            @"titleKey": @"CommonViewController",
            @"value": @"优秀",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.redColor
        },
        @{
            @"imageName": @"ali_11",
            @"title": @"蚂蚁保",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_12",
            @"title": @"相互保",
            @"titleKey": @"CommonViewController",
            @"value": @"你的助人月报已公布",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_13",
            @"title": @"网商贷",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_14",
            @"title": @"网商银行",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        }
    ];
    NSArray *section4 = @[
        @{
            @"imageName": @"ali_15",
            @"title": @"小程序",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_16",
            @"title": @"爱心捐赠",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"ali_17",
            @"title": @"客户中心",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        }
    ];
    
    NSArray *array = @[section1,section2,section3,section4];
    return array;
}


+ (NSArray *)AliPaySettingData{
    
    NSArray *section1 = @[
        @{
            @"imageName": @"",
            @"title": @"账户和安全",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50
        },
        @{
            @"imageName": @"",
            @"title": @"支付设置",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50
        }
    ];
    NSArray *section2 = @[
        @{
            @"imageName": @"",
            @"title": @"新消息通知",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"功能管理",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.greenColor
        },
        @{
            @"imageName": @"",
            @"title": @"隐私",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"通用",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        }
    ];
    NSArray *section3 = @[
        @{
            @"imageName": @"",
            @"title": @"帮助和反馈",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.redColor
        },
        @{
            @"imageName": @"",
            @"title": @"关于",
            @"titleKey": @"CommonViewController",
            @"value": @"Version 1.0.0",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.lightGrayColor
        }
    ];
    NSArray *section4 = @[
        @{
            @"imageName": @"",
            @"title": @"切换登录账户",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        }
    ];
    NSArray *section5 = @[
        @{
            @"imageName": @"",
            @"title": @"退出登录",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        }
    ];
    
    NSArray *array = @[section1,section2,section3,section4,section5];
    return array;
}

+ (NSArray *)WechatPrivateData{
    
    MySwitch *swith1 = [MySwitch new];
    swith1.settingKey = @"添加我为朋友时需要验证";
    swith1.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith1.settingKey];
    
    NSArray *section1 = @[
        @{
            @"imageName": @"",
            @"title": swith1.settingKey,
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": swith1
        }
    ];
    
    MySwitch *swith2 = [MySwitch new];
    swith2.settingKey = @"向我推荐通讯录朋友";
    swith2.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith2.settingKey];
    NSArray *section2 = @[
        @{
            @"imageName": @"",
            @"title": @"添加我的方式",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": swith2.settingKey,
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.greenColor,
            @"accessoryView": swith2
        },
        @{
            @"title": @"开启后，为你推荐已经开通微信的手机联系人",
            @"type": @4,
//            @"customCellClass": @"XYInfomationTipCell",
            @"backgroundColor": HEXCOLOR(0xf6f6f6),
            @"hideSeparateLine": @1
        }
    ];
    NSArray *section3 = @[
        @{
            @"imageName": @"",
            @"title": @"通讯录黑名单",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"valueColor": UIColor.redColor
        }
    ];
    
    
    MySwitch *swith3 = [MySwitch new];
    swith3.settingKey = @"允许陌生人查看十条朋友圈";
    swith3.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith3.settingKey];
    NSArray *section4 = @[
        @{
            @"title": @"朋友圈和视频动态",
            @"type": @4,
//            @"customCellClass": @"WechatTipCell",
            @"backgroundColor": HEXCOLOR(0xf6f6f6),
            @"hideSeparateLine": @1
        },
        @{
            @"imageName": @"",
            @"title": @"不让他(她)看",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"不看他",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"允许朋友查看朋友圈的范围",
            @"titleKey": @"CommonViewController",
            @"value": @"最近一个月",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @"",
            @"valueColor": UIColor.lightGrayColor
        },
        @{
            @"imageName": @"",
            @"title": swith3.settingKey,
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"WechatTipCell",
            @"cellHeight": @50,
            @"valueCode": @"",
            @"accessoryView": swith3
        }
    ];
    
    MySwitch *swith4 = [MySwitch new];
    swith4.settingKey = @"朋友圈更新提醒";
    swith4.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith4.settingKey];
    NSArray *section5 = @[
        @{
            @"imageName": @"",
            @"title": swith4.settingKey,
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @"",
            @"accessoryView": swith4
        },
        @{
            @"title": @"关闭后，有朋友发表朋友圈时，界面下方的“发现”切换按钮上不再出现红点提示。",
            @"type": @4,
//            @"customCellClass": @"WechatTipCell",
            @"backgroundColor": HEXCOLOR(0xf6f6f6),
            @"hideSeparateLine": @1
        }
    ];
    NSArray *section6 = @[
        @{
            @"imageName": @"",
            @"title": @"授权管理",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        }
    ];
    
    NSArray *array = @[section1,section2,section3,section4,section5,section6];
    return array;
}

+ (NSArray *)WeiBoData{
    
    UIImageView *atatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grade"]];
    atatar.frame = CGRectMake(0, 0, 30, 30);
    
    UIView *redDot = [UIView new];
    redDot.backgroundColor = UIColor.redColor;
    redDot.layer.cornerRadius = 5;
    redDot.layer.borderWidth = 2;
    redDot.layer.borderColor = [UIColor.whiteColor colorWithAlphaComponent:0.85].CGColor;
    [atatar addSubview:redDot];
    [redDot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(atatar).offset(-5);
        make.right.equalTo(atatar).offset(5);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    
    NSArray *section1 = @[
        @{
            @"imageName": @"",
            @"title": @"账号管理",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
            @"accessoryView": atatar
        },
        @{
            @"imageName": @"",
            @"title": @"账号与安全",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"valueCode": @"",
            @"cellHeight": @50,
        }
    ];
    
    NSArray *section2 = @[
        @{
            @"imageName": @"",
            @"title": @"青少年模式",
            @"titleKey": @"CommonViewController",
            @"value": @"未开启",
            @"type": @1,
            @"valueCode": @""
        }
    ];
    NSArray *section3 = @[
        @{
            @"imageName": @"",
            @"title": @"会员专属设置",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"XYCustomCell",
            @"valueCode": @"",
            @"valueColor": UIColor.redColor
        }
    ];
    
    NSArray *section4 = @[
        @{
            @"title": @"推送通知设置",
            @"type": @1,
            @"customCellClass": @"WechatTipCell",
            @"value": @"",
            @"hideSeparateLine": @0
        },
        @{
            @"imageName": @"",
            @"title": @"屏蔽设置",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"隐私设置",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"通用设置",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @"",
            @"valueColor": UIColor.lightGrayColor
        }
    ];
    
    MySwitch *swith4 = [MySwitch new];
    swith4.settingKey = @"护眼模式";
    swith4.on = [[NSUserDefaults standardUserDefaults] boolForKey:swith4.settingKey];
    NSArray *section5 = @[
        @{
            @"imageName": @"",
            @"title": @"清理缓存",
            @"titleKey": @"CommonViewController",
            @"value": @"181.1MB",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @"",
        },
        @{
            @"imageName": @"",
            @"title": swith4.settingKey,
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @"",
            @"accessoryView": swith4
        }
    ];
    NSArray *section6 = @[
        @{
            @"imageName": @"",
            @"title": @"客服中心",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        },
        @{
            @"imageName": @"",
            @"title": @"关于微博",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        }
    ];
    
    NSArray *section7 = @[
        @{
            @"imageName": @"",
            @"title": @"退出当前账号",
            @"titleKey": @"CommonViewController",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"AlipaySettingCell",
            @"cellHeight": @50,
            @"valueCode": @""
        }
    ];
    
    NSArray *array = @[section1,section2,section3,section4,section5,section6,section7];
    return array;
}

+ (NSArray *)customData{
    NSArray *section1 = @[
        @{
            @"imageName": @"grade",
            @"title": @"更换头像",
            @"titleKey": @"",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoHeaderCell",
            @"cellHeight": @215,
            @"valueCode": @"",
        }
    ];
    
    UIImage *image = [UIImage imageNamed:@"rightArraw_gray2"];
    NSArray *section2 = @[
        @{
            @"imageName": @"",
            @"title": @"企业名称",
            @"titleKey": @"",
            @"value": @"蚂蚁金服有限公司",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @115,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"职位名称",
            @"titleKey": @"",
            @"value": @"财富规划师",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @115,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"员工名称",
            @"titleKey": @"",
            @"value": @"支付宝",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @115,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"员工邮箱名称",
            @"titleKey": @"",
            @"value": @"xiaoyouPrince@163.com",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @115,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"选择您的身份",
            @"titleKey": @"CommonViewController",
            @"value": @"HR",
            @"type": @3,
            @"customCellClass": @"SectionDemo.PersonInfoDutyCell",
            @"cellHeight": @170,
            @"valueCode": @""
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}

@end


#pragma mark -- 一些实用分类
