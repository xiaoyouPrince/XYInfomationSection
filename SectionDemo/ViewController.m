//
//  ViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import "XYInfomationSection.h"

// 此页面为菜单页面

@interface ViewController ()

/** 数据 */
@property(nonatomic , strong)     UserModel *userDetailInfo;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SectionDemo";
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.userDetailInfo = [DataTool userModel];
    
    XYInfomationSection *section = [XYInfomationSection new];
    XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"用户信息" titleKey:@"UserInfoViewController" type:1 value:@"单纯使用XYInfomationSection自己处理内部布局" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item2 = [XYInfomationItem modelWithTitle:@"个人中心" titleKey:@"UserCenterViewController" type:1 value:self.userDetailInfo.sex placeholderValue:nil disableUserAction:YES];
    // 年龄，没有对应参数，自己计算。
    NSString *birth = self.userDetailInfo.birthDate;
    NSString *ageStr;
    if (birth.length >= 4) {
        NSString *year = [birth substringWithRange:NSMakeRange(0, 4)];
        NSDate *date = [NSDate date];
        NSString *ty = [date stringWithFormat:@"yyyy"];
        int age = [ty intValue] - [year intValue];
        ageStr = [NSString stringWithFormat:@"%i",age];
    }
    XYInfomationItem *item3 = [XYInfomationItem modelWithTitle:@"设置页面" titleKey:@"SettingViewController" type:0 value:ageStr placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item4 = [XYInfomationItem modelWithTitle:@"增加家庭成员" titleKey:@"marStatus" type:1 value:self.userDetailInfo.marStatus placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item5 = [XYInfomationItem modelWithTitle:@"编辑家庭成员" titleKey:@"nation" type:0 value:self.userDetailInfo.nation placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item6 = [XYInfomationItem modelWithTitle:@"增加我的卡片" titleKey:@"marStatus" type:1 value:self.userDetailInfo.marStatus placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item7 = [XYInfomationItem modelWithTitle:@"编辑我的卡片" titleKey:@"nation" type:0 value:self.userDetailInfo.nation placeholderValue:nil disableUserAction:YES];
    
//    section.dataArray = @[item,item2,item3,item4,item5,item6,item7];
    [self.view addSubview:section];
    
//    section.backgroundColor = UIColor.greenColor;
//    section.clipsToBounds = NO;
//    section.layer.cornerRadius = 0;
    
    section.dataArray = @[item,item2,item3,item4,item5,item6,item7];
    
    [section mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(-0);
    }];
    
//    section.dataArray = @[item,item2,item3,item4,item5,item6,item7];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
//    section.dataArray = @[item,item2,item3,item4,item5,item6,item7];
    
    // 点击回调
    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        NSLog(@"index = %ld",index);
        
        UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
        detail.title = cell.model.title;
        [self.navigationController pushViewController:detail animated:YES];
    };
}


@end



