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
    if ([key isEqualToString:@""]) {
        return [self citiesArray];
    }
    
    return [self citiesArray];
}

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

@end


#pragma mark -- 一些实用分类
