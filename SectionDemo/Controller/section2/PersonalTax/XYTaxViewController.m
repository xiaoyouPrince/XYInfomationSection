//
//  XYTaxViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxViewController.h"

@interface XYTaxViewController ()

/** headerView */
@property (nonatomic, strong)       UIView * headerView;

/** contentView */
@property (nonatomic, strong)       UIView * contentView;

@end

@implementation XYTaxViewController


#pragma mark - LazyLoad properties

- (UIView *)headerView
{
    if (!_headerView) {
        
        UIView *headerView = [[UIView alloc] init];
        _headerView = headerView;
        headerView.backgroundColor = HEXCOLOR(0xeaeaea);
        headerView.frame = CGRectMake(0, 0, 0, <#CGFloat height#>)
        
    }
    return _headerView;
}

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)loadData{
    
    // 可以做一些基础数据请求，根据数据展示下面的内容
}

- (void)buildUI{
    
    // 1.设置导航栏样式
    [self setupNav];
    
    // 顶部
}

- (void)setupNav{
    
    // 颜色设置(可能需要单独设置)
    self.navigationController.navigationBar.barTintColor = HEXCOLOR(0xf6f6f6);
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    // 内部自定义控件
}


#pragma mark - contentDelegates

#pragma mark - content Actions


#pragma mark - privateMethods


#pragma mark - publicMethods




- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 移除KVO
    // [self removeObserver:self forKeyPath:@""];;
}


@end

