//
//  XYDatePickerView.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/21.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYDatePickerView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define WidthFromPt(value) ((value) * kScreenW / 375.0f)
#define HeightFromPt(value) ((value) * kScreenH / 667.0f)
#define toolBarHight 44
#define toolBarMargin 15
#define pickerHight HeightFromPt(200)
#define pickerAndToolBarHight (toolBarHight + pickerHight)
#define pickerAnimationDuration 0.25

typedef void(^XYDatePickerDoneBlock)(NSDate *choosenDate);

@interface XYDatePickerView ()

@property(nonatomic , strong)     UIView *toolBar;
@property(nonatomic , strong)     UIButton *cancelBtn;
@property(nonatomic , strong)     UIButton *doneBtn;
@property(nonatomic , strong)     UILabel *titleLabel;
@property(nonatomic , strong)     UIDatePicker *datePicker;

/** XYDatePickerDoneBlock 内部选中时间完成之后回调 */
@property (nonatomic, copy)         XYDatePickerDoneBlock doneBlock;

@end

@implementation XYDatePickerView

#pragma mark - lazy

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.frame = CGRectMake(0, kScreenH+toolBarHight, kScreenW, pickerHight);
        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
        _datePicker = datePicker;
    }
    return _datePicker;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        UIView *toolBar = [UIView new];
        toolBar.frame = CGRectMake(0, kScreenH, kScreenW, toolBarHight);
        toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _toolBar = toolBar;
        // 两条分割线
        UIView *line1 = [UIView new];
        line1.backgroundColor = UIColor.lightGrayColor;
        line1.frame = CGRectMake(0, 0, toolBar.frame.size.width, 0.5);
        [toolBar addSubview:line1];
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = UIColor.lightGrayColor;
        line2.frame = CGRectMake(0, toolBar.frame.size.height-0.5, toolBar.frame.size.width, 0.5);
        [toolBar addSubview:line2];
    }
    return _toolBar;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        CGFloat itemW = 40;
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        leftBtn.frame = CGRectMake(toolBarMargin, 0, itemW, toolBarHight);
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBar addSubview:leftBtn];
        _cancelBtn = leftBtn;
    }
    return _cancelBtn;
}

- (UIButton *)doneBtn
{
    if (!_doneBtn) {
        CGFloat itemW = 40;
        CGFloat rightBtnX = kScreenW - toolBarMargin - itemW;
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        rightBtn.frame = CGRectMake(rightBtnX, 0, itemW, toolBarHight);
        [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.toolBar addSubview:rightBtn];
        _doneBtn = rightBtn;
    }
    return _doneBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:20];
        [titleLabel sizeToFit];
        titleLabel.textColor = UIColor.grayColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.bounds = CGRectMake(0, 0, kScreenW - 2 * (toolBarMargin + 40), toolBarHight);
        titleLabel.center = CGPointMake(self.toolBar.center.x, self.toolBar.bounds.size.height/2);
        [self.toolBar addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupContent];
}

/*
    1. 创建 datePicker 的时候，同时设置 pickerModel
    2. 提供更多的配置信息，如最小/大时间，时间间隔
    3. 给 dataPicker 关联一个响应事件
    4. 设置 datePicker 的约束以便能正确的管理其位置
 */


- (void)setupContent{
    
    // 创建内容
    [self addSubview:self.datePicker];
    [self addSubview:self.toolBar];
    
    [self.toolBar addSubview:self.cancelBtn];
    [self.toolBar addSubview:self.doneBtn];
}

#pragma mark - setters

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    if (datePickerMode == UIDatePickerModeCountDownTimer)
        return;
    
    self.datePicker.datePickerMode = datePickerMode;
}

- (void)setDate:(NSDate *)date
{
    [self.datePicker setDate:date animated:YES];
}

- (void)setMinimumDate:(NSDate *)minimumDate
{
    self.datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate
{
    self.datePicker.maximumDate = maximumDate;
}

- (void)setMinuteInterval:(NSInteger)minuteInterval
{
    self.datePicker.minuteInterval = minuteInterval;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - private events

- (void)cancelBtnClick{
    
    [UIView animateWithDuration:pickerAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.toolBar.transform = CGAffineTransformIdentity;
        self.datePicker.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)doneBtnClick{
    
    // 确定选中的时间，返回给调用者
    
    NSDate *choosenDate = self.datePicker.date;

    // 选择完成，返回对应的选择结果
    if(self.doneBlock){
        self.doneBlock(choosenDate);
    }

    [self cancelBtnClick];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelBtnClick];
}


#pragma mark - public events

+ (instancetype)datePicker{
    XYDatePickerView *datePicker = [XYDatePickerView new];
    datePicker.frame = [UIScreen mainScreen].bounds;
    return datePicker;
}

- (void)show{
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:pickerAnimationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        self.toolBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -pickerAndToolBarHight);
        self.datePicker.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -pickerAndToolBarHight);
    }];
}

+ (instancetype)showDatePickerWithConfig:(void (^)(XYDatePickerView * _Nonnull))config result:(void (^)(NSDate * _Nonnull))result
{
    XYDatePickerView *datePicker = [XYDatePickerView datePicker];
    if (config) {
        config(datePicker);
    }
    datePicker.doneBlock = result;
    [datePicker show];
    return datePicker;
}


- (void)dealloc
{
    NSLog(@"%@--%s",self,_cmd);
}



@end
