//
//  FamilyMemberListViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/25.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "FamilyMemberListViewController.h"

@interface FamilyMemberListViewController ()

/** section 信息输入项 */
@property (nonatomic, strong)       XYInfomationSection *section;
/** 确认按钮 */
@property (nonatomic, strong)       UIButton *saveBtn;

@end

@implementation FamilyMemberListViewController

#pragma mark - lazyload

- (XYInfomationSection *)section
{
    if (!_section) {
        XYInfomationSection *section = [XYInfomationSection new];
        _section = section;
        
        XYInfomationItem *item1 = [XYInfomationItem modelWithTitle:@"姓名" titleKey:@"memberName" type:0 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item2 = [XYInfomationItem modelWithTitle:@"用户性别" titleKey:@"memberSex" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item3 = [XYInfomationItem modelWithTitle:@"证件类型" titleKey:@"sfzjlx" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item4 = [XYInfomationItem modelWithTitle:@"证件号码" titleKey:@"memberIdCardNo" type:0 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item5 = [XYInfomationItem modelWithTitle:@"出生日期" titleKey:@"memberBirthDate" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item6 = [XYInfomationItem modelWithTitle:@"与本人关系" titleKey:@"relationShip" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item7 = [XYInfomationItem modelWithTitle:@"备注信息埃菲尔无法哈维和我哈我改噶范围发哈哈尬舞个 乏味和欧发我个" titleKey:@"other" type:XYInfoCellTypeTextView value:nil placeholderValue:nil disableUserAction:NO];
        item7.cellHeight = 150;
        
        section.dataArray = @[item1,item2,item3,item4,item5,item6,item7];
        __weak typeof(self) weakSelf = self;
        section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        };
        
        // 监听出生日期，如果身份类型:身份证，身份证号码为正确的身份证号--->自动输入出生日期
        [item4 addObserver:weakSelf forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _section;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([[object valueForKey:@"titleKey"] isEqualToString:@"memberIdCardNo"]) {
        
        // 最新输入的身份证号
        NSString *value = change[NSKeyValueChangeNewKey];
        
        // 证件类型
        XYInfomationItem *item = self.section.dataArray[2];
        if ([value isIDCard] && [item.valueCode isEqualToString:@"1"]) {
            
            NSString *birthday = [value birthdayFromIDCard];
                    
            XYInfomationItem *item = self.section.dataArray[4];
            item.value = birthday;
            item.valueCode = birthday;
            XYInfomationCell *cell = [self.section.subviews objectAtIndex:4];
            cell.model = item;
        }else
        {
            XYInfomationItem *item = self.section.dataArray[4];
            item.value = nil;
            item.valueCode = nil;
            XYInfomationCell *cell = [self.section.subviews objectAtIndex:4];
            cell.model = item;
        }
    }
    
    
}

- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:saveBtn];
        saveBtn.frame = CGRectMake(0, 0, 300, 40);
        _saveBtn = saveBtn;
        
        // 设置保存按钮背景渐变色
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        NSArray *colors = @[(id)[HEXCOLOR(0xf44b42) CGColor],(id)[HEXCOLOR(0xd8261d) CGColor]];
        [gradientLayer setColors:colors];//渐变数组
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            gradientLayer.frame = saveBtn.bounds;
            [saveBtn.layer insertSublayer:gradientLayer atIndex:0];
            saveBtn.layer.cornerRadius = 10;
            saveBtn.clipsToBounds = YES;
            [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        });
        
        [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}


#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    /*
     结构：上面输入内容 + 下面确定按钮
     */
    
    // 1.添加内容组
    [self setHeaderView:self.section edgeInsets:UIEdgeInsetsMake(20, 15, 30, 15)];

    // 2. 确定按钮
    [self setFooterView:self.saveBtn edgeInsets:UIEdgeInsetsMake(0, 50, 50, 50)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 移除证件号码监听
    for (XYInfomationItem *item in self.section.dataArray) {
        if ([item.titleKey isEqualToString:@"memberIdCardNo"]) {
            [item removeObserver:self forKeyPath:@"value"];
        }
    }
}

#pragma mark - actions

- (void)saveBtnClick:(id)sender{
    
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"所选内容:\n %@",_section.contentKeyValues.description]];
    
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


#pragma XYPickerView 处理

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
    NSLog(@"%@--%s",self,_cmd);
}
@end
