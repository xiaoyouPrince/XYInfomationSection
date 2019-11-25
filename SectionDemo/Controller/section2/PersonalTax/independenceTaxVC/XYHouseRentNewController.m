//
//  XYHouseRentNewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYHouseRentNewController.h"

@interface XYHouseRentNewController ()
/** section 信息输入项 */
@property (nonatomic, strong)       UIView *myContentView;
@end

@implementation XYHouseRentNewController

/// 子女信息数据
- (NSArray <XYInfomationItem *>*)zinvInfos{
    
    // 1. 配偶信息
    NSArray *childInfos = @[
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
                              @"detail" : @"请输入证件号码"
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


/// 租房信息数据
- (NSArray <XYInfomationItem *>*)zufangInfos{
    
    // 1. 配偶信息
    NSArray *childInfos = @[
                          @{
                              @"title" : @"工作城市",
                              @"titleKey" : @"gzcs",
                              @"type" : @"1",
                              @"detail" : @"请选择工作城市(省市)"
                              },
                          @{
                              @"title" : @"出租方类型",
                              @"titleKey" : @"czflx",
                              @"type" : @"1",
                              @"detail" : @""
                              },
                          @{
                              @"title" : @"出租方名称", // 企业类型 ： 单位名称
                              @"titleKey" : @"czrxm",
                              @"type" : @"0",
                              @"detail" : @"选填"
                              },
                          @{
                              @"title" : @"出租方证件类型",
                              @"titleKey" : @"czrsfzjlx",
                              @"type" : @"1",
                              @"detail" : @"选填"  // 选填
                              },
                          @{
                              @"title" : @"出租方证件号码", // 企业类型 ： 社会统一信用代码
                              @"titleKey" : @"czrsfzjhm",
                              @"type" : @"0",
                              @"detail" : @"选填"
                              },
                          @{
                              @"title" : @"住房租赁合同编号",
                              @"titleKey" : @"zfzlhtbh",
                              @"type" : @"0",
                              @"detail" : @"选填"
                              },
                          @{
                              @"title" : @"房屋地址",
                              @"titleKey" : @"fwdz",
                              @"type" : @"1",
                              @"detail" : @"请选择省市区"
                              },
                          @{
                              @"title" : @"房屋详细地址",
                              @"titleKey" : @"jzdxxdz",
                              @"type" : @"0",
                              @"detail" : @"请输入街道,小区,楼栋,单元室等"
                              },
                          @{
                              @"title" : @"租赁日期起",
                              @"titleKey" : @"zlrqq",
                              @"type" : @"1",
                              @"detail" : @"请选择开始时间" // 不可大于系统当前日期
                              },
                          @{
                              @"title" : @"租赁日期止",
                              @"titleKey" : @"zlrqz",
                              @"type" : @"1",
                              @"detail" : @"请选择结束时间"  // 不可小于租赁日期起日期
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
        XYTaxBaseTaxinfoSection *taxInfo = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_peiou" title:@"配偶信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [self sectionCellClicked:cell];
        }];
        XYTaxBaseTaxinfoSection *taxInfo2 = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_zufang" title:@"租房信息" infoItems:[self zinvInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [self sectionCellClicked:cell];
        }];
        
        [_myContentView addSubview:taxInfo];
        [_myContentView addSubview:taxInfo2];
        
        [taxInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_myContentView).offset(15);
            make.left.equalTo(_myContentView).offset(0);
            make.right.equalTo(_myContentView).offset(-0);
        }];
        
        [taxInfo2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(taxInfo.mas_bottom).offset(15);
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
