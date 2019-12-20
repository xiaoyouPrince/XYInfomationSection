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

@interface XYInfomationCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel; // chooseType
@property (weak, nonatomic) UITextField *inputTF; // inputType
@property (weak, nonatomic) IBOutlet UIView *accessoryView;



/** cellType */
@property(nonatomic, assign ,readonly)     XYInfoCellType cell_type;

@end

@implementation XYInfomationCell

#pragma mark - lazyLoad


#pragma mark - init

- (void)buildUIForInput
{
    // base
    // image + titleLabel + inputTF + accessoryView
    
    // imageView
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
    
    // inputTF
    UITextField *inputTF = [UITextField new];
    self.inputTF = inputTF;
    [self addSubview:inputTF];
    
    inputTF.textAlignment = NSTextAlignmentRight;
    inputTF.font = [UIFont systemFontOfSize:14];
    
    // accessoryView
    UIView *accessoryView = [[UIView alloc] init];
    self.accessoryView = accessoryView;
    [self addSubview:accessoryView];
    
    // constraint
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self).offset(15);
        make.centerY.equalTo(self);
        make.bottom.greaterThanOrEqualTo(self).offset(-15);
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.width.equalTo(self).multipliedBy(kTitleRate); // 占整体宽度
    }];
    
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
    }];
    
    [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(15);
        make.right.equalTo(self.accessoryView.mas_left).offset(-5);
    }];
}

- (void)buildUIForChoose
{
    // base
    // image + titleLabel + inputTF + accessoryView
    
    // imageView
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
    
    // detailLabel
    UILabel *detailLabel = [[UILabel alloc] init];
    self.detailLabel = detailLabel;
    [self addSubview:detailLabel];
    
    detailLabel.textAlignment = NSTextAlignmentRight;
    detailLabel.numberOfLines = 0;
    detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    // accessoryView
    UIView *accessoryView = [[UIView alloc] init];
    self.accessoryView = accessoryView;
    [self addSubview:accessoryView];
    
    // constraint
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self).offset(15);
        make.centerY.equalTo(self);
        make.bottom.greaterThanOrEqualTo(self).offset(-15);
        make.left.equalTo(self.imageView.mas_right).offset(10);
        make.width.equalTo(self).multipliedBy(kTitleRate); // 占整体宽度
    }];
    
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.top.greaterThanOrEqualTo(self).offset(8); // 最多和高底8pt
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self).offset(15);
        make.centerY.equalTo(self);
        make.bottom.greaterThanOrEqualTo(self).offset(-15);
        make.left.equalTo(self.titleLabel.mas_right).offset(15);
        make.right.equalTo(self.accessoryView.mas_left).offset(-5);
    }];
    
    
}

- (void)setupContent{
    
    self.inputTF.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.backgroundColor = UIColor.clearColor;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = HEXCOLOR(0x999999);
    
    self.inputTF.font = [UIFont systemFontOfSize:14];
    self.inputTF.textColor = HEXCOLOR(0x333333);
    
    self.detailLabel.font = [UIFont systemFontOfSize:14];
    self.detailLabel.textColor = HEXCOLOR(0x333333);
    
    // 添加一个底部的线
    UIView *line = [UIView new];
    line.backgroundColor = HEXCOLOR(0xeaeaea);
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
            [cell buildUIForInput];
            cell.model = model;
        }
            break;
        case XYInfoCellTypeChoose:
        {
            cell->_cell_type = XYInfoCellTypeChoose;
            [cell buildUIForChoose];
            cell.model = model;
        }
            break;
        case XYInfoCellTypeOther: // 如果是自定义类型，那就根据model中自定义类来创建
        {
//            XYInfomationCell *cell = [XYInfomationCell new];
//            cell->_cell_type = XYInfoCellTypeChoose;
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
        
        // image
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
        }];
        
        // titleLabel
        self.titleLabel.textColor = HEXCOLOR(0x333333);
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.imageView.mas_right).offset(10);
        }];

    }else{
        // imageView
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeZero);
        }];
        
        // 没有设置icon
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.imageView.mas_right).offset(0);
        }];
    }
    
    // 3. title
    self.titleLabel.text = model.title;
    
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
        
    }else // chooseType
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
    }
    
    
    // 5. 处理禁用用户点击且cellType为input的情况，防止展示的文字过多，tf也不能进行文字折行
    if (self.inputTF && model.disableUserAction) { // 如果是textField这种输入的情况，因为TF不能换行，这里禁用了用户操作之后，就替替换成label，这样就能正常根据文字多少进行折行操作了，也能正确展示对应的自适应高度
        
        UILabel *label = [UILabel new];
        label.font = self.inputTF.font;
        label.textColor = self.inputTF.textColor;
        label.textAlignment = NSTextAlignmentRight;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.numberOfLines = 0;
        label.text = self.inputTF.text;
        label.tag = 100;
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(15);
            make.centerY.equalTo(self);
            make.bottom.greaterThanOrEqualTo(self).offset(-15);
            make.left.equalTo(self.titleLabel.mas_right).offset(15);
            make.right.equalTo(self.accessoryView).offset(0); // 默认无accessoryView
        }];
        
        
        
        [label setNeedsDisplay];
        [label layoutIfNeeded];
        
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
        [_accessoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (model.type == XYInfoCellTypeInput) {
                make.leading.equalTo(weakSelf.inputTF.mas_trailing).offset(5);
            }
            if (model.type == XYInfoCellTypeChoose) {
                make.leading.equalTo(weakSelf.detailLabel.mas_trailing).offset(5);
            }
            make.trailing.equalTo(weakSelf).offset(-10);
            make.centerY.equalTo(weakSelf.imageView);
            make.size.mas_equalTo(weakSelf.accessoryView.frame.size);
        }];
    }else
    {
        // 用户没有设置accessoryView。这里根据自定类型来设置对应的默认accessoryView
        if (model.type == XYInfoCellTypeInput) {
            // 默认 _accessoryView = nil
            _accessoryView.hidden = YES;
            [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(10);
            }];
        }
        if (model.type == XYInfoCellTypeChoose) {
            // 默认 _accessoryView = 向右的箭头
            NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"XYInfomationSection" ofType:@"bundle"];
            NSString *arrawPath = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"rightArraw_lightGray@3x" ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:arrawPath];
            
            UIImageView *rightArraw = [UIImageView new];
            rightArraw.image = image;
            _accessoryView.hidden = NO;
            [_accessoryView addSubview:rightArraw];
            [rightArraw mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_accessoryView);
            }];
            [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(10);
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
    
    
    // 8. 更新实际高度
    if (model.isFold) {// 用户设置折叠
        self.hidden = YES;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
    }else
    {
        self.hidden = NO;
        
        // 设置自己默认最低高度
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.greaterThanOrEqualTo(@(model.def_cellHeight));
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
        if ([self.detailLabel.text isEqualToString:@" "]) {
            self.detailLabel.text = nil;
        }
    }
}

#pragma Mark - UITextFieldDelegate 监听文字修改
- (void)textFieldTextChanged:(NSNotification *)noty
{
    // 文字已经修改了，修改自己的数据模型
    
    self.model.value = self.inputTF.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
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
