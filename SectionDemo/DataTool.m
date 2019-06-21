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

@end


#pragma mark -- 一些实用分类
