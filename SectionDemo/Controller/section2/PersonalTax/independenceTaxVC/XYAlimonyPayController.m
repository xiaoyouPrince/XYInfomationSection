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
        
        // 2.
        XYTaxBaseTaxinfoSection *taxInfo = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"" title:@"子女信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [self sectionCellClicked:cell];
        }];
        XYTaxBaseTaxinfoSection *taxInfo2 = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"" title:@"配偶信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [self sectionCellClicked:cell];
        }];
        XYTaxBaseTaxinfoSection *taxInfo3 = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"" title:@"受教育信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [self sectionCellClicked:cell];
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
    
    // 添加监听 - 出生日期 是否有配偶
    
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
        if ([cell.model.titleKey isEqualToString:@"memberBirthDate"]) {
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
        picker.title = @"选择城市";
        
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
