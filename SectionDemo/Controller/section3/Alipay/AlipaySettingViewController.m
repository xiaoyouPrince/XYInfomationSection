//
//  AlipaySettingViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "AlipaySettingViewController.h"

@interface AlipaySettingViewController ()

@end

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
    [self setupMedium];
    [self setupFooter];
}

- (void)setupMedium{
    
    UIView *contentView = [UIView new];
    
    NSArray *dataArr = [DataTool AliPaySettingData];
    UIView *the_last_view = nil;
    int index = -1;
    for (NSArray *dictArr in dataArr) {
        index++;
        XYInfomationSection *section = [[XYInfomationSection alloc] initForOriginal];
        NSMutableArray *dataArray = @[].mutableCopy;
        for (NSDictionary *dict in dictArr) {
            XYInfomationItem *item = [XYInfomationItem modelWithDict:dict];
            [dataArray addObject:item];
        }
        section.dataArray = dataArray;
        
        [contentView addSubview:section];
        [section mas_makeConstraints:^(MASConstraintMaker *make) {
            if (the_last_view) {
                make.top.equalTo(the_last_view.mas_bottom).offset(10);
            }else
            {
                make.top.equalTo(contentView);
            }
            make.left.equalTo(contentView);
            make.right.equalTo(contentView);
            if (index == dataArr.count-1) {
                make.bottom.equalTo(contentView);
            }
        }];
        
        the_last_view = section;
        section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
            [SVProgressHUD showSuccessWithStatus:[@"点击了" stringByAppendingString:cell.model.title]];
        };
    }
    
    [self setContentView:contentView edgeInsets:UIEdgeInsetsMake(20, 0, 10, 0)];
}

- (void)setupFooter{
    
    UIView *contentView = [UIView new];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"save_style_text"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    iv.tintColor = UIColor.systemBlueColor;
    [contentView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.centerX.equalTo(contentView);
        make.bottom.equalTo(contentView);
    }];
    
    [self setFooterView:contentView edgeInsets:UIEdgeInsetsMake(20, 10, 30, 10)];
}


@end
