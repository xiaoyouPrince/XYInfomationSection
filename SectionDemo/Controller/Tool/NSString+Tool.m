//
//  NSString+Tool.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/21.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)

#pragma mark - private

- (BOOL)matchWithPattern:(NSString *)pattern
{
    if (!self.length) {
        return NO;
    }
    
    NSRegularExpression *regx = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    __block BOOL _result = NO;
    [regx enumerateMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
            if (result.range.location != NSNotFound) {
                *stop = YES;
                _result = YES;
            }
    }];
    
    return _result;
}

#pragma mark - public

- (BOOL)isDateFromat
{
    NSString *pattern = @"\\d{4}-\\d{2}-\\d{2}";
    return [self matchWithPattern:pattern];
}


/**
 校验是不是18为身份证号
 */
- (BOOL)isIDCard;
{
    NSString *userID = self;
    
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

- (NSString *)birthdayFromIDCard
{
    if ([self isIDCard]) {
        
        // 取 7-10 位 -> yyyy
        // 取 11-12 位 -> MM
        // 取 13-14 位 -> dd
        
        NSString *yyyy = [self substringWithRange:NSMakeRange(6, 4)];
        NSString *MM = [self substringWithRange:NSMakeRange(10, 2)];
        NSString *dd = [self substringWithRange:NSMakeRange(12, 2)];
        NSArray *array = @[yyyy,MM,dd];
        
        return [array componentsJoinedByString:@"-"];
    }
    
    return nil;
}

@end
