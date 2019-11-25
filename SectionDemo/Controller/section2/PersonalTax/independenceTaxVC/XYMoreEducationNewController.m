//
//  XYMoreEducationNewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYMoreEducationNewController.h"

@interface XYMoreEducationNewController ()
/** section 信息输入项 */
@property (nonatomic, strong)       UIView *myContentView;
@end

@implementation XYMoreEducationNewController

/// 继续教育信息数据
- (NSArray <XYInfomationItem *>*)jxjyInfos{
    
    // 1. 继续教育信息
    NSArray *jxjyInfos = @[
                         @{
                             @"title" : @"继续教育类型",
                             @"titleKey" : @"jxjyqk",
                             @"type" : @"1",
                             @"detail" : @"请选择学历继续教育类型"
                             },
                         @{
                             @"title" : @"学历(学位)继续教育阶段",
                             @"titleKey" : @"xljxjyjd",
                             @"type" : @"1",
                             @"detail" : @""
                             },
                         @{
                             @"title" : @"入学时间",
                             @"titleKey" : @"rxsj",
                             @"type" : @"1",
                             @"detail" : @"请选择开始时间"
                             },
                         @{
                             @"title" : @"毕业时间(预计)", // 大于入学时间
                             @"titleKey" : @"yjbysj",
                             @"type" : @"1",
                             @"detail" : @"请选择预计毕业时间"
                             },
                         @{
                             @"title" : @"职业资格继续教育类型",
                             @"titleKey" : @"fxljxjylx",
                             @"type" : @"1",
                             @"detail" : @""
                             },
                         @{
                             @"title" : @"发证日期",
                             @"titleKey" : @"zsqdsj",
                             @"type" : @"1",
                             @"detail" : @"请选择发证日期"
                             },
                         @{
                             @"title" : @"证书名称",
                             @"titleKey" : @"zsmc",
                             @"type" : @"1",
                             @"detail" : @"请选择证书名称"
                             },
                         @{
                             @"title" : @"证书编号",
                             @"titleKey" : @"zsbh",
                             @"type" : @"0",
                             @"detail" : @"必填项"
                             },
                         @{
                             @"title" : @"发证机关",
                             @"titleKey" : @"fzjg",
                             @"type" : @"0",
                             @"detail" : @"请输入机关名称"
                             }
                         ];
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in jxjyInfos) {
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
        XYTaxBaseTaxinfoSection *taxInfo = [XYTaxBaseTaxinfoSection taxSectionWithImage:@"icon_tax_jiaoyu" title:@"教育信息" infoItems:[self jxjyInfos] handler:^(XYInfomationCell * _Nonnull cell) {
            [self sectionCellClicked:cell];
        }];
        
        [_myContentView addSubview:taxInfo];
        
        [taxInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_myContentView).offset(15);
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
