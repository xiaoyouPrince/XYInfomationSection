//
//  XYInfomationCell.m
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/5/23.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

/*!
 
 分析:
 cell类型 1.只展示 2.输入 3.有AccessryView
 
 */

// 可能选择的情况： 出生日期选择(年月日) || 地区选择(省市区) || 单选框

#import "XYInfomationCell.h"
#import "XYInfoTextView.h"
#import <objc/runtime.h>
#import "Masonry.h"

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
    if (_cellHeight >= 50) {
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



/** cellType */
@property(nonatomic, assign ,readonly)     XYInfoCellType cell_type;

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
        case XYInfoCellTypeOther: // 如果是自定义类型，那就根据model中自定义类来创建
        {
            if (NSClassFromString(model.customCellClass)) {
                cell = [NSClassFromString(model.customCellClass) new];
            }else
            {
                @throw [[NSException alloc] initWithName:@"入参错误" reason:@"model.type为Other，必须传入 customCellClass" userInfo:nil];
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
        if (!image) { // 非本地图片
            NSURL *url = [NSURL URLWithString:model.imageName];
            NSData *data = [NSData dataWithContentsOfURL:url];
            image = [UIImage imageWithData:data];
        }
        self.imageView.image = image;
        
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
    // NSLog(@"tv文字修改 --- %@",tv.text);
    
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
    //NSLog(@"tv文字修改 --- %@",tv.text);
    
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
