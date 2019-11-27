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

@implementation XYInfomationItem

MJCodingImplementation;

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

//- (NSString *)title
//{
//    return @"title";
//}
//
//- (NSString *)value
//{
//    return @" 可能选择的情况： 出生日期选择(年月日) || 地区选择(省市区) || 单选框, 可能选择的情况： 出生日期选择(年月日) || 地区选择(省市区) || 单选框";
//}

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

@interface XYInfomationCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel; // chooseType
@property (weak, nonatomic) IBOutlet UITextField *textField; // inputType
@property (weak, nonatomic) IBOutlet UIView *accessoryView;

/** cellType */
@property(nonatomic, assign ,readonly)     XYInfoCellType cell_type;

@end

@implementation XYInfomationCell

#pragma mark - lazyLoad


#pragma mark - init


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.backgroundColor = UIColor.clearColor;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = HEXCOLOR(0x999999);
    
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textColor = HEXCOLOR(0x333333);
    
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

+ (instancetype)cellWithType:(XYInfoCellType)type
{
    XYInfoCellType cellType = XYInfoCellTypeInput;
    if (type) {
        cellType = type;
    }
    
    XYInfomationCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][cellType];
    cell->_cell_type = cellType;
    
    return cell;
}

+ (instancetype)cellWithModel:(XYInfomationItem *)model
{
    XYInfomationItem *cellModel = [XYInfomationItem new];
    if (model) {
        cellModel = model;
    }
    
    XYInfomationCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][cellModel.type];
    cell->_cell_type = cellModel.type;
    cell.model = cellModel;
    
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
        
        // titleLabel
        self.titleLabel.textColor = HEXCOLOR(0x333333);
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.imageView.mas_right).offset(10);
        }];

    }else{
        
#warning - mark todo 001 更新约束，不能直接混用，要么XIB要么MAS
        for (NSLayoutConstraint *cons in self.imageView.constraints) {
            if (cons.constant == 22) { // xib 中设置width为22，不能直接用mas_update
                cons.constant = 0;
                break;
            }
        }
    }
    
    // 3. title
    self.titleLabel.text = model.title;
    
    // 站位颜色
    // self.textField.placeholderColor = self.textField.textColor;
    
    // 4. type value placeholderValue
    if (model.type == XYInfoCellTypeInput) {
        if (model.value) {
            self.textField.text = model.value;
        }else
        {
            self.textField.text = @" ";
        }
        
        if (model.placeholderValue) {
            self.textField.placeholder = model.placeholderValue;
        }else{
            self.textField.placeholder = [@"请输入" stringByAppendingString:model.title];
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
    if (self.textField && model.disableUserAction) { // 如果是textField这种输入的情况，因为TF不能换行，这里禁用了用户操作之后，就替替换成label，这样就能正常根据文字多少进行折行操作了，也能正确展示对应的自适应高度
        
        UILabel *label = [UILabel new];
        label.font = self.textField.font;
        label.textColor = self.textField.textColor;
        label.textAlignment = NSTextAlignmentRight;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.numberOfLines = 0;
        label.text = self.textField.text;
        label.tag = 100;
        
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(12);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(10);
            make.right.equalTo(weakSelf).offset(-15);
            make.bottom.equalTo(weakSelf).offset(-12);
        }];
        
        
        [label setNeedsDisplay];
        [label layoutIfNeeded];
        
        // self.textField 隐藏
        self.textField.hidden = YES;
    }else
    {
        UILabel *label = [self viewWithTag:100];
        if (label) {
            [label removeFromSuperview];
        }
        // self.textField 展示
        self.textField.hidden = NO;
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
                make.leading.equalTo(weakSelf.textField.mas_trailing).offset(5);
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
            _accessoryView.hidden = NO;
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
        [self.titleLabel sizeToFit];
        CGFloat def_cellHeight = model.def_cellHeight;
        CGFloat title_cellHeight = self.titleLabel.bounds.size.height + 30;
        CGFloat max_cellHeight = MAX(def_cellHeight, title_cellHeight);
        
        if (model.type == XYInfoCellTypeInput) { // 输入类型以 titleLabel为准
            
            // 处理禁用已经将textField替换成Label的情况
            UILabel *label = [self viewWithTag:100];
            if (label) {
                
                [label sizeToFit];
                CGFloat final_max_height = MAX(max_cellHeight, label.bounds.size.height+30);
                
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(final_max_height));
                }];
            }else
            {
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(max_cellHeight));
                }];
            }
            
        }else{
            // 选择类型，以titleLabel 和 detailLabel的实际高度更大的为准
            
            [self.detailLabel setNeedsLayout];
            [self.detailLabel layoutIfNeeded];
            [self.detailLabel sizeToFit];
            
            CGFloat detail_cellHeight = self.detailLabel.bounds.size.height + 30;
            max_cellHeight = MAX(max_cellHeight, detail_cellHeight);
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(max_cellHeight));
            }];
        }
    }

    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.model.value) { // 如果是用户自己设置的value就按用户自己设置的来
        if ([self.textField.text isEqualToString:@" "]) {
            self.textField.text = @"";
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
    
    self.model.value = self.textField.text;
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
