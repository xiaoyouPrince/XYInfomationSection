//
//  WeiboViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "WeiboViewController.h"

@interface WeiboViewController ()

@end

@implementation WeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    [self setupContent];
}


#pragma mark - content
- (void)setupContent{
    [self setupMedium];
}
- (void)setupMedium{
    
    UIView *contentView = [UIView new];
    
    NSArray *dataArr = [DataTool WeiBoData];
    UIView *the_last_view = nil;
    int index = -1;
    for (NSArray *dictArr in dataArr) {
        index++;
        XYInfomationSection *section = [XYInfomationSection sectionForOriginal];
        NSMutableArray *dataArray = @[].mutableCopy;
        for (NSDictionary *dict in dictArr) {
            XYInfomationItem *item = [XYInfomationItem modelWithDict:dict];
            item.titleWidthRate = 0.6;
            item.titleFont = [UIFont boldSystemFontOfSize:16];
            [dataArray addObject:item];
        }
        section.dataArray = dataArray;
        
        [contentView addSubview:section];
        [section mas_makeConstraints:^(MASConstraintMaker *make) {
            if (the_last_view) {
                make.top.equalTo(the_last_view.mas_bottom).offset(20);
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
            UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
            detail.title = cell.model.title;
            [self.navigationController pushViewController:detail animated:YES];
        };
    }
    
    [self setContentView:contentView edgeInsets:UIEdgeInsetsMake(20, 0, 20, 0)];
}


@end
