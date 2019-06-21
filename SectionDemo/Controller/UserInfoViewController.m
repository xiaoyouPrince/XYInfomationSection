//
//  UserInfoViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/20.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

/** 数据 */
@property(nonatomic , strong)     UserModel *userDetailInfo;

@property (nonatomic, strong) UIScrollView  *scrollView;

@end


@implementation UserInfoViewController
@dynamic scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    [self buildUI];
    
    
//    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    self.headerView = bu;
}

- (void)buildUI{
    
    self.userDetailInfo = [DataTool userModel];
    
    XYInfomationSection *section = [XYInfomationSection new];
    XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"姓名" titleKey:@"empName" type:0 value:self.userDetailInfo.empName placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item2 = [XYInfomationItem modelWithTitle:@"性别" titleKey:@"sex" type:0 value:self.userDetailInfo.sex placeholderValue:nil disableUserAction:YES];
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
    XYInfomationItem *item3 = [XYInfomationItem modelWithTitle:@"年龄" titleKey:@"age" type:0 value:nil /*ageStr*/ placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item4 = [XYInfomationItem modelWithTitle:@"婚姻状况" titleKey:@"marStatus" type:1 value:self.userDetailInfo.marStatus placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item5 = [XYInfomationItem modelWithTitle:@"民族" titleKey:@"nation" type:1 value:self.userDetailInfo.nation placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item6 = [XYInfomationItem modelWithTitle:@"学历" titleKey:@"highDegree" type:1 value:self.userDetailInfo.highDegree placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item7 = [XYInfomationItem modelWithTitle:@"政治面貌" titleKey:@"poliLan" type:1 value:self.userDetailInfo.poliLan placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item8 = [XYInfomationItem modelWithTitle:@"证件类型" titleKey:@"cerType" type:0 value:self.userDetailInfo.cerType placeholderValue:nil disableUserAction:YES];
    item8.valueCode = self.userDetailInfo.cerTypeCode;
    XYInfomationItem *item9 = [XYInfomationItem modelWithTitle:@"证件号码" titleKey:@"idCardNo" type:0 value:self.userDetailInfo.idCardNo placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item10 = [XYInfomationItem modelWithTitle:@"户口所在地" titleKey:@"householdAddr" type:0 value:self.userDetailInfo.householdAddr placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item11 = [XYInfomationItem modelWithTitle:@"现居住地" titleKey:@"conAddr" type:0 value:self.userDetailInfo.conAddr placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item12 = [XYInfomationItem modelWithTitle:@"邮政编码" titleKey:@"homePostalcode" type:0 value:self.userDetailInfo.homePostalcode placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item13 = [XYInfomationItem modelWithTitle:@"联系方式联系方式联系方式" titleKey:@"conType" type:1 value:@"单纯使用XYInfomationSection自己处理内部布局" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item14 = [XYInfomationItem modelWithTitle:@"联系号码" titleKey:@"conTel" type:0 value:self.userDetailInfo.conTel placeholderValue:nil disableUserAction:NO];
    section.dataArray = @[item,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12,item13,item14];
//    [_scrollView addSubview:section];
//    [self.view addSubview:section];
    
//    [section setNeedsLayout];
//    [section layoutIfNeeded];
    
//    self.headerView = section;
    
    [self setHeaderView:section edgeInsets:UIEdgeInsetsMake(10, 20, 20, 20)];

    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        NSLog(@"index = %ld",index);
    };
    
//    return;
    
//    [section mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(100);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//    }];
    
    // 设置第二组
    XYInfomationSection *section2 = [XYInfomationSection new];
    XYInfomationItem *item21 = [XYInfomationItem modelWithTitle:@"所属公司" titleKey:@"custName" type:0 value:self.userDetailInfo.custName placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item22 = [XYInfomationItem modelWithTitle:@"所属业务部" titleKey:@"ywName" type:0 value:self.userDetailInfo.ywName placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item23 = [XYInfomationItem modelWithTitle:@"所属业务员" titleKey:@"userName" type:0 value:self.userDetailInfo.userName placeholderValue:nil disableUserAction:YES];
    section2.dataArray = @[item21,item22,item23];
//    [self.view addSubview:section2];
//    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(section.mas_bottom).offset(15);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        //        make.bottom.equalTo(_scrollView.mas_bottom);
//    }];
    
//    [section2 setNeedsLayout];
//    [section2 layoutIfNeeded];
    
    [self setContentView:section2 edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    // 手动修改一下scrollView.contentSize
//    [self autoresizeScrollViewContentSize];
    
    // cell 的点击回调
//    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
//        [self section:section didSelectCell:cell];
//    };
    
//    [section mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(100);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//        //        make.left.equalTo(self.view).offset(0);
//        //        make.right.equalTo(self.view).offset(-0);
//    }];
}


- (void)section:(XYInfomationSection *)section didSelectCell:(XYInfomationCell *)cell{
    
}


@end
