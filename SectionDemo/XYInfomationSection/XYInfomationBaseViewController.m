//
//  XYInfomationBaseViewController.m
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/6/19.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

#import "XYInfomationBaseViewController.h"
#import "Masonry.h"

@interface XYInfomationBaseViewController ()

/** 内部使用的ScrollViewContentView */
@property(nonatomic , strong)     UIView *scrollContentView;

@end

@implementation XYInfomationBaseViewController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.scrollView setNeedsLayout];
    [self.scrollView layoutIfNeeded];
    
    // scrollView.contentSize 至少能滚动
    UIView *the_bottom_view = self.scrollContentView.subviews.lastObject;
    CGFloat max_y = CGRectGetMaxY(the_bottom_view.frame);
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    if (@available(iOS 11.0, *)) {
        scrollViewH = self.scrollView.frame.size.height - self.scrollView.adjustedContentInset.top - self.scrollView.adjustedContentInset.bottom;
    }
    if (max_y < scrollViewH) {
        self.scrollView.contentSize = CGSizeMake(0, scrollViewH + 0.5);
    }
    
    [self.scrollView scrollsToTop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 可以用来设置基类的背景色
    // self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    /// 创建基本的内部组件, default is hidden
    self.scrollView = [UIScrollView new];
    self.scrollView.hidden = YES;
    self.scrollContentView = [UIView new];
    _headerView = [UIView new];
    _contentView = UIView.new;
    _footerView = UIView.new;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollContentView];
    [self.scrollContentView addSubview:self.headerView];
    [self.scrollContentView addSubview:self.contentView];
    [self.scrollContentView addSubview:self.footerView];
    
    __weak typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.scrollContentView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.scrollContentView);
        make.right.equalTo(weakSelf.scrollContentView);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_bottom).offset(0);
        make.left.equalTo(weakSelf.scrollContentView);
        make.right.equalTo(weakSelf.scrollContentView);
        make.bottom.equalTo(weakSelf.scrollContentView);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    self.footerView.backgroundColor = UIColor.clearColor;
}

- (void)setHeaderView:(UIView *)headerView
{
    [self setHeaderView:headerView edgeInsets:UIEdgeInsetsZero];
}

- (void)setContentView:(UIView *)contentView{
    [self setContentView:contentView edgeInsets:UIEdgeInsetsZero];
}

- (void)setFooterView:(UIView *)footerView
{
    [self setFooterView:footerView edgeInsets:UIEdgeInsetsZero];
}

- (void)setHeaderView:(UIView *)headerView edgeInsets:(UIEdgeInsets)edgeInsets
{
    [self.headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.headerView addSubview:headerView];

    __weak typeof(self) weakSelf = self;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView).offset(edgeInsets.top);
        make.left.equalTo(weakSelf.headerView).offset(edgeInsets.left);
        make.right.equalTo(weakSelf.headerView).offset(-edgeInsets.right);
        make.height.mas_equalTo(headerView);
        make.bottom.equalTo(weakSelf.headerView).offset(-edgeInsets.bottom);
    }];
    
    [self hasSetupContent];
}

- (void)setContentView:(UIView *)contentView edgeInsets:(UIEdgeInsets)edgeInsets
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:contentView];
    
    __weak typeof(self) weakSelf = self;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(edgeInsets.top);
        make.left.equalTo(weakSelf.contentView).offset(edgeInsets.left);
        make.right.equalTo(weakSelf.contentView).offset(-edgeInsets.right);
        make.height.mas_equalTo(contentView);
        make.bottom.equalTo(weakSelf.contentView).offset(-edgeInsets.bottom);
    }];
    
    [self hasSetupContent];
}

- (void)setFooterView:(UIView *)footerView edgeInsets:(UIEdgeInsets)edgeInsets
{
    [self.footerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.footerView addSubview:footerView];
    
    __weak typeof(self) weakSelf = self;
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.footerView).offset(edgeInsets.top);
        make.left.equalTo(weakSelf.footerView).offset(edgeInsets.left);
        make.right.equalTo(weakSelf.footerView).offset(-edgeInsets.right);
        make.height.mas_equalTo(footerView);
        make.bottom.equalTo(weakSelf.footerView).offset(-edgeInsets.bottom);
    }];
    
    [self hasSetupContent];
}

- (void)setContentWithData:(NSArray *)dataArray
                itemConfig:(void(^)(XYInfomationItem *item))config
             sectionConfig:(nullable void(^)(XYInfomationSection *item))sectionConfig
           sectionDistance:(CGFloat)sectionDistance
         contentEdgeInsets:(UIEdgeInsets)edgeInsets
            cellClickBlock:(SectionCellClickBlock)cellClickBlock{
    
    if (dataArray.count == 0) {return;}
    
    UIView *contentView = [UIView new];
    NSArray *dataArr = dataArray;
    UIView *the_last_view = nil;
    int index = -1;
    for (NSArray *dictArr in dataArr) {
        index++;
        XYInfomationSection *section = [XYInfomationSection new];
        section.tag = index;
        if (sectionConfig) {
            sectionConfig(section);
        }
        NSMutableArray *dataArray = @[].mutableCopy;
        for (NSDictionary *dict in dictArr) {
            XYInfomationItem *item = [XYInfomationItem modelWithDict:dict];
            if (config) {
                config(item);
            }
            [dataArray addObject:item];
        }
        section.dataArray = dataArray;
        
        [contentView addSubview:section];
        [section mas_makeConstraints:^(MASConstraintMaker *make) {
            if (the_last_view) {
                make.top.equalTo(the_last_view.mas_bottom).offset(sectionDistance);
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
        section.cellClickBlock = cellClickBlock;
    }
    
    [self setContentView:contentView edgeInsets:edgeInsets];
}


- (void)hasSetupContent{
    // 只要有内容设置就展示对应的scrollView(页面的所有内容)
    self.scrollView.hidden = NO;
}

@end
