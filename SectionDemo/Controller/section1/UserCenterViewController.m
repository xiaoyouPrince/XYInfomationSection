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
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNav];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.headerView = addBtn;
    
    UISwitch *swit = [UISwitch new];
    self.contentView = swit;
}

- (void)setupNav{
    
    // title
    UILabel *titleLabel = [UILabel new];
    UIFont *titleFont = [UIFont boldSystemFontOfSize:18];
    [titleLabel setText:@"个人中心"];
    titleLabel.font = titleFont;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    
    //设置导航栏透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.userInteractionEnabled = YES;
    

    [(BaseNavigationController *)self.navigationController setNavBarTransparent];
}



@end
