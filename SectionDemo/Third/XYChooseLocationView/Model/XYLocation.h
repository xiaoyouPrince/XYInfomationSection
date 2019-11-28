//
//  XYLocation.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/28.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYLocation : NSObject

//"id": 130638,
//"name": "雄县",
//"pid": 130600

/** 当前级别id */
@property (nonatomic, copy)         NSString * id;
/** 当前name */
@property (nonatomic, copy)         NSString * name;
/** 父级别id */
@property (nonatomic, copy)         NSString * pid;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)modelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
