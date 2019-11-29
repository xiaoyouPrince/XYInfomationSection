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

/** handler */
@property (nonatomic, copy)         XYTaxBaseTaxinfoSectionHandler handler;

// ---- 以下为可添加模式独有的
/** addStyle: default is NO */// 是否是可以添加的样式
@property (nonatomic, assign, getter=isAddStyle)         BOOL addStyle;
/** topView */
@property (nonatomic, strong)       UIView * topView;
/** bottomView */
@property (nonatomic, strong)       UIView * bottomView;


@end

@implementation XYTaxBaseTaxinfoSection

+ (instancetype)taxSectionWithImage:(NSString *)imageName title:(NSString *)title infoItems:(NSArray<XYInfomationItem *> *)dataArray handler:(nullable XYTaxBaseTaxinfoSectionHandler)handler
{
    XYTaxBaseTaxinfoSection *instance = [XYTaxBaseTaxinfoSection new];
    instance.imageName = imageName;
    instance.title = title;
    instance.dataArray = dataArray;
    instance.handler = handler;
    if (!handler) {
        instance.userInteractionEnabled = NO;
    }
    return instance;
}

/// 可以额外添加的组
+ (instancetype)taxSectionCanAddWithImage:(NSString *)imageName
                                    title:(NSString *)title
                                infoItems:(NSArray <XYInfomationItem *>*)dataArray
                                  handler:(nullable XYTaxBaseTaxinfoSectionHandler)handler
{
    XYTaxBaseTaxinfoSection *instance = [XYTaxBaseTaxinfoSection new];
    instance.addStyle = YES;
    instance.imageName = imageName;
    instance.title = title;
    instance.dataArray = dataArray;
    instance.handler = handler;
    if (!handler) {
        instance.userInteractionEnabled = NO;
    }
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
    
    if (self.isAddStyle) {
        [self buildUIForAddStyle];
        return;
    }
    
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
        if (weakSelf.handler) {
            weakSelf.handler(cell);
        }
    };
}

- (UIView *)buildComponentUI
{
    UIView *view = [UIView new];
    
    // header
    // 1.section Header
    CGFloat headerHeight = 44;
    XYTaxBaseSection *sectionHeader = [XYTaxBaseSection groupWithTitle:self.title icon:self.imageName];
    [view addSubview:sectionHeader];
    
    // constraints
    [sectionHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(0);
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.height.equalTo(@(headerHeight));
    }];
    
    // section
    XYInfomationSection *section = [XYInfomationSection new];
    [view addSubview:section];
    // 每次创建都使用深拷贝
    NSMutableArray *arrayM = @[].mutableCopy;
    for (XYInfomationItem *item in self.dataArray) {
        [arrayM addObject:item.copy];
    }
    section.dataArray = arrayM;
    
    // constraints
    [section mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionHeader.mas_bottom).offset(0);
        make.left.equalTo(view);
        make.right.equalTo(view);
        make.bottom.equalTo(view);
    }];
    __weak typeof(self) weakSelf = self;
    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        if (weakSelf.handler) {
            weakSelf.handler(cell);
        }
    };
    
    return view;
}

/// 创建可添加类型的View
- (void)buildUIForAddStyle
{
    // topView + addView
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = HEXCOLOR(0xeaeaea);
    [self addSubview:topView];
    self.topView = topView;
    
    UIButton *bottomView = [[UIButton alloc] init];
    bottomView.backgroundColor = HEXCOLOR(0xeaeaea);
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    bottomView.backgroundColor = HEXCOLOR(0xF0F8FE);
    [bottomView setImage:[UIImage imageNamed:@"icon_tax_add"] forState:UIControlStateNormal];
    [bottomView setTitle:[@"添加" stringByAppendingString:self.title] forState:UIControlStateNormal];
    bottomView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    bottomView.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    bottomView.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomView setTitleColor:HEXCOLOR(0x73AAE4) forState:UIControlStateNormal];
    [bottomView addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self);
    }];
    
    // 初始化默认的第一个ContentView
    UIView *componentView = [self buildComponentUI];
    [self.topView addSubview:componentView];
    
    [componentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).offset(0);
        make.left.equalTo(self.topView).offset(0);
        make.right.equalTo(self.topView).offset(0);
    }];
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(componentView).offset(0);
    }];
}

- (void)addBtnClick:(UIButton *)sender
{
    // 添加一个新组 & 更新底部约束
    __weak UIView *componentView = [self buildComponentUI];
    [self.topView addSubview:componentView];
    
    XYTaxBaseSection *header = componentView.subviews.firstObject;
    __weak typeof(self) weakSelf = self;
    header.delteteBlock = ^{
        
        // 移除UI
        [componentView removeFromSuperview];
        
        // 点击删除，刷新数据
        [weakSelf refreshTopViewContent];
    };
    
    [self refreshTopViewContent];
}

- (void)refreshTopViewContent{
    
    // 1.移除之前约束
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
    }];
    
    int index = -1;
    UIView *lastView;
    for (UIView *subView in self.topView.subviews) {
        index ++;
        [subView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.top.equalTo(self.topView).offset(0);
            }else
            {
                make.top.equalTo(lastView.mas_bottom).offset(0);
            }
            make.left.equalTo(self.topView).offset(0);
            make.right.equalTo(self.topView).offset(0);
            if (index == self.topView.subviews.count-1) {
                make.bottom.equalTo(self.topView).offset(0);
            }
        }];
        lastView = subView;
        
        
        // 更新title
        XYTaxBaseSection *header = subView.subviews.firstObject;
        [header updateTitleWithIndex:index];
        
    }
}

- (NSArray<XYInfomationCell *> *)cellsArray
{
    if (self.isAddStyle) {
        return nil;
    }
    return self.subviews.lastObject.subviews;
}


@end
