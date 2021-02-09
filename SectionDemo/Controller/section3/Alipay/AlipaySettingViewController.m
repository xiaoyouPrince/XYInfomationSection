//
//  AlipaySettingViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "AlipaySettingViewController.h"

@implementation AlipaySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    [self setupContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
}

#pragma mark - content
- (void)setupContent{
    [self setContentWithData:[DataTool AliPaySettingData] itemConfig:nil sectionConfig:nil sectionDistance:10 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 10, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        [SVProgressHUD showSuccessWithStatus:[@"点击了" stringByAppendingString:cell.model.title]];
    }];
}

@end
