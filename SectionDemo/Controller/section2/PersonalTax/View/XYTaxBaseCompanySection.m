//
//  XYTaxBaseCompanySection.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxBaseCompanySection.h"
#import "XYTaxBaseSection.h" // section头
#import "XYTaxBaseCompanyInfoCell.h" // 列表

@implementation XYTaxBaseCompanySection

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupContent];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    
    self.backgroundColor = UIColor.clearColor;
}

- (void)setCompanies:(NSArray<XYTaxBaseCompany *> *)companies
{
    _companies = companies;
    
    // 如果数据为空直接返回
    if (companies.count == 0) {
        return;
    }
    
    // 加载完成之后，开始创建内部UI，并动态计算自己高度
    
    // 1.section Header
    CGFloat headerHeight = 44;
    XYTaxBaseSection *sectionHeader = [XYTaxBaseSection groupWithTitle:@"任职受雇信息" icon:@"icon_tax_renzhi"];
    [self addSubview:sectionHeader];
    
    // constraints
    [sectionHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(headerHeight));
    }];
    
    // 2.cells
    int i = -1;
    UIView *lastView;
    for (XYTaxBaseCompany * company in self.companies) {
        i++;
        
        XYTaxBaseCompanyInfoCell *cell = [XYTaxBaseCompanyInfoCell new];
        cell.model = company;
        [self addSubview:cell];
        
        // constraints
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (i == 0) {
                make.top.equalTo(self).offset(headerHeight);
            }else
            {
                make.top.equalTo(lastView.mas_bottom);
            }
            make.left.equalTo(self);
            make.right.equalTo(self);            
            if (i == self.companies.count-1) {
                make.bottom.equalTo(self);
            }
        }];
        
        if (i == 0) {
            cell.tag = 100;
        }
        
        lastView = cell;
    }
    
    // 默认选中第一个
    XYTaxBaseCompanyInfoCell *cell = [self viewWithTag:100];
    [cell setSelected];
    
    [self layoutIfNeeded];
}


- (void)setSelectedCompany:(XYTaxBaseCompany * _Nonnull)selectedCompany
{
    if (selectedCompany == nil) {
        return;
    }
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[XYTaxBaseCompanyInfoCell class]]) {
            XYTaxBaseCompanyInfoCell *cell = (XYTaxBaseCompanyInfoCell *)subview;
            if ([cell.model.nsrsbh isEqualToString:selectedCompany.nsrsbh]) {
                [cell setSelected];
            }
        }
    }
}

- (XYTaxBaseCompany *)selectedCompany
{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[XYTaxBaseCompanyInfoCell class]]) {
            XYTaxBaseCompanyInfoCell *cell = (XYTaxBaseCompanyInfoCell *)subview;
            if (cell.isChoosen) {
                return cell.model;
            }
        }
    }
    
    return self.companies.firstObject;
}

@end
