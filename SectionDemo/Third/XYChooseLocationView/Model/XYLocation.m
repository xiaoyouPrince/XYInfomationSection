//
//  XYLocation.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/28.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import "XYLocation.h"

@implementation XYLocation

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self new] modelWithDict:dict];
}
- (instancetype)modelWithDict:(NSDictionary *)dict
{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
- (NSString *)description
{
    return [NSString stringWithFormat:@"\n{\n\t id : %@\n\t name : %@\n\t pid : %@\n}",self.id,self.name,self.pid];
}

@end
