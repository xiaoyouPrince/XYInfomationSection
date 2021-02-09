//
//  WeiboViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "WeiboViewController.h"

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
    
    [self setContentWithData:[DataTool WeiBoData] itemConfig:^(XYInfomationItem * _Nonnull item) {
        item.titleWidthRate = 0.6;
        item.titleFont = [UIFont boldSystemFontOfSize:16];
    } sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
    }  sectionDistance:20 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 20, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        [SVProgressHUD showSuccessWithStatus:[@"点击了" stringByAppendingString:cell.model.title]];
    }];   
}


@end
