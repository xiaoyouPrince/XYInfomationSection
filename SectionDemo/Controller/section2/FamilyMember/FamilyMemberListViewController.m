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
        XYInfomationItem *item3 = [XYInfomationItem modelWithTitle:@"证件类型" titleKey:@"memberCardType" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item4 = [XYInfomationItem modelWithTitle:@"证件号码" titleKey:@"memberIdCardNo" type:0 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item5 = [XYInfomationItem modelWithTitle:@"出生日期" titleKey:@"memberBirthDate" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        XYInfomationItem *item6 = [XYInfomationItem modelWithTitle:@"与本人关系" titleKey:@"relationShip" type:1 value:nil placeholderValue:nil disableUserAction:NO];
        
        section.dataArray = @[item1,item2,item3,item4,item5,item6];
        __weak typeof(self) weakSelf = self;
        section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        };
    }
    return _section;
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

#pragma mark - actions

- (void)saveBtnClick:(id)sender{
    
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"所选内容:\n %@",_section.contentKeyValues.description]];
    
}

- (void)sectionCellClicked:(XYInfomationCell *)cell{
    
    if (cell.model.type == XYInfoCellTypeInput) {
        // 这里控制键盘弹出，能正常展示到 输入框的下面
        if (cell.model.disableUserAction) {
            [SVProgressHUD showSuccessWithStatus:@"此cell仅用于展示"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"弹出键盘，输入内容"];
        }
    }
    
    if (cell.model.type == XYInfoCellTypeChoose) {
        // 这里控制选择类型的cell,根据cell.model.titleKey去加载要展示的正确数据
        if (cell.model.disableUserAction) {
            [SVProgressHUD showSuccessWithStatus:@"此cell仅用于展示"];
        }else
        {
            // 请求对应选择项目的数据
            [XYPickerView showPickerWithConfig:^(XYPickerView * _Nonnull picker) {
               
                picker.dataArray = [DataTool dataArrayForKey:@""];
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
    }
}

@end
