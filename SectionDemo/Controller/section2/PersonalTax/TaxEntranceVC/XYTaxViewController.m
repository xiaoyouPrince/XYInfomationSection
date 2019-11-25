//
//  XYTaxViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/22.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxViewController.h"

@interface XYTaxViewController ()

/** bannerView */
@property (nonatomic, strong)       UIView * bannerView;

/** 入口列表 */
@property (nonatomic, strong)       UIView * entranceView;

@end

@implementation XYTaxViewController


#pragma mark - LazyLoad properties

- (UIView *)bannerView
{
    if (!_bannerView) {
        
        // 图片比例 345:148
        UIImage *bannerImage = [UIImage imageNamed:@"tax_banner"];
        CGFloat imageHWRate = bannerImage.size.height/bannerImage.size.width;
        CGFloat bannerHeight = 15+10 + (ScreenW-30)*imageHWRate;
        
        UIView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, bannerHeight)];
        headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *banner = [[UIImageView alloc] init];
        banner.image = bannerImage;
        [headerView addSubview:banner];
        
        [banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView).offset(15);
            make.left.equalTo(headerView).offset(15);
            make.right.equalTo(headerView).offset(-15);
            make.bottom.equalTo(headerView).offset(-10);
        }];
        
        _bannerView = headerView;
    }
    return _bannerView;
}

- (UIView *)entranceView
{
    if (!_entranceView) {
        
        // 1. 创建entranceView
        _entranceView = [UIView new];
        
        // 拿到入口数据，真实项目中应该是网络获取
        NSArray *entranceData = [DataTool dataArrayForPersonTaxEntrance];
        
        __weak typeof(self) weakSelf = self;
        
        UIView *lastSection = nil;
        for (int index = 0; index < entranceData.count; index++) {
            
            NSDictionary *dict = entranceData[index];
            
            XYInfomationItem *item = [XYInfomationItem modelWithImage:dict[@"image"] Title:dict[@"title"] titleKey:dict[@"titleKey"] type:XYInfoCellTypeChoose value:@" " placeholderValue:@"" disableUserAction:NO];
            item.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tax_right_arraw"]];
            XYInfomationSection *section = [XYInfomationSection sectionWithData:@[item]];
            
            section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
                
                // 进入对应的页面
                PersonalTaxBaseViewController *detail = [NSClassFromString(dict[@"titleKey"]) new];
                detail.title = dict[@"title"];
                detail.taxType = [dict[@"taxType"] integerValue];
                [weakSelf.navigationController pushViewController:detail animated:YES];
            };
            
            [_entranceView addSubview:section];
            
            [section mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if (index == 0) {
                    make.top.equalTo(_entranceView).offset(15);
                }else
                {
                    make.top.equalTo(lastSection.mas_bottom).offset(10);
                }
                
                make.left.equalTo(_entranceView).offset(15);
                make.right.equalTo(_entranceView).offset(-15);
                
                if (index == entranceData.count-1) {
                    make.bottom.equalTo(_entranceView).offset(-15);
                }
            }];
            
            lastSection = section;
        }
        
    }
    
    return _entranceView;
}

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    
    [self buildUI];    
}

- (void)buildUI{
    
    // 顶部
    [self setHeaderView:self.bannerView];
    // 入口列表
    [self setContentView:self.entranceView];
}

@end

