//
//  DataTool.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "DataTool.h"

@implementation UserModel

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
    
    /// 用户证件类型
    if ([key isEqualToString:@"memberCardType"]) {
        return [self cardTypeArray];
    }
    
    /// 用户关系类型
    if ([key isEqualToString:@"relationShip"]) {
        return [self relationShipArray];
    }
    
    return [self citiesArray];
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
            @"valueCode": @""
        },
        @{
            @"image": @"icon_jxjy",
            @"title": @"继续教育",
            @"titleKey": @"XYMoreEducationNewController",
            @"value": @"",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_zfdkxx",
            @"title": @"住房贷款利息",
            @"titleKey": @"XYHouseLoansController",
            @"value": @"",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_zfzj",
            @"title": @"住房租金",
            @"titleKey": @"XYHouseRentNewController",
            @"value": @"",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_dbyl",
            @"title": @"大病医疗",
            @"titleKey": @"XYDabingyiliaoController",
            @"value": @"",
            @"valueCode": @""
        },
        @{
            @"image": @"icon_sylr",
            @"title": @"赡养老人",
            @"titleKey": @"XYAlimonyPayController",
            @"value": @"",
            @"valueCode": @""
        }
    ];
    
    return array;
}

@end


#pragma mark -- 一些实用分类
