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
    
    
    /*!
     
     @abstract
     VC下内容的自动缩进 navHeight 的事情
     
     iOS 7 之后 ViewController 会对自己 view 内部仅有的一个scrollView进行内容的下移 navHeight 来避免导航栏挡住内容。
     
     在 iPhone 8P 上的表现就是，将scrollView的 frame.y -= navHeight.
     但是前提是绘制scrollView的时候，scrollView是 self.view.subviews.firstobject.(即绘制之前，view上不能在scrollView之下添加新的view)
     
     @note
     如下代码在添加的时候就需要注意，如果是添加到self.view 上，直接绘制的时候就无法正确展示contentView的位置
     
     */
    
    
    // 1. 创建一个背景图片
    UIImage *bgImage = [UIImage imageNamed:@"profileBg"];
    UIImageView *bgIV = [[UIImageView alloc] initWithImage:bgImage];
    [self.scrollView insertSubview:bgIV atIndex:0];
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavHeight);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
    }];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = XYColor(240, 242, 250);
    [self.scrollView insertSubview:bgView atIndex:0];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [self setupNav];
    
    
    //    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    addBtn.backgroundColor = UIColor.greenColor;
    //    self.headerView = addBtn;
    
    //    UISwitch *swit = [UISwitch new];
    //    swit.backgroundColor = UIColor.yellowColor;
    //    self.contentView = swit;
    
    //    UILabel *label = [UILabel new];
    //    label.text = @"我是底部控件";
    //    label.frame = CGRectMake(0, 0, 200, 300);
    //    label.backgroundColor = UIColor.cyanColor;
    //    self.footerView = label;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    // 1. 设置头部view
    UITableViewCell *headerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    headerCell.imageView.image = [UIImage imageNamed:@"userDefaultIcon"];
    headerCell.textLabel.text = @"小明";
    headerCell.detailTextLabel.text = @"天行健，君子以自强不息";
    headerCell.frame = CGRectMake(0, 0, ScreenW, 60);
    [self setHeaderView:headerCell edgeInsets:UIEdgeInsetsMake(10, 15, 10, 15)];
    // self.headerView = headerCell;
    
    // 2.1 设置中间内容，通常列表，使用 XYInfomationSection 最佳
    XYInfomationSection *section1 = [XYInfomationSection new];
    NSArray *titles = @[
                        @"我的订单",
                        @"团队成员信息",
                        @"我的卡包",
                        @"积分商城",
                        @"邀请朋友",
                        @"帮助与反馈"
                        ];
    NSMutableArray *arrayM = @[].mutableCopy;
    for (int i = 0; i < titles.count; i ++){
        XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"自定义标题" titleKey:@" " type:0 value:@"" placeholderValue:nil disableUserAction:YES];
        
        XYInfoCellType type = XYInfoCellTypeChoose;
        item.type = type;
        NSString *title = titles[i];
        item.title = title;
        item.imageName = [NSString stringWithFormat:@"icon_mine_%d",i];
        item.value = @"";
        item.backgroundImage = (i == 0)? @"bg_top" : @"bg_middle";
        if (i == titles.count-1) {
            item.backgroundImage = @"bg_bottom";
        }
        
        // 加入数据源
        [arrayM addObject:item];
    }
    section1.dataArray = arrayM;
    
    // 2.2 第二组section
    XYInfomationSection *section2 = [XYInfomationSection new];
    XYInfomationItem *item = [arrayM.lastObject copy];
    item.imageName = @"icon_mine_6";
    item.title = @"设置";
    section2.dataArray = @[item];
    
    UIView *contentView = [UIView new];
    [contentView addSubview:section1];
    [contentView addSubview:section2];
    
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(0);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
    }];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(15);
        make.left.equalTo(contentView);
        make.right.equalTo(contentView);
        make.bottom.equalTo(contentView);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo( section1.bounds.size.height + 15 + section2.bounds.size.height);
    }];
    
    [contentView setNeedsLayout];
    [contentView layoutIfNeeded];
    
    [self setContentView:contentView edgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    
    
    // 点击事件处理
    section1.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        NSString *message = [NSString stringWithFormat:@"进入%@页面",cell.model.title];
        [SVProgressHUD showInfoWithStatus:message];
    };
    section2.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        NSString *message = [NSString stringWithFormat:@"进入%@页面",cell.model.title];
        [SVProgressHUD showInfoWithStatus:message];
    };

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
