//
//  XYPickerView.m
//  XYPickerViewDemo
//
//  Created by 渠晓友 on 2018/10/31.
//  Copyright © 2018年 渠晓友. All rights reserved.
//

#import "XYPickerView.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define WidthFromPt(value) ((value) * kScreenW / 375.0f)
#define HeightFromPt(value) ((value) * kScreenH / 667.0f)
#define toolBarHight 44
#define toolBarMargin 15
#define pickerHight HeightFromPt(200)
#define pickerAndToolBarHight (toolBarHight + pickerHight)
#define pickerAnimationDuration 0.25

@implementation XYPickerViewItem
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
    return [NSString stringWithFormat:@"\n{\n\ttitle : %@\n\tcode : %@\n}",self.title,self.code];
}
@end

@interface XYPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic , strong)     UIView *toolBar;
@property(nonatomic , strong)     UIButton *cancelBtn;
@property(nonatomic , strong)     UIButton *doneBtn;
@property(nonatomic , strong)     UILabel *titleLabel;
@property(nonatomic , strong)     UIPickerView *pickerView;

@property(nonatomic , strong)    NSIndexPath *selectedIndexPath;

@end

@implementation XYPickerView

#pragma mark - lazy

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.frame = CGRectMake(0, kScreenH+toolBarHight, kScreenW, pickerHight);
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        _pickerView = pickerView;
    }
    return _pickerView;
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
        titleLabel.font = [UIFont systemFontOfSize:15];
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


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}


- (void)setupContent{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.pickerView];
    
    // toolBar
    [self addSubview:self.toolBar];
    
    // toolbarContent leftItem  titleView  rightItem
    [self.toolBar addSubview:self.cancelBtn];
    [self.toolBar addSubview:self.doneBtn];
}

#pragma mark - setters

- (void)setDataArray:(NSArray *)dataArray
{
    for (id model in dataArray) {
        if (![model isKindOfClass:XYPickerViewItem.class]) {
            NSException *exp = [NSException exceptionWithName:@"数据错误" reason:@"XYPickerView数据源类型必须为XYPickerViewItem" userInfo:nil];
            [exp raise];
        }
    }
    
    // 赋值
    _dataArray = dataArray;
}

- (void)setToolBarBgColor:(UIColor *)toolBarBgColor
{
    _toolBarBgColor = toolBarBgColor;
    
    self.toolBar.backgroundColor = toolBarBgColor;
}



- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
}

- (void)setCancelTitle:(NSString *)cancelTitle
{
    _cancelTitle = cancelTitle;
    
    [self.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
}


- (void)setCancelTitleColor:(UIColor *)cancelTitleColor
{
    _cancelTitleColor = cancelTitleColor;
    
    [self.cancelBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
}

- (void)setDoneTitle:(NSString *)doneTitle
{
    _doneTitle = doneTitle;
    
    [self.doneBtn setTitle:doneTitle forState:UIControlStateNormal];
}

- (void)setDoneTitleColor:(UIColor *)doneTitleColor
{
    _doneTitleColor = doneTitleColor;
    
    [self.doneBtn setTitleColor:doneTitleColor forState:UIControlStateNormal];
}

- (void)setPickerBgColor:(UIColor *)pickerBgColor
{
    _pickerBgColor = pickerBgColor;
    
    self.pickerView.backgroundColor = pickerBgColor;
}


#pragma mark - private events

- (void)cancelBtnClick{
    
    [UIView animateWithDuration:pickerAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.toolBar.transform = CGAffineTransformIdentity;
        self.pickerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)doneBtnClick{
    
    XYPickerViewItem *selectedItem = self.dataArray[self.selectedIndexPath.row];
        
    // 选择完成，返回对应的选择结果
    if(self.doneBlock){
        self.doneBlock(selectedItem);
    }
    
    [self cancelBtnClick];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelBtnClick];
}


#pragma mark - pickerData
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    XYPickerViewItem *item = self.dataArray[row];
    return item.title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:component];
}

#pragma mark - public events

+ (instancetype)picker{
    XYPickerView *picker = [XYPickerView new];
    picker.frame = [UIScreen mainScreen].bounds;
    return picker;
}

- (void)showPicker{
    
    // 展示必须有数据
    if (self.dataArray.count == 0) {
        NSException *exp = [NSException exceptionWithName:@"数据错误" reason:@"XYPickerView数据源内容为空" userInfo:nil];
        [exp raise];
    }
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    
    if (self.defaultSelectedRow) {
        [self.pickerView selectRow:self.defaultSelectedRow inComponent:0 animated:YES];
        self.selectedIndexPath = [NSIndexPath indexPathForRow:self.defaultSelectedRow inSection:0];
    }
    
    [UIView animateWithDuration:pickerAnimationDuration animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        self.toolBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -pickerAndToolBarHight);
        self.pickerView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -pickerAndToolBarHight);
    }];
}

+ (instancetype)showPickerWithConfig:(void(^)(XYPickerView *picker))config result:(DoneBtnClickBlcok)result
{
    XYPickerView *picker = [XYPickerView picker];
    if (config) {
        config(picker);
    }
    picker.doneBlock = result;
    [picker showPicker];
    return picker;
}


- (void)dealloc
{
    NSLog(@"%@--%s",self,_cmd);
}


@end
