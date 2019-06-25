//
//  ViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import "XYInfomationSection.h"

// 此页面为菜单列表页面
/**
 section1 基本使用(一个页面之内)
    -> 只使用 XYInfomationSection
        section 1.1 -> 只有选择类型(无图和accessoryView)
        section 1.2 -> 只有输入类型(无图和accessoryView)
        section 1.3 -> 选择&输入类型(无图和accessoryView)
        section 1.4 -> 选择&输入类型(有图和accessoryView)
        section 1.5 -> 选择&输入&禁用类型(仅供展示)
 
 section2 高级使用举例
     -> 继承自 XYInfomationBaseViewController
         section 2.1 -> 个人中心页面
         section 2.2 -> 用户详细信息页面
         section 2.3 -> 设置页面
 
 section3 综合实例
     -> 继承自 XYInfomationBaseViewController
         section 3.1 -> 添加家庭成员信息
         section 3.2 -> 个人所得税
 */

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
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"基本使用";
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"高级使用举例";
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"综合使用";
    
    XYInfomationSection *section1 = [XYInfomationSection new];
    XYInfomationSection *section2 = [XYInfomationSection new];
    XYInfomationSection *section3 = [XYInfomationSection new];
    XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"基本使用" titleKey:@"BaseUseViewController" type:1 value:@"仅使用XYInfomationSection,自己处理页面内部布局" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item1 = [XYInfomationItem modelWithTitle:@"用户信息" titleKey:@"UserInfoViewController" type:1 value:@"单纯使用XYInfomationSection自己处理内部布局" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item2 = [XYInfomationItem modelWithTitle:@"个人中心" titleKey:@"UserCenterViewController" type:1 value:self.userDetailInfo.sex placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item3 = [XYInfomationItem modelWithTitle:@"设置页面" titleKey:@"SettingViewController" type:0 value:@"34" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item4 = [XYInfomationItem modelWithTitle:@"增加家庭成员" titleKey:@"marStatus" type:1 value:self.userDetailInfo.marStatus placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item5 = [XYInfomationItem modelWithTitle:@"编辑家庭成员" titleKey:@"nation" type:0 value:self.userDetailInfo.nation placeholderValue:nil disableUserAction:YES];
    
    section1.dataArray = @[item];
    section2.dataArray = @[item1,item2,item3];
    section3.dataArray = @[item4,item5];
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    [self.view addSubview:section1];
    [self.view addSubview:section2];
    [self.view addSubview:section3];
    
    CGFloat margin = 15;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(2*margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section2.mas_bottom).offset(2*margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    // 点击回调
    NSArray *sections = @[section1,section2,section3];
    for (XYInfomationSection *section in sections) {
        section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
            NSLog(@"index = %ld",index);
            [self didClickInfoCell:cell];
        };
    }
}

- (void)didClickInfoCell:(XYInfomationCell *)cell
{
    UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
    detail.title = cell.model.title;
    [self.navigationController pushViewController:detail animated:YES];
}


@end



