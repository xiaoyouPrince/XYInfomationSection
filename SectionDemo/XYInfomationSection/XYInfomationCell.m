//
//  XYInfomationCell.m
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/5/23.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

/*
 1. 滑动，调用回调设置滑动功能按钮，默认为删除
 2. 删除操作点击按钮回调
 3. 支持系统样式的UI，滑动删除动画
 */

/*
 1. 一次创建的 cell 过多，有明显性能问题，刷新 cell 是否可以使用缓存池，参考系统 UITableView
 2. 更新cell的内容是否可以先校验数据源是否发生改变，决定是否从新绘制cell？
 */

@class XYInfomationCell;
@protocol SwipeCell <NSObject>
@optional
/// 返回cell是否可以滑动
- (BOOL)canSwip;

/// 自定义滑动功能
- (NSArray <UIView *> *)actionBtns;



@end



/*!
 
 分析:
 cell类型 1.只展示 2.输入 3.有AccessryView
 
 */

// 可能选择的情况： 出生日期选择(年月日) || 地区选择(省市区) || 单选框

#import "XYInfomationCell.h"
#import "XYInfoTextView.h"
#import <objc/runtime.h>
#import "Masonry.h"

@implementation XYInfomationItemSwipeConfig : NSObject

+ (XYInfomationItemSwipeConfig *)standardDeleteAction {
    XYInfomationItemSwipeConfig *config = [[XYInfomationItemSwipeConfig alloc] init];
    config.canSwipe = YES;
    config.type = 1;
    config.actionBtns = ^NSArray<UIView *> * _Nonnull(XYInfomationCell * _Nonnull cell) {
        
        NSString *title = @"delete";
        CGFloat width = 80;
        UIColor *color = UIColor.systemRedColor;
        
        UIButton *delete = [UIButton new];
        [delete setTitle:title forState:UIControlStateNormal];
        delete.bounds = CGRectMake(0, 0, width, 100);
        delete.backgroundColor = color;
        
        [delete addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return @[delete];
    };
    return config;
}

+ (void)deleteBtnClick:(UIButton *)sender {
    
    if ([sender.superview isKindOfClass:XYInfomationCell.class]) {
        XYInfomationCell *cell = (XYInfomationCell *)sender.superview;
        cell.model.fold = YES;
        cell.model = cell.model;// just modify self
    }
}


@end

@implementation XYInfomationItem

/// 创建方法(通过dictionary创建)
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    // 防止未定义的key报错
}

/// 默认设置的cell高度
- (CGFloat)def_cellHeight
{
    if (_cellHeight > 0) {
        return _cellHeight;
    }
    return 50.f;
}

- (UIColor *)titleColor
{
    if (!_titleColor) {
        return HEXCOLOR(0x333333);
    }
    return _titleColor;
}

- (UIFont *)titleFont
{
    if (!_titleFont) {
        return [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}

- (UIColor *)valueColor
{
    if (!_valueColor) {
        return HEXCOLOR(0x000000);
    }
    return _valueColor;
}

- (UIFont *)valueFont
{
    if (!_valueFont) {
        return [UIFont systemFontOfSize:14];
    }
    return _valueFont;
}

- (UIColor *)placeholderColor
{
    if (!_placeholderColor) {
        return HEXCOLOR(0x999999);
    }
    return _placeholderColor;
}


- (UIFont *)placeholderFont
{
    if (!_placeholderFont) {
        return [UIFont systemFontOfSize:14];
    }
    return _placeholderFont;
}

- (UIEdgeInsets)tipEdgeInsets{
    if (!_tipEdgeInsets.top) {
        return UIEdgeInsetsMake(10, 20, 10, 20);
    }
    return _tipEdgeInsets;
}

- (NSString *)titleKey{
    if (!_titleKey) {
        return _title;
    }
    return _titleKey;
}

- (BOOL)isOn{
    return [NSUserDefaults.standardUserDefaults boolForKey:self.titleKey];
}

- (void)setOn:(BOOL)on{
    [NSUserDefaults.standardUserDefaults setBool:on forKey:self.titleKey];
}

+ (instancetype)modelWithTitle:(NSString *)title
                      titleKey:(NSString *)titleKey
                          type:(XYInfoCellType)type
                         value:(NSString *)value
              placeholderValue:(NSString *)placeholderValue
             disableUserAction:(BOOL)disableUserAction{
    
    return [self modelWithImage:nil Title:title titleKey:titleKey type:type value:value placeholderValue:placeholderValue disableUserAction:disableUserAction];
}

+ (instancetype)modelWithImage:(nullable NSString *)imageName
                         Title:(nullable NSString *)title
                      titleKey:(nullable NSString *)titleKey
                          type:(XYInfoCellType)type ///< default is 0 input
                         value:(nullable NSString *)value
              placeholderValue:(nullable NSString *)placeholderValue
             disableUserAction:(BOOL)disableUserAction{
    
    XYInfomationItem *instance = [[self.class alloc] init];
    instance.imageName = imageName;
    instance.title = title;
    instance.titleKey = titleKey;
    instance.type = type;
    instance.value = value.length ? value : nil;
    instance.placeholderValue = placeholderValue.length ? placeholderValue : nil;
    instance.disableUserAction = disableUserAction;
    
    return instance;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return [self xy_copy];
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [self xy_copy];
}

- (nonnull id)xy_copy{
    XYInfomationItem *item = [XYInfomationItem new];
    
    NSMutableDictionary *props = @{}.mutableCopy;
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++){
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    
    [item setValuesForKeysWithDictionary:props];
    return item;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@> %lld: title:%@", NSStringFromClass(self.class), (long long)self, self.title];
}

@end

#define kTitleRate 0.3  // 设置titleLabel占整体宽度比例

@interface XYInfomationCell ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *detailLabel; // chooseType
@property (weak, nonatomic) UITextField *inputTF; // inputType
@property (weak, nonatomic) XYInfoTextView *inputTV;  // tvType
@property (weak, nonatomic) UIView *accessoryView;
@property (strong, nonatomic) UIView *seprateLine;

@property (strong, nonatomic) UIPanGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

/** cellType */
@property(nonatomic, assign ,readonly)     XYInfoCellType cell_type;

@end

@interface XYInfomationCell (Swipe) <SwipeCell, UIGestureRecognizerDelegate>
- (void)addGesture;

@end

@implementation XYInfomationCell
{
    // 默认的accessoryView只设置一次
    BOOL _hasSetDefaultAccessoryView;
}

#pragma mark - lazyLoad


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // base(input/choose)
        // image + titleLabel + [inputTF | detailLabel] + accessoryView
        UIImageView *imageView = [UIImageView new];
        self.imageView = imageView;
        [self addSubview:imageView];
        
        // titleLabel
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        // accessoryView
        UIView *accessoryView = [[UIView alloc] init];
        self.accessoryView = accessoryView;
        [self addSubview:accessoryView];
        
        // seprateLine
        UIView *seprateLine = [UIView new];
        self.seprateLine = seprateLine;
    }
    return self;
}


- (void)setupContent{
    
    self.inputTF.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.inputTV.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    if (self.model.backgroundColor) {
        self.backgroundColor = self.model.backgroundColor;
    }else if (!self.backgroundColor){
        self.backgroundColor = UIColor.clearColor;
    }
    
    self.titleLabel.font = self.model.titleFont;
    self.titleLabel.textColor = self.model.titleColor;
    
    self.inputTF.font = self.model.valueFont;
    self.inputTF.textColor = self.model.valueColor;
    
    self.inputTV.font = self.model.valueFont;
    self.inputTV.textColor = self.model.valueColor;
    
    self.detailLabel.font = self.model.valueFont;
    self.detailLabel.textColor = self.model.valueColor;
    
    UILabel *placeholderLabel = [self.inputTF valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = self.model.placeholderColor;
    self.inputTV.placeholderColor = self.model.placeholderColor;
    
    // 隐藏subView，需自定义实现
    if (self.model.type == XYInfoCellTypeOther) {
        self.imageView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.titleLabel.hidden = YES;
        self.inputTV.hidden = YES;
        self.inputTF.hidden = YES;
        //[self.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:@YES];
    }
    
    // 添加一个底部的线
    UIView *line = self.seprateLine;
    if (self.model.isHideSeparateLine) {
        line.backgroundColor = UIColor.clearColor;
    }else{
        line.backgroundColor = HEXCOLOR(0xeaeaea);
    }
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(0.5);
    }];
    
}


+ (instancetype)cellWithModel:(XYInfomationItem *)model
{
    XYInfomationItem *cellModel = [XYInfomationItem new];
    if (model) {
        cellModel = model;
    }
    
    // 根据model创建不同内容
    XYInfomationCell *cell = [XYInfomationCell new];
    switch (model.type) {
        case XYInfoCellTypeInput:
        {
            cell->_cell_type = XYInfoCellTypeInput;
            cell.model = model;
        }
            break;
        case XYInfoCellTypeChoose:
        {
            cell->_cell_type = XYInfoCellTypeChoose;
            cell.model = model;
        }
            break;
        case XYInfoCellTypeTextView:
        {
            cell->_cell_type = XYInfoCellTypeTextView;
            cell.model = model;
        }
            break;
        case XYInfoCellTypeTip:
        {
            cell = [NSClassFromString(@"XYInfomationTipCell") new];
            cell->_cell_type = XYInfoCellTypeTip;
            cell.model = model;
        }
            break;
        case XYInfoCellTypeSwitch:
        {
            cell = [NSClassFromString(@"XYInfomationSwitchCell") new];
            cell->_cell_type = XYInfoCellTypeSwitch;
            cell.model = model;
        }
            break;
        case XYInfoCellTypeOther: // 如果是自定义类型，那就根据model中自定义类来创建
        {
            if ([model.customCellClass isKindOfClass:[NSNull class]]) {
                @throw [[NSException alloc] initWithName:@"入参错误" reason:@"model.type为Other，必须传入 customCellClass" userInfo:nil];
            }
            
            // 兼容旧版本，v1.3之前定义 String 类型
            if ([model.customCellClass isKindOfClass:[NSString class]]) {
                NSString *className = (NSString *)model.customCellClass;
                if (NSClassFromString(className)) {
                    cell = [NSClassFromString(className) new];
                }
            } else {
                // 新版改为 Class 直接注册，提升性能
                cell = [model.customCellClass new];
            }
            
            cell->_cell_type = XYInfoCellTypeOther;
            cell.model = model;
        }
            break;
        default:
            break;
    }
    
    [cell setupContent];
    return cell;
}



#pragma mark - 赋值

/// 如果cellType 和 model 的type不一致，这里以cellType为准
- (void)setModel:(XYInfomationItem *)model
{
    _model = model;
    model.type = self.cell_type;
    __weak typeof(self) weakSelf = self;
    
    
    // 0. 依据cellType创建对应的 inputTF | detailLabel
    if (model.type == XYInfoCellTypeInput) {
        
        // inputTF
        if (!self.inputTF) {
            UITextField *inputTF = [UITextField new];
            self.inputTF = inputTF;
            [self addSubview:inputTF];
            inputTF.textAlignment = NSTextAlignmentRight;
            inputTF.font = [UIFont systemFontOfSize:14];
        }
        
    }else if (model.type == XYInfoCellTypeChoose)
    {
        // detailLabel
        if (!self.detailLabel) {
            UILabel *detailLabel = [[UILabel alloc] init];
            self.detailLabel = detailLabel;
            [self addSubview:detailLabel];
            
            detailLabel.textAlignment = NSTextAlignmentRight;
            detailLabel.numberOfLines = 0;
            detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        }
    }
    else if (model.type == XYInfoCellTypeTextView)
    {
        // detailLabel
        if (!self.inputTV) {
            XYInfoTextView *inputTV = [XYInfoTextView new];
            self.inputTV = inputTV;
            [self addSubview:inputTV];
            inputTV.textAlignment = NSTextAlignmentLeft;
            inputTV.font = [UIFont systemFontOfSize:14];
        }
    }else if (model.type == XYInfoCellTypeTip)
    {
        return;
    }
    
    
    // 1. 设置自己是否接受用户事件,自己能接收touch，但是内部subView不可接收事件
    for (UIView *subView in self.subviews) {
        if (model.disableUserAction) {
            subView.userInteractionEnabled = !model.disableUserAction;
        }
    }
    self.userInteractionEnabled = !model.disableTouchGuesture;
    
    
    // 2. image
    if (model.imageName) { // 如果有图片就修改titleLabel左边约束
        // 图片[网络图片 || 本地图片]
        UIImage *image = [UIImage imageNamed:model.imageName];
        self.imageView.image = image;
        
        if (!image) { // 非本地图片
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
                NSURL *url = [NSURL URLWithString:model.imageName];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (image) {
                        self.imageView.image = image;
                        [self layoutImageView];
                    }
                });
            });
        }
    }
    
    // 3. title
    if (model.type != XYInfoCellTypeOther) {
        self.titleLabel.text = model.title;
    }
    
    // 4. type value placeholderValue
    if (model.type == XYInfoCellTypeInput) {
        if (model.value) {
            self.inputTF.text = model.value;
        }else
        {
            self.inputTF.text = @" ";
        }
        
        if (model.placeholderValue) {
            self.inputTF.placeholder = model.placeholderValue;
        }else{
            self.inputTF.placeholder = [@"请输入" stringByAppendingString:model.title];
        }
        
    }else if (model.type == XYInfoCellTypeChoose)// chooseType
    {
        if (model.value) {
            self.detailLabel.text = model.value;
        }else
        {
            if (model.placeholderValue) {
                self.detailLabel.text = model.placeholderValue;
            }else{
                self.detailLabel.text = [@"请选择" stringByAppendingString:model.title];
            }
        }
    }else if (model.type == XYInfoCellTypeTextView)// textViewType
    {
        if (model.value) {
            self.inputTV.text = model.value;
        }else
        {
            self.inputTV.text = @" ";
        }
        
        if (model.placeholderValue) {
            self.inputTV.placeholder = model.placeholderValue;
        }else{
            self.inputTV.placeholder = [@"请输入" stringByAppendingString:model.title];
        }
    }
    
    
    // 5. 处理禁用用户点击且cellType为input的情况，防止展示的文字过多，tf也不能进行文字折行
    if (self.inputTF && model.disableUserAction) { // 如果是textField这种输入的情况，因为TF不能换行，这里禁用了用户操作之后，就替替换成label，这样就能正常根据文字多少进行折行操作了，也能正确展示对应的自适应高度
        
        UILabel *label = [UILabel new];
        label.font = self.model.valueFont;
        label.textColor = self.model.valueColor;
        label.textAlignment = NSTextAlignmentRight;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.numberOfLines = 0;
        label.text = self.inputTF.text;
        label.tag = 100;
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self).priorityHigh();
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.right.equalTo(self.accessoryView).offset(0); // 默认无accessoryView
        }];
        
        // self.textField 隐藏
        self.inputTF.hidden = YES;
    }else
    {
        UILabel *label = [self viewWithTag:100];
        if (label) {
            [label removeFromSuperview];
        }
        // self.textField 展示
        self.inputTF.hidden = NO;
    }
    
    // 6. 用户设置的的 accessoryView 【1.以用户设置的为准，2.当类型为choose时候，默认为向右箭头】
    if (model.accessoryView) {
        // 1. 用户有设置，以用户设置为准
        [self.accessoryView removeFromSuperview];
        self.accessoryView = nil;
        self.accessoryView = model.accessoryView;
        [self addSubview:self.accessoryView];
        
        if (model.accessoryView.bounds.size.height) {
            [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(model.accessoryView.frame.size);
            }];
        }else
        {
            [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(model.accessoryView);
            }];
        }
    }else
    {
        // 默认 accessoryView.size = {10,10}
        // 用户没有设置accessoryView。这里根据自定类型来设置对应的默认accessoryView
        if (model.type == XYInfoCellTypeInput) {
            // 默认 _accessoryView = nil
            _accessoryView.hidden = YES;
            [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(10, 10));
            }];
        }
        if (model.type == XYInfoCellTypeTextView) {
            // 默认 _accessoryView = nil
            _accessoryView.hidden = YES;
            [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(10, 10));
            }];
        }
        if (model.type == XYInfoCellTypeChoose) {
            // 默认 _accessoryView = 向右的箭头
            NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"XYInfomationSection" ofType:@"bundle"];
            NSString *arrawPath = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"rightArraw_lightGray@3x" ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:arrawPath];
            
            if (_hasSetDefaultAccessoryView == NO) {
                _hasSetDefaultAccessoryView = YES;
                UIImageView *rightArraw = [UIImageView new];
                rightArraw.image = image;
                self.accessoryView = rightArraw;
                [self addSubview:self.accessoryView];
            }
            
            _accessoryView.hidden = NO;
            [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(image.size);
            }];
        }
    }
    
    
    // 7. 用户预设cell背景图片
    if (model.backgroundImage) {
        UIImage *image_temp = [UIImage imageNamed:model.backgroundImage];
        if (image_temp) {
            UIImage *bgImage = [image_temp stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
            UIImageView *bgIV = [[UIImageView alloc] initWithImage:bgImage];
            [self insertSubview:bgIV atIndex:0];
            
            [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf);
            }];
        }
    }
    
    
    // ....  分割线的内边距 颜色
    // ....  自身背景颜色，圆角，
    // ....  内部title. 字体&颜色  value 字体和颜色
    
    // 8. 约束
    CGFloat titleRate = MAX(kTitleRate, model.titleWidthRate);
    if (self.imageView.image) {
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).priorityHigh();
            make.left.equalTo(self).offset(15);
            make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
            make.size.mas_equalTo(self.imageView.image.size);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self).priorityHigh();
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.equalTo(self.imageView.mas_right).offset(10);
            make.width.equalTo(self).multipliedBy(titleRate); // 占整体宽度
        }];
        
    }else
    {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self).priorityHigh();
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.equalTo(self).offset(15);
            make.width.equalTo(self).multipliedBy(titleRate); // 占整体宽度
        }];
    }
    
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).priorityHigh();
        make.right.equalTo(self).offset(-10);
        make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
        // 上面已经设置size
    }];
    
    if (self.cell_type == XYInfoCellTypeInput) {
        
        [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.titleLabel.mas_right).offset(15);
            make.right.equalTo(self.accessoryView.mas_left).offset(-5);
        }];
    }
    if (self.cell_type == XYInfoCellTypeTextView) {
        
        [self.inputTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.left.equalTo(self.titleLabel.mas_right).offset(15);
            make.right.equalTo(self.accessoryView.mas_left).offset(-5);
        }];
    }
    
    if (self.cell_type == XYInfoCellTypeChoose) {
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self).priorityHigh();
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.right.equalTo(self.accessoryView.mas_left).offset(-5);
        }];
    }
    
    // 9. 更新实际高度
    if (model.isFold) {// 用户设置折叠
        self.hidden = YES;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
    }else
    {
        self.hidden = NO;
        
        // 设置自己默认最低高度
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.greaterThanOrEqualTo(@(model.def_cellHeight)).priorityHigh();
        }];
        
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    // 滑动
    if ([self canSwip]) {
        [self addGesture];
    }
}

- (void)layoutImageView {
    CGFloat titleRate = MAX(kTitleRate, self.model.titleWidthRate);
    
    if (self.imageView.image) {
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).priorityHigh();
            make.left.equalTo(self).offset(15);
            make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
            
            if (self.model.cellHeight) {
                CGSize size = self.imageView.image.size;
                CGFloat realHeight = self.model.cellHeight - 16;
                CGFloat realWidth = realHeight / size.height * size.width;
                make.size.mas_equalTo(CGSizeMake(realWidth, realHeight));
            } else {
                make.size.mas_equalTo(self.imageView.image.size);
            }
        }];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self).priorityHigh();
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.equalTo(self.imageView.mas_right).offset(10);
            make.width.equalTo(self).multipliedBy(titleRate); // 占整体宽度
        }];
        
    }else
    {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self).priorityHigh();
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.equalTo(self).offset(15);
            make.width.equalTo(self).multipliedBy(titleRate); // 占整体宽度
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.model.value) { // 如果是用户自己设置的value就按用户自己设置的来
        if ([self.inputTF.text isEqualToString:@" "]) {
            self.inputTF.text = @"";
        }
        if ([self.inputTV.text isEqualToString:@" "]) {
            self.inputTV.text = @"";
        }
        if ([self.detailLabel.text isEqualToString:@" "]) {
            self.detailLabel.text = nil;
        }
    }
}

#pragma Mark - UITextFieldDelegate 监听文字修改
- (void)textFieldTextChanged:(NSNotification *)noty
{
    // 文字已经修改了，修改自己的数据模型
    UITextField *tf = noty.object;
    // Console(@"tv文字修改 --- %@",tv.text);
    
    if (tf == self.inputTF) { // 回调，值调用有用的一次，上面无用的打印会有多次
        self.model.value = self.inputTF.text;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 内部tf被点击成为第一响应者，也要调用自己被click的回调，通知外部被操作的cell
    if (self.cellTouchBlock) {
        self.cellTouchBlock(self);
    }
    return YES;
}

#pragma Mark - UITextViewDelegate 监听文字修改
- (void)textViewTextChanged:(NSNotification *)noty
{
    // 文字已经修改了，修改自己的数据模型
    UITextView *tv = noty.object;
    //Console(@"tv文字修改 --- %@",tv.text);
    
    if (tv == self.inputTV) { // 回调，值调用有用的一次，上面无用的打印会有多次
        self.model.value = self.inputTV.text;
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // 内部tf被点击成为第一响应者，也要调用自己被click的回调，通知外部被操作的cell
    if (self.cellTouchBlock) {
        self.cellTouchBlock(self);
    }
    return YES;
}

#pragma mark - actions

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - touch

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint point = [touches.anyObject locationInView:self];
    
    if (CGRectContainsPoint(self.bounds,point)) { // 点必须在self.内部
        // 如果是内部tf被点击，也要调用自己被click的回调，通知外部被操作的cell
        if (self.cellTouchBlock) {
            self.cellTouchBlock(self);
        }
    }
    
    [super touchesEnded:touches withEvent:event];
}

@end

/*
 1. 数据源：指定自定义View，宽度，
 2. 内部封装一个整体的视图作为显示用途，并
 3. 当用户支持滑动事件的时候，没有设置其他数据源，默认是系统 tableView 的滑动删除样式
 */
void doAnimation(dispatch_block_t blk);
void doAnimationWithCompletion(dispatch_block_t blk, void(^completion)(BOOL));

@implementation XYInfomationCell (Swipe)
- (void)addGesture{
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragAction:)];
    _panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:_panGestureRecognizer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == _panGestureRecognizer) {
        CGPoint translation = [_panGestureRecognizer translationInView:self];
        if (fabs(translation.y) > fabs(translation.x)) {
            return false; // user is scrolling vertically
        }
    }
    return true;
}

- (BOOL)canSwip{
    return self.model.swipeConfig.canSwipe;
}

- (NSArray<UIView *> *)actionBtns{
    
    if (self.model.swipeConfig.actionBtns) {
        return self.model.swipeConfig.actionBtns(self);
    }
    
    return @[];
}

- (UIView *)swipeContentView {
    
    UIView *swipeContentView = nil;
    
    swipeContentView = objc_getAssociatedObject(self, @selector(swipeContentView));
    if (swipeContentView == nil)
    {
        swipeContentView = [UIView new];
        swipeContentView.frame = self.bounds;
        objc_setAssociatedObject(self, @selector(swipeContentView), swipeContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeContentViewTaped:)];
        [swipeContentView addGestureRecognizer:tap];
    }
    
    return swipeContentView;
}

- (void)resetFrame {
    CGPoint currentCenter = self.center;
    self.center = CGPointMake(self.bounds.size.width / 2, currentCenter.y);
}

- (void)swipeContentViewTaped:(UITapGestureRecognizer *)tap {
    [self resetInitialState];
}

- (void)resetInitialState{
    doAnimationWithCompletion(^{
        [self resetFrame];
    }, ^(BOOL completed) {
        [self removeSwipeContentView];
        [self removeAllActionButtons];
    });
}

- (CGFloat)getMaxSwipeWidth{
    CGFloat maxSwipeWidth = 0;
    for (UIView *actionView in [self actionBtns]) {
        maxSwipeWidth += actionView.frame.size.width;
    }
    return maxSwipeWidth;
}

/// 设置滑动结束状态
- (void)setSwipeEndState{
    
    [self addSwipeContentView];
    
    CGFloat maxSwipeWidth = [self getMaxSwipeWidth];
    
    doAnimation(^{
        CGPoint currentCenter = self.center;
        self.center = CGPointMake(self.bounds.size.width / 2 - maxSwipeWidth, currentCenter.y);
    });
}

- (void)addSwipeContentView{
    [self addSubview:[self swipeContentView]];
}

- (void)removeSwipeContentView{
    [[self swipeContentView] removeFromSuperview];
}

- (void)removeAllActionButtons{
    NSUInteger count = [self actionBtns].count;
    
    for (NSUInteger i = 0; i < count; i ++) {
        if([self viewWithTag:1000 + i]) {
            [[self viewWithTag:1000 + i] removeFromSuperview];
        }
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGFloat maxSwipeWidth = [self getMaxSwipeWidth];
    CGRect totalRect = CGRectMake(0, 0, self.frame.size.width + maxSwipeWidth, self.frame.size.height);
    if (CGRectContainsPoint(totalRect, point)) {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

- (void)dragAction:(UIPanGestureRecognizer *)pan {
    if ([self canSwip] == NO) { return; }
    
    /*
     滑动删除功能逻辑
     
     1. 滑动开始, 判断是否是横向滑动, 纵向滑动 return
     2. 横向滑动, cell 根据滑动内容位移
        2.1 启动从当前滑动位置启动, 记录位移起始点
        2.2 滑动过程中,以起始点计算位移位置滚动
        2.3 滑动停止,将 cell 停止到目标位置
            2.3.1 滑动停止时候是否有惯性,根据惯性和滑动方向自动设置为复原或者目标位置
            2.3.2 如果没有惯性,则根据固定滑动位移决定设置复原或者目标位置
     */
    
    // 支持左右滑动，
    static NSArray *btns = nil;
    static CGFloat maxSwipeWidth = 0;
    static CGPoint origin;
    static CGPoint swipeStartCenter;
    
    CGFloat xFromCenter = [pan translationInView:self].x;
    CGFloat yFromCenter = [pan translationInView:self].y;
    
    Console(@"当前滑动位置 - %@", NSStringFromCGPoint([pan translationInView:self]));
    
    if (yFromCenter > 0) {
        Console(@"down");
    }else{
        Console(@"up---%f",yFromCenter);
    }
    
    if (xFromCenter < 0) { // left
        Console(@"left");
    }else{
        Console(@"right---%f",xFromCenter);
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            Console(@"begin");
            
            // 清空上一次状态
#warning(@"这里会每次创建,视觉上没有问题,但是性能上待优化")
            btns = nil;
            maxSwipeWidth = 0;
            origin = self.frame.origin;
            [self removeAllActionButtons];
            [self removeSwipeContentView];
            
            // 获取按钮 - 需要指定宽度 - 计算最大可以滑动宽度
            btns = [self actionBtns];
            int index = -1;
            for (UIView * btn in btns) {
                index += 1;
                [self addSubview:btn];
                
                btn.frame = CGRectMake(self.frame.size.width + maxSwipeWidth,
                                       0,
                                       btn.frame.size.width,
                                       self.frame.size.height);
                btn.tag = 1000 + index;
                maxSwipeWidth += btn.bounds.size.width;
            }
            
            // 记录起始位置
            swipeStartCenter = self.center;
            
            break;
            
        case UIGestureRecognizerStateChanged:
            Console(@"change");
            
            CGPoint currentCenter = swipeStartCenter;
            currentCenter.x += xFromCenter;
            self.center = currentCenter;
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            Console(@"end");
            
            // 拿到当前方向 (起止位置比较)
            // 左滑，且起始点为原点，超过50%，划过去 --- 反之复原
            // 左滑，且起始点非原点，复原
            
            CGFloat velocity = [pan velocityInView:self].x;
            CGFloat inertiaThreshold = 100.0; //points per second
            
            if (velocity > inertiaThreshold) { // 收起,复原位置
                Console(@"velocity > 100");
                
                [self resetInitialState];
            }
            else if (velocity < -inertiaThreshold) { // left 弹出
                Console(@"velocity < -100");
                
                [self setSwipeEndState];
            }
            else{ // 无惯性,看是否超过滑出阀值(50dp)
                
                if (xFromCenter < -50){ // 滑出
                    [self setSwipeEndState];
                }else{ // 复位
                    [self resetInitialState];
                }
            }
            
            break;
            
        default:
            break;
    }
}

@end


#pragma mark - util functions
#define AnimationDuration 0.25
void doAnimation(dispatch_block_t blk){
    doAnimationWithCompletion(blk, nil);
}
void doAnimationWithCompletion(dispatch_block_t blk, void(^completion)(BOOL)){
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:AnimationDuration animations:blk completion:completion];
    });
}
#undef AnimationDuration
