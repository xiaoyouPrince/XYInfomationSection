//
//  UserCenterViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/20.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "UserCenterViewController.h"
#import "BaseNavigationController.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XYColor(252, 81, 77);
    
    // 1. 创建一个背景图片
    UIImage *bgImage = [UIImage imageNamed:@"profileBg"];
    UIImageView *bgIV = [[UIImageView alloc] initWithImage:bgImage];
    [self.scrollView insertSubview:bgIV atIndex:0];
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(0);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
    }];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = XYColor(240, 242, 250);
    [self.view insertSubview:bgView atIndex:0];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNav];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.backgroundColor = UIColor.greenColor;
    self.headerView = addBtn;
    
    UISwitch *swit = [UISwitch new];
    swit.backgroundColor = UIColor.yellowColor;
    self.contentView = swit;
    
    UILabel *label = [UILabel new];
    label.text = @"我是底部控件";
    label.frame = CGRectMake(0, 0, 200, 300);
    label.backgroundColor = UIColor.cyanColor;
    self.footerView = label;
}

- (void)setupNav{
    
    // title
    UILabel *titleLabel = [UILabel new];
    UIFont *titleFont = [UIFont boldSystemFontOfSize:18];
    [titleLabel setText:@"个人中心"];
    titleLabel.font = titleFont;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    
    
//    self.scrollView.backgroundColor = UIColor.clearColor;
    
    //设置导航栏透明
    [(BaseNavigationController *)self.navigationController setNavBarTransparent];
}



@end
