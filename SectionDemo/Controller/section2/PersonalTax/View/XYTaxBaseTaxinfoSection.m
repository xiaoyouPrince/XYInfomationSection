//
//  XYTaxBaseTaxinfoSection.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/24.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxBaseTaxinfoSection.h"
#import "XYTaxBaseSection.h" // section头

@interface XYTaxBaseTaxinfoSection()

/** image */
@property (nonatomic, copy)         NSString * imageName;
/** title */
@property (nonatomic, copy)         NSString * title;
/** dataArray */
@property (nonatomic, strong)       NSArray<XYInfomationItem *> * dataArray;

@end

@implementation XYTaxBaseTaxinfoSection

+ (instancetype)taxSectionWithImage:(NSString *)imageName title:(NSString *)title infoItems:(NSArray<XYInfomationItem *> *)dataArray disable:(BOOL)diable
{
    XYTaxBaseTaxinfoSection *instance = [XYTaxBaseTaxinfoSection new];
    instance.imageName = imageName;
    instance.title = title;
    instance.dataArray = dataArray;
    instance.userInteractionEnabled = !diable;
    return instance;
}

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

- (void)setDataArray:(NSArray<XYInfomationItem *> *)dataArray
{
    if (!dataArray.count) return;
    
    _dataArray = dataArray;
    
    // header
    // 1.section Header
    CGFloat headerHeight = 44;
    XYTaxBaseSection *sectionHeader = [XYTaxBaseSection groupWithTitle:self.title icon:self.imageName];
    [self addSubview:sectionHeader];
    
    // constraints
    [sectionHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(headerHeight));
    }];
    
    // section
    XYInfomationSection *section = [XYInfomationSection new];
    [self addSubview:section];
    section.dataArray = dataArray;
    
    // constraints
    [section mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionHeader.mas_bottom).offset(0);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    __weak typeof(self) weakSelf = self;
    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
//        [weakSelf sectionCellClicked:cell];
    };
    
    // 监听出生日期，如果身份类型:身份证，身份证号码为正确的身份证号--->自动输入出生日期
//    [item4 addObserver:weakSelf forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
}




@end
