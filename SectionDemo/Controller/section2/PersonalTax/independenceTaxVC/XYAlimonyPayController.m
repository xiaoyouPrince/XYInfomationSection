//
//  XYAlimonyPayController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYAlimonyPayController.h"

@interface XYAlimonyPayController ()
/** section 信息输入项 */
@property (nonatomic, strong)       UIView *myContentView;
@end

@implementation XYAlimonyPayController

/// 子女信息数据
- (NSArray <XYInfomationItem *>*)zinvInfos{
    
    // 0. 子女信息
    NSArray *childInfos = @[
                            @{
                                @"title" : @"纳税人身份",
                                @"titleKey" : @"nsrsf",
                                @"type" : @"1",
                                @"detail" : @""
                                },
                            @{
                                @"title" : @"分摊方式",
                                @"titleKey" : @"ftfs",
                                @"type" : @"1",
                                @"detail" : @""
                                },
                            @{
                                @"title" : @"本年度月扣除金额",
                                @"titleKey" : @"ftje",
                                @"type" : @"0",
                                @"detail" : @""
                                }
                            ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in childInfos) {
        NSString *value = nil;
        if ([dict[@"detail"] length]) {
            value = dict[@"detail"];
        }
        XYInfomationItem *item = [XYInfomationItem modelWithTitle:dict[@"title"] titleKey:dict[@"titleKey"] type:[dict[@"type"] integerValue] value:value placeholderValue:nil disableUserAction:NO];
        [arrayM addObject:item];
    }
    
    return arrayM;
}

/// 赡养人信息数据
- (NSArray <XYInfomationItem *>*)beishanyangrenInfos{
    
    // 0. 子女信息
    NSArray *childInfos = @[
                            @{
                                @"title" : @"被赡养人姓名",
                                @"titleKey" : @"xm",
                                @"type" : @"0",
                                @"detail" : @"请输入姓名"
                                },
                            @{
                                @"title" : @"被赡养人证件类型",
                                @"titleKey" : @"sfzjlx",
                                @"type" : @"1",
                                @"detail" : @"居民身份证"
                                },
                            @{
                                @"title" : @"被赡养人证件号码",
                                @"titleKey" : @"sfzjhm",
                                @"type" : @"0",
                                @"detail" : @"请输入证件号码"
                                },
                            @{
                                @"title" : @"被赡养人出生日期",
                                @"titleKey" : @"csrq",
                                @"type" : @"1",
                                @"detail" : @"请选择出生日期"
                                },
                            @{
                                @"title" : @"被赡养人国籍",
                                @"titleKey" : @"gjhdqsz",
                                @"type" : @"1",
                                @"detail" : @"中国"
                                },
                            @{
                                @"title" : @"与员工关系",
                                @"titleKey" : @"ynsrgx",
                                @"type" : @"1",
                                @"detail" : @""
                                }
                            ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in childInfos) {
        NSString *value = nil;
        if ([dict[@"detail"] length]) {
            value = dict[@"detail"];
        }
        XYInfomationItem *item = [XYInfomationItem modelWithTitle:dict[@"title"] titleKey:dict[@"titleKey"] type:[dict[@"type"] integerValue] value:value placeholderValue:nil disableUserAction:NO];
        [arrayM addObject:item];
    }
    
    return arrayM;
}

/// 共同赡养人信息数据
- (NSArray <XYInfomationItem *>*)gontongInfos{
    
    // 0. 子女信息
    NSArray *childInfos = @[
                            @{
                                @"title" : @"共同赡养人姓名",
                                @"titleKey" : @"xm",
                                @"type" : @"0",
                                @"detail" : @"请输入姓名"
                                },
                            @{
                                @"title" : @"共同赡养人证件类型",
                                @"titleKey" : @"sfzjlx",
                                @"type" : @"1",
                                @"detail" : @"居民身份证"
                                },
                            @{
                                @"title" : @"共同赡养人证件号码",
                                @"titleKey" : @"sfzjhm",
                                @"type" : @"0",
                                @"detail" : @"请输入证件号码"
                                },
                            @{
                                @"title" : @"共同赡养人出生日期",
                                @"titleKey" : @"csrq",
                                @"type" : @"1",
                                @"detail" : @"请选择出生日期"
                                },
                            @{
                                @"title" : @"共同赡养人国籍",
                                @"titleKey" : @"gjhdqsz",
                                @"type" : @"1",
                                @"detail" : @"中国"  // 大于 0 的整数
                                },
                            @{
                                @"title" : @"与员工关系",
                                @"titleKey" : @"ynsrgx",
                                @"type" : @"1",
                                @"detail" : @""
                                }
                            ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in childInfos) {
        NSString *value = nil;
        if ([dict[@"detail"] length]) {
            value = dict[@"detail"];
        }
        XYInfomationItem *item = [XYInfomationItem modelWithTitle:dict[@"title"] titleKey:dict[@"titleKey"] type:[dict[@"type"] integerValue] value:value placeholderValue:nil disableUserAction:NO];
        [arrayM addObject:item];
    }
    
    return arrayM;
}

#pragma mark - LazyLoad properties

// 内容有: 子女信息,配偶信息,教育信息

- (UIView *)myContentView
{
    if (!_myContentView) {
        
        _myContentView = [UIView new];
        __weak typeof(self) weakSelf = self;
        
        // 2.
        XYTaxBaseTaxinfoSection *taxInfo = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_zinv" title:@"纳税人信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        }];
        // 默认值展示纳税人类型 index = 0
        XYInfomationSection *typeSection = taxInfo.subviews.lastObject;
        [typeSection foldCellWithoutIndexs:@[@0]];
        
        
        XYTaxBaseTaxinfoSection *taxInfo2 = [XYTaxBaseTaxinfoSection taxSectionCanAddWithImage:@"icon_tax_profile" title:@"被赡养人信息" infoItems:[self beishanyangrenInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        }];
        XYTaxBaseTaxinfoSection *taxInfo3 = [XYTaxBaseTaxinfoSection taxSectionCanAddWithImage:@"icon_tax_profile" title:@"共同赡养人信息" infoItems:[self gontongInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        }];
        
        [_myContentView addSubview:taxInfo];
        [_myContentView addSubview:taxInfo2];
        [_myContentView addSubview:taxInfo3];
        
        [taxInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_myContentView).offset(15);
            make.left.equalTo(_myContentView).offset(0);
            make.right.equalTo(_myContentView).offset(-0);
        }];
        
        [taxInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(taxInfo.mas_bottom).offset(15);
            make.left.equalTo(_myContentView).offset(0);
            make.right.equalTo(_myContentView).offset(-0);
        }];
        
        [taxInfo3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(taxInfo2.mas_bottom).offset(15);
            make.left.equalTo(_myContentView).offset(0);
            make.right.equalTo(_myContentView).offset(-0);
            make.bottom.equalTo(_myContentView);
        }];
    }
    return _myContentView;
}


#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 填充内容
    [self setContentView:self.myContentView];
    
    // 默认共同赡养人不展示
    XYTaxBaseTaxinfoSection *beiSection = _myContentView.subviews[1];
    XYTaxBaseTaxinfoSection *gtSection = _myContentView.subviews.lastObject;
    gtSection.hidden = YES;
    [gtSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(beiSection.mas_bottom).offset(0);
        make.bottom.equalTo(gtSection.mas_top).offset(0);
    }];
    
    // 添加监听 - 纳税人类型（是否为独生子）
    XYTaxBaseTaxinfoSection *typeSection = [_myContentView.subviews firstObject];
    
    // 配偶监听是否有配偶，没有配偶隐藏项目内其剩余他项目
    // 配偶监听出生日期，如果身份类型:身份证，身份证号码为正确的身份证号--->自动输入出生日期
    XYInfomationItem *poHas = typeSection.cellsArray[0].model;
    [poHas addObserver:self forKeyPath:@"valueCode" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    // 1. 纳税人身份 1.独生子，2.非独生子
    if ([[object valueForKey:@"titleKey"] isEqualToString:@"nsrsf"]) {
        
        // 选择身份类型
        NSString *value = change[NSKeyValueChangeNewKey];
        
        XYTaxBaseTaxinfoSection *poSection = [_myContentView.subviews objectAtIndex:0];
        XYInfomationSection *section = [poSection.subviews lastObject];
        
        // 是否为独生子女
        XYInfomationItem *item = poSection.cellsArray[0].model;
        if ( value && [item.valueCode isEqualToString:@"1"]) {
            
            // 独生子 - 展示分摊比例，全部由我承担..隐藏分本年度金额
            XYInfomationItem *item1 = poSection.cellsArray[1].model;
            item1.title = @"分摊比例";
            item1.value = @"全部由我扣除";
            item1.disableTouchGuesture = YES;
            
            [section foldCellWithIndexs:@[@2]];
            
            // 隐藏共同赡养人组
            XYTaxBaseTaxinfoSection *gtSection = [_myContentView.subviews lastObject];
            XYTaxBaseTaxinfoSection *beiSection = [_myContentView.subviews objectAtIndex:1];
            gtSection.hidden = YES;
            
            // 隐藏
            [gtSection mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(beiSection.mas_bottom).offset(0);
                make.bottom.equalTo(gtSection.mas_top).offset(0);
            }];
            
        }else
        {
            // 非独生子
            XYInfomationItem *item1 = poSection.cellsArray[1].model;
            item1.title = @"分摊方式";
            item1.value = nil;
            item1.disableTouchGuesture = NO;
            
            [section unfoldAllCells];
            
            // 展示共同赡养人组
            XYTaxBaseTaxinfoSection *gtSection = [_myContentView.subviews lastObject];
            XYTaxBaseTaxinfoSection *beiSection = [_myContentView.subviews objectAtIndex:1];
            gtSection.hidden = NO;
            
            // 移除之前约束
            [gtSection mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(beiSection.mas_bottom).offset(15);
                make.left.equalTo(_myContentView).offset(0);
                make.right.equalTo(_myContentView).offset(-0);
                make.bottom.equalTo(_myContentView);
            }];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 移除监听
    XYTaxBaseTaxinfoSection *poSection = [_myContentView.subviews firstObject];
    
    // 配偶监听是否有配偶，没有配偶隐藏项目内其剩余他项目
    // 配偶监听出生日期，如果身份类型:身份证，身份证号码为正确的身份证号--->自动输入出生日期
    XYInfomationItem *poHas = poSection.cellsArray[0].model;
    [poHas removeObserver:self forKeyPath:@"valueCode"];
}


#pragma mark - publicMethods

- (void)ensureBtnClick
{
    NSLog(@"实现父类的点击确定按钮页面。。。。。。。。%@",self);
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (XYInfomationSection *section in [self allSections]) {
        [arrayM addObject:section.contentKeyValues];
    }
    
    NSString *content = [NSString stringWithFormat:@"%@",arrayM];
    [[[UIAlertView alloc] initWithTitle:@"所填选内容" message:content delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
}

- (void)sectionCellClicked:(XYInfomationCell *)cell{

    if (cell.model.type == XYInfoCellTypeChoose) {
        
        // 处理要请求何种数据picker / datePicker / location
        if ([cell.model.titleKey isEqualToString:@"csrq"]) {
            [self showDatePickerForCell:cell];
        }else
        {
            [self showPickerForCell:cell];
        }
    }
}

#pragma mark - XYPickerView 处理

- (void)showPickerForCell:(XYInfomationCell *)cell
{
    // 此处可以模拟比较耗时的数据请求,下面直接写到代码中了
    
    [XYPickerView showPickerWithConfig:^(XYPickerView * _Nonnull picker) {
       
        picker.dataArray = [DataTool dataArrayForKey:cell.model.titleKey];
        picker.title = [NSString stringWithFormat:@"选择%@",cell.model.title];
        
        // 可以自己设置默认选中行
        for (int i = 0; i < picker.dataArray.count; i++) {
            XYPickerViewItem *item = picker.dataArray[i];
            if ([item.title isEqualToString:cell.model.value]) {
                picker.defaultSelectedRow = i;
            }
        }
        
    } result:^(XYPickerViewItem * _Nonnull selectedItem) {
        NSLog(@"选择完成，结果为:%@",selectedItem);
        cell.model.value = selectedItem.title;
        cell.model.valueCode = selectedItem.code;
        cell.model = cell.model;
    }];
}

#pragma mark - XYDatePicker 处理

- (void)showDatePickerForCell:(XYInfomationCell *)cell{
    
    NSTimeInterval yearSecond = 365 * 24 * 60 * 60;
    [XYDatePickerView showDatePickerWithConfig:^(XYDatePickerView * _Nonnull datePicker) {
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow: -50 * yearSecond];
        datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow: -2 * yearSecond];
        datePicker.title = [@"选择" stringByAppendingString:cell.model.title];
        
        // 如果已经有选好的时间，默认展示对应的时间
        if ([cell.model.value isDateFromat]) {
            NSDateFormatter *mft = [NSDateFormatter new];
            mft.dateFormat = @"yyyy-MM-dd";
            NSDate *date = [mft dateFromString:cell.model.value];
            datePicker.date = date;
        }
        
    } result:^(NSDate * _Nonnull choosenDate) {
        
        NSLog(@"选择完成，结果为:%@",choosenDate);
        
        NSDateFormatter *mft = [NSDateFormatter new];
        mft.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [mft stringFromDate:choosenDate];
        
        NSLog(@"选择完成，结果为:%@",dateStr);
        cell.model.value = dateStr;
        cell.model.valueCode = dateStr;
        cell.model = cell.model;
    }];
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 移除KVO
    // [self removeObserver:self forKeyPath:@""];;
}


@end
