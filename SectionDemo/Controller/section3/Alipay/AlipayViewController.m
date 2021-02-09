//
//  AliPayViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/2.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "AlipayViewController.h"
#import "AlipaySettingViewController.h"
#import "BaseNavigationController.h"
#import "AlipayHeaderView.h"
#import "DataTool.h"

@interface AlipayViewController ()<UIScrollViewDelegate>
/** nav */
@property (nonatomic, strong)       UIView * nav;
@end

@implementation AlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont boldSystemFontOfSize:25];
    titleLabel.textColor = UIColor.whiteColor;
    self.navigationItem.titleView = titleLabel;
    [(BaseNavigationController *)self.navigationController setNavBarTransparent];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"settings_w"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    UIView *nav = [UIView new];
    _nav = nav;
    nav.backgroundColor = UIColor.systemBlueColor;
    [self.view insertSubview:nav atIndex:0];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(kNavHeight);
    }];
    
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 10.0, *)) {
        self.scrollView.refreshControl = [UIRefreshControl new];
    }
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    [self setupContent];
}
 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(BaseNavigationController *)self.navigationController setNavBarTransparent];
}


#pragma mark - scrollDelagate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    NSLog(@"高度%f",kNavHeight-scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y + kNavHeight < 0) {
        [_nav mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kNavHeight-scrollView.contentOffset.y);
        }];
        [self.view sendSubviewToBack:_nav];
        if (@available(iOS 10.0, *)) {
            if (!scrollView.refreshControl.isRefreshing) {
                [scrollView.refreshControl beginRefreshing];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       // 刷新数据
                       if (scrollView.refreshControl.isRefreshing) {
                           [scrollView.refreshControl endRefreshing];
                       }
                   });
            }
        }
    }else{
        [_nav mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kNavHeight);
        }];
        [self.view bringSubviewToFront:_nav];
    }
}

#pragma mark - nav_right_click
- (void)rightClick{
    AlipaySettingViewController *set = [AlipaySettingViewController new];
    set.title = @"设置";
    [self.navigationController pushViewController:set animated:YES];
}

#pragma mark - content
- (void)setupContent{
    [self setupHeader];
    [self setupMedium];
    [self setupFooter];
}

- (void)setupHeader{
    AlipayHeaderView *header = [AlipayHeaderView viewWithHeaderImage:@"grade" name:@"晓友" phone:@"110*****29"];
    [self setHeaderView:header];
}

- (void)setupMedium{
    
    NSArray *dataArr = [DataTool AliPayData];
    __weak typeof(AlipayViewController) *weakSelf = self;
    
    [self setContentWithData:dataArr itemConfig:nil sectionConfig:nil sectionDistance:10 contentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
        detail.title = cell.model.title;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    }];
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
