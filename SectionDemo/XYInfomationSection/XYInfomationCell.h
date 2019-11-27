//
//  XYInfomationCell.h
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/5/23.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>


/*!
 
 @note todos
 
 1. 设置cell高度  default is 50pt
 内部属性有两个
 cellHeight(用户自定义 cell高度)
 def_cellHeight(readonly 默认50)，
 
 */



/*!
 
 @abstract
 赋值逻辑
 创建item时候，如果专门传递了code码，则不论类型为何种，最终取值value = 用户赋值的code
 
 取值逻辑
 不管赋值时候 cellType 为 input 还是 choose，最终取值都按用户是否专门传递code来取，如果用户专门赋值code即以用户赋值为准
 
 展示逻辑
 
 使用逻辑
 
 */

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XYInfoCellType) {
    XYInfoCellTypeInput = 0,  // default is input
    XYInfoCellTypeChoose,     // 用于弹出下拉框选择的
    XYInfoCellTypeDisplay,    // 仅用来展示内容的：[image] + title + [icon]
    XYInfoCellTypeOther,   // 日后扩展，例如cell内部的右边的view
};

@interface XYInfomationItem : NSObject
/**
 图片名 default is nil
 */
@property(nonatomic , copy)     NSString *imageName;
/**
 汉字title default is nil
 */
@property(nonatomic , copy)     NSString *title;
/**
 汉字title的Key default is nil
 */
@property(nonatomic , copy)     NSString *titleKey;
/**
 类型，输入还是选择  0 输入  1 选择, default is inputType
 */
@property(nonatomic , assign)     XYInfoCellType type;
/**
 用户填写或者选择的信息 default is nil
 */
@property(nonatomic , copy)     NSString *value;
/**
 用户选择的信息的内容code码 default is nil
 */
@property(nonatomic , copy)     NSString *valueCode;
/**
 用户设置的站位信息 default is nil displays "请输入/选择 + self.title"
 */
@property(nonatomic , copy)     NSString *placeholderValue;
/**
 用户预设的右边辅助view
 */
@property(nonatomic , strong)     UIView *accessoryView;
/**
 用户预设的cell背景图片名
 */
@property(nonatomic , copy)     NSString *backgroundImage;
/**
 cellHeight:用户自己设置的初始化cellHeight 默认0，如果其值小于50 会取 def_celleHeight
 */
@property(nonatomic , assign)     CGFloat cellHeight;
/**
 def_cellHeight: 默认 cellHeight 50pt,优先使用用户自己设置的 cellHeight
 */
@property(nonatomic , assign , readonly)     CGFloat def_cellHeight;

/**
 fold: 设置cell是否隐藏,默认 NO ,用户设置为YES则，本行折叠
 */
@property(nonatomic , assign, getter=isFold)     BOOL fold;

/**
 @brief
 设置是否可以接受用户事件,default is NO, 可以自己赋值
 
 @discussion 重要，
 此属性用于禁用用户操作的情况下
 
 @note
 当设置此值的时候，如果cellType为input且最终取值为code，即需要自己提前设置valueCode值，最终取整体参数值会以codeValue为准
 */
@property(nonatomic , assign)   BOOL disableUserAction;

/**
 model中额外的数据对象。default is nil
 */
@property(nonatomic , strong)   id obj;

/// 创建方法(通过dictionary创建)
+ (instancetype)modelWithDict:(NSDictionary *)dict;

/**
 快速创建一个没有图片的Item
 
 @param title title
 @param titleKey titleKey
 @param type type
 @param value value
 @param placeholderValue 站位用户输入值
 @param disableUserAction 是否禁用Cell点击事件
 @return 无图Item
 */
+ (instancetype)modelWithTitle:(nullable NSString *)title
                      titleKey:(nullable NSString *)titleKey
                          type:(XYInfoCellType)type ///< default is 0 input
                         value:(nullable NSString *)value
              placeholderValue:(nullable NSString *)placeholderValue
             disableUserAction:(BOOL)disableUserAction; ///< defalut is NO

/**
 快速创建一个有图片的Item
 
 @param imageName imageName
 @param title title
 @param titleKey titleKey
 @param type type 一旦设置，type不可变
 @param value value
 @param placeholderValue 站位用户输入值
 @param disableUserAction 是否禁用Cell点击事件
 @return 无图Item
 */
+ (instancetype)modelWithImage:(nullable NSString *)imageName
                         Title:(nullable NSString *)title
                      titleKey:(nullable NSString *)titleKey
                          type:(XYInfoCellType)type ///< default is 0 input
                         value:(nullable NSString *)value
              placeholderValue:(nullable NSString *)placeholderValue
             disableUserAction:(BOOL)disableUserAction; ///< defalut is NO


@end



/// 默认是default
@interface XYInfomationCell : UIView

typedef void(^XYInfomationCellTouchBlock)(XYInfomationCell *cell);

/** cell 内部的dataArray，如果cellType是choose类型，每次点击就会调出选择框，此dataArray 用于缓存对应的数据，下次调用前可以优先取用缓存数据，提升性能 */
@property(nonatomic , strong)     NSArray *dataArray;

/** model */
@property(nonatomic , strong)  XYInfomationItem *model;

/** 自己整体的touch 回调 */
@property(nonatomic , copy)    XYInfomationCellTouchBlock cellTouchBlock;


/**
 快速创建一个infoCell 此方法创建的cell赋值model必须内部的cellType一致
 
 @param type 可以为空，默认为input
 @return infoCell
 */
+ (instancetype)cellWithType:(XYInfoCellType)type;

/**
 快速创建一个infoCell
 
 @param model cell.model
 @return infoCell
 */
+ (instancetype)cellWithModel:(XYInfomationItem*)model;

@end

NS_ASSUME_NONNULL_END
