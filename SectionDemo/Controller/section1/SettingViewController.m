//
//  SettingViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/20.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    [self buildUI];
}

- (void)buildUI{
    
    // 1. 用户手机号
    NSString *loginName = @"UserPhone";
    
    // 2. 系统缓存，这里只移除 temp 文件中的
    CGFloat size = [self folderSize];
    NSString *cacheSize = [NSString stringWithFormat:@"%.1fMB",size];
    
    
    // 两组section + 退出登录按钮
    XYInfomationSection *section = [XYInfomationSection new];
    
    XYInfomationItem *item1 = [XYInfomationItem modelWithImage:@"icon_setting_personInfo" Title:@"个人信息" titleKey:@"UserInfoViewController" type:XYInfoCellTypeChoose value:@" " placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item2 = [XYInfomationItem modelWithImage:@"icon_setting_phone" Title:@"手机号" titleKey:nil type:XYInfoCellTypeChoose value:loginName placeholderValue:nil disableUserAction:NO];
    section.dataArray = @[item1,item2];
    
    XYInfomationSection *section2 = [XYInfomationSection new];
    
    XYInfomationItem *item3 = [XYInfomationItem modelWithImage:@"icon_setting_english" Title:@"多语言" titleKey:nil type:XYInfoCellTypeChoose value:@"简体中文" placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item4 = [XYInfomationItem modelWithImage:@"icon_setting_clean" Title:@"清除缓存" titleKey:nil type:XYInfoCellTypeInput value:cacheSize placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item5 = [XYInfomationItem modelWithImage:@"icon_setting_about" Title:@"关于我们" titleKey:nil type:XYInfoCellTypeChoose value:@"版本号V 2.6.2" placeholderValue:nil disableUserAction:NO];
    section2.dataArray = @[item3,item4,item5];
    
    UIView *contentView = [UIView new];
    [contentView addSubview:section];
    [contentView addSubview:section2];
    
    [section mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
    }];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section.mas_bottom).offset(15);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.bottom.equalTo(contentView);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo( section.bounds.size.height + 15 + section2.bounds.size.height);
    }];
    
    [contentView setNeedsLayout];
    [contentView layoutIfNeeded];
    
    [self setContentView:contentView edgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    
    // logOutBtn
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logoutBtn.backgroundColor = UIColor.whiteColor;
    [logoutBtn setTitleColor:HEXCOLOR(0Xd8261d) forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutClicked) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.frame = CGRectMake(0, 0, 0, 45);
    logoutBtn.layer.cornerRadius = 10;
    
    [self setFooterView:logoutBtn edgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];

    
    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
        if (index == 0) {
            [self didClickInfoCell:cell];
            return ;
        }
        
        NSString *message = [NSString stringWithFormat:@"点击了%@",cell.model.title];
        [SVProgressHUD showInfoWithStatus:message];
    };
    section2.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
        NSString *message = [NSString stringWithFormat:@"点击了%@",cell.model.title];
        [SVProgressHUD showInfoWithStatus:message];
    };
    
}

- (void)didClickInfoCell:(XYInfomationCell *)cell
{
    UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
    detail.title = cell.model.title;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - events

- (void)logoutClicked{
    
    [SVProgressHUD showInfoWithStatus:@"退出登录..."];
}

#pragma mark - cacheTool
// 缓存大小
- (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return sizeM;
}

- (void)removeCache{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                
            }else{
                
                NSLog(@"清除失败");
                
            }
        }
    }
}

@end
