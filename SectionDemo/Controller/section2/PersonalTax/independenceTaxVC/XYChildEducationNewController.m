//
//  XYChildEducationNewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYChildEducationNewController.h"

@interface XYChildEducationNewController ()
/** section 信息输入项 */
@property (nonatomic, strong)       UIView *myContentView;
@end

@implementation XYChildEducationNewController

/// 子女信息数据
- (NSArray <XYInfomationItem *>*)zinvInfos{
    
    // 0. 子女信息
    NSArray *childInfos = @[
                            @{
                                @"title" : @"子女姓名",
                                @"titleKey" : @"xm",
                                @"type" : @"0",
                                @"detail" : @"请输入姓名"
                                },
                            @{
                                @"title" : @"子女证件类型",
                                @"titleKey" : @"sfzjlx",
                                @"type" : @"1",
                                @"detail" : @"居民身份证"
                                },
                            @{
                                @"title" : @"子女证件号码",
                                @"titleKey" : @"sfzjhm",
                                @"type" : @"0",
                                @"detail" : @"请输入证件号码"
                                },
                            @{
                                @"title" : @"子女出生日期",
                                @"titleKey" : @"csrq",
                                @"type" : @"1",
                                @"detail" : @"请选择出生日期"
                                },
                            @{
                                @"title" : @"子女国籍",
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
    
    return [self modelsArrayWithDictArr:childInfos];
}


/// 配偶信息数据
- (NSArray <XYInfomationItem *>*)mateInfos{
    
    // 0. 配偶信息
    NSArray *poInfos = @[
                            @{
                                @"title" : @"是否有配偶",
                                @"titleKey" : @"sfypo",
                                @"type" : @"1",
                                @"detail" : @""
                                },
                            @{
                                @"title" : @"配偶姓名",
                                @"titleKey" : @"nsrpoxm",
                                @"type" : @"0",
                                @"detail" : @"请输入姓名"
                                },
                            @{
                                @"title" : @"配偶证件类型",
                                @"titleKey" : @"nsrposfzjlx",
                                @"type" : @"1",
                                @"detail" : @"居民身份证"
                                },
                            @{
                                @"title" : @"配偶证件号码",
                                @"titleKey" : @"nsrposfzjhm",
                                @"type" : @"0",
                                @"detail" : @"请输入证件号码" // 选择身份证自带出生日期
                                },
                            @{
                                @"title" : @"配偶出生日期",
                                @"titleKey" : @"nsrpocsrq",
                                @"type" : @"1",
                                @"detail" : @"请选择出生日期"
                                },
                            @{
                                @"title" : @"配偶国籍",
                                @"titleKey" : @"nsrpogj",
                                @"type" : @"1",
                                @"detail" : @"中国"
                                }
                            ];
    
    return [self modelsArrayWithDictArr:poInfos];
}


/// 配偶信息数据
- (NSArray <XYInfomationItem *>*)eduInfos{
    
    // 受教育信息
    NSArray *eduInfos = @[
                         @{
                             @"title" : @"当前受教育阶段",
                             @"titleKey" : @"sjyjd",
                             @"type" : @"1",
                             @"detail" : @"请选择受教育阶段"
                             },
                         @{
                             @"title" : @"当前教育时间起",
                             @"titleKey" : @"sjyrqq",
                             @"type" : @"1",
                             @"detail" : @"请选择开始时间"
                             },
                         @{
                             @"title" : @"当前教育时间止",
                             @"titleKey" : @"yjbysj",
                             @"type" : @"1",
                             @"detail" : @"选填"
                             },
                         @{
                             @"title" : @"教育终止时间",
                             @"titleKey" : @"zjsjysj",
                             @"type" : @"1",
                             @"detail" : @"不再接受教育时填写"
                             },
                         @{
                             @"title" : @"就读国家（地区）",
                             @"titleKey" : @"jdgjhdqsz",
                             @"type" : @"1",
                             @"detail" : @"中国"
                             },
                         @{
                             @"title" : @"就读学校名称",
                             @"titleKey" : @"jdxx",
                             @"type" : @"0",
                             @"detail" : @""
                             },
                         @{
                             @"title" : @"分配比例",
                             @"titleKey" : @"fpbl",
                             @"type" : @"1",
                             @"detail" : @""
                             }
                         ];
    
    return [self modelsArrayWithDictArr:eduInfos];
}

/// 通过dict数据源返回model数据源
/// @param array 字典数据源
- (NSArray <XYInfomationItem *>*)modelsArrayWithDictArr:(NSArray *)array{
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        NSString *value = nil;
//        if ([dict[@"detail"] length]) {
//            value = dict[@"detail"];
//        }
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
        
        // 2.
        __weak typeof(self) weakSelf = self;
        XYTaxBaseTaxinfoSection *taxInfo = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_zinv" title:@"子女信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        }];
        XYTaxBaseTaxinfoSection *taxInfo2 = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_peiou" title:@"配偶信息" infoItems:[self mateInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        }];
        // 配偶默认只有选择是否有配偶
        XYInfomationSection *poSection = taxInfo2.subviews.lastObject;
        [poSection foldCellWithoutIndexs:@[@0]];
        
        XYTaxBaseTaxinfoSection *taxInfo3 = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_jiaoyu" title:@"受教育信息" infoItems:[self eduInfos] handler:^(XYInfomationCell * _Nonnull cell) {
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
    
    // 添加监听 - 子女出生日期 是否有配偶&配偶出生日期
    XYTaxBaseTaxinfoSection *znSection = [_myContentView.subviews firstObject];
    XYTaxBaseTaxinfoSection *poSection = [_myContentView.subviews objectAtIndex:1];
    
    // 子女监听出生日期，如果身份类型:身份证，身份证号码为正确的身份证号--->自动输入出生日期
    XYInfomationItem *znBirthdayModel = znSection.cellsArray[2].model;
    [znBirthdayModel addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    
    
    // 配偶监听是否有配偶，没有配偶隐藏项目内其剩余他项目
    // 配偶监听出生日期，如果身份类型:身份证，身份证号码为正确的身份证号--->自动输入出生日期
    XYInfomationItem *poHas = poSection.cellsArray[0].model;
    [poHas addObserver:self forKeyPath:@"valueCode" options:NSKeyValueObservingOptionNew context:nil];
    XYInfomationItem *poBirth = poSection.cellsArray[3].model;
    [poBirth addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    // 1. 子女出生日期-判断证件号码
    if ([[object valueForKey:@"titleKey"] isEqualToString:@"sfzjhm"]) {
        
        XYTaxBaseTaxinfoSection *znSection = [_myContentView.subviews firstObject];
        
        // 最新输入的身份证号
        NSString *value = change[NSKeyValueChangeNewKey];
        
        // 证件类型
        XYInfomationItem *item = znSection.cellsArray[1].model;
        if ([value isIDCard] && [item.valueCode isEqualToString:@"1"]) {
            
            NSString *birthday = [value birthdayFromIDCard];
                    
            XYInfomationItem *item = znSection.cellsArray[3].model;
            item.value = birthday;
            item.valueCode = birthday;
            XYInfomationCell *cell = znSection.cellsArray[3];
            cell.model = item;
        }else
        {
            XYInfomationItem *item = znSection.cellsArray[3].model;
            item.value = nil;
            item.valueCode = nil;
            XYInfomationCell *cell = znSection.cellsArray[3];
            cell.model = item;
        }
    }
    
    
    // 2. 是否有配偶
    if ([[object valueForKey:@"titleKey"] isEqualToString:@"sfypo"]) {
        
        // 选择是否有配偶
        NSString *value = change[NSKeyValueChangeNewKey];
        
        XYTaxBaseTaxinfoSection *poSection = [_myContentView.subviews objectAtIndex:1];
        XYInfomationSection *section = [poSection.subviews lastObject];
        
        // 是否有配偶
        XYInfomationItem *item = poSection.cellsArray[0].model;
        if ( value && [item.valueCode isEqualToString:@"2"]) {
            
            // 合并配偶项目
            [section foldCellWithoutIndexs:@[@0]];
        }else
        {
            // 展开配偶项目
            [section foldCellWithIndexs:@[]];
        }
    }
    
    
    // 3. 配偶出生日期-判断证件号码
    if ([[object valueForKey:@"titleKey"] isEqualToString:@"nsrposfzjhm"]) {
        
        // 最新输入的身份证号
        NSString *value = change[NSKeyValueChangeNewKey];
        
        XYTaxBaseTaxinfoSection *poSection = [_myContentView.subviews objectAtIndex:1];
        XYInfomationSection *section = [poSection.subviews lastObject];
        
        // 证件类型
        XYInfomationItem *item = section.dataArray[2];
        if ([value isIDCard] && [item.valueCode isEqualToString:@"1"]) {
            
            NSString *birthday = [value birthdayFromIDCard];
                    
            XYInfomationItem *item = section.dataArray[4];
            item.value = birthday;
            item.valueCode = birthday;
            XYInfomationCell *cell = [section.subviews objectAtIndex:4];
            cell.model = item;
        }else
        {
            XYInfomationItem *item = section.dataArray[4];
            item.value = nil;
            item.valueCode = nil;
            XYInfomationCell *cell = [section.subviews objectAtIndex:4];
            cell.model = item;
        }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 移除监听
    
    XYTaxBaseTaxinfoSection *znSection = [_myContentView.subviews firstObject];
    XYTaxBaseTaxinfoSection *poSection = [_myContentView.subviews objectAtIndex:1];
    // 1. 子女出生日期
    XYInfomationItem *znBirthdayModel = znSection.cellsArray[2].model;
    [znBirthdayModel removeObserver:self forKeyPath:@"value"];
    
    // 2. 是否有配偶，配偶出生日期
    XYInfomationItem *poHas = poSection.cellsArray[0].model;
    [poHas removeObserver:self forKeyPath:@"valueCode"];
    XYInfomationItem *poBirth = poSection.cellsArray[3].model;
    [poBirth removeObserver:self forKeyPath:@"value"];
}


#pragma mark - publicMethods

- (void)ensureBtnClick
{
    NSLog(@"实现父类的点击确定按钮页面。。。。。。。。%@",self);
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (XYInfomationSection *section in [self allSections]) {
        [arrayM addObject:section.contentKeyValues];
        
        // 1.进行参数校验,这里进行强检验，使用者可以根据
        for (XYInfomationItem *item in section.dataArray) {
            
            // 被【隐藏/折叠】的不校验
            if (item.isFold){
                continue;
            }
            
            // “remark” 作为选填key,忽略
            if ([item.titleKey isEqualToString:@"remark"]) {
                continue;
            }
            
            // 对内容进行匹配
            if (item.type == XYInfoCellTypeInput && !item.value.length) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入%@",item.title]];
                return;
            }
            
            // 对内容进行匹配
            if (item.type == XYInfoCellTypeChoose && !item.valueCode.length) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请选择%@",item.title]];
                return;
            }
        }
    }
    
    NSString *content = [NSString stringWithFormat:@"%@",arrayM];
    [[[UIAlertView alloc] initWithTitle:@"所填选内容" message:content delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
}

- (void)sectionCellClicked:(XYInfomationCell *)cell{

    if (cell.model.type == XYInfoCellTypeChoose) {
        
        // 处理要请求何种数据picker / datePicker / location
        if ([cell.model.titleKey isEqualToString:@"csrq"] ||
            [cell.model.titleKey isEqualToString:@"nsrpocsrq"] ||
            [cell.model.titleKey isEqualToString:@"sjyrqq"] ||
            [cell.model.titleKey isEqualToString:@"yjbysj"] ||
            [cell.model.titleKey isEqualToString:@"zjsjysj"]
            ) {// 出生日期 & 受教育起止时间等
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
        picker.title = [NSString stringWithFormat:@"请选择%@",cell.model.title];
        
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
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 移除KVO
    // [self removeObserver:self forKeyPath:@""];;
}





@end
