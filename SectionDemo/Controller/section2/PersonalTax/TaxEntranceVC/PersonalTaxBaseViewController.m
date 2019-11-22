//
//  PersonalTaxBaseViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/25.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "PersonalTaxBaseViewController.h"
#import "XYExtendBtn.h"

@interface PersonalTaxBaseViewController ()

/** taxBannerView: 【banner图 + 介绍文案】 */
@property (nonatomic, strong)       UIView * taxBannerView;

/** taxBottomView: 【公司内容 + 个税报销说明】 */
@property (nonatomic, strong)       UIView * taxBottomView;

@end

@implementation PersonalTaxBaseViewController
{
    UIImageView *_bannerIconView;
    UILabel *_bannerLabel;
}

#pragma mark - LazyLoad properties

- (NSString *)bannerName
{
    switch (self.taxType) {
        case TaxTypeChildEducation:
            return @"icon_banner_znjy";
            break;
        case TaxTypeMoreEducation:
            return @"icon_banner_jxjy";
            break;
        case TaxTypeHouseRent:
            return @"icon_banner_zfzj";
            break;
        case TaxTypeHouseLoans:
            return @"icon_banner_zfdk";
            break;
        case TaxTypeDabingyiliao:
            return @"icon_banner_dbyl";
            break;
        case TaxTypeAlimonyPay:
            return @"icon_banner_alimony";
            break;
        case TaxTypeOther:
            return @"tax_banner";
            break;
        default:
            break;
    }
}

- (NSAttributedString *)taxDescription{
    
    NSString *desc = nil;
    switch (self.taxType) {
        case TaxTypeChildEducation:
            desc = @"        纳税人的子女接受学前教育和学历教育的相关支出，按照每个子女每年12000元（每月1000元）的标准定额扣除。学前教育包括年满3岁至小学入学前教育。学历教育包括义务教育（小学和初中教育）、高中阶段教育（普通高中、中等职业教育、技工教育)、高等教育（大学专科、大学本科、硕士研究生、博士研究生教育）。";
            break;
        case TaxTypeMoreEducation:
            desc = @"        纳税人接受学历继续教育的支出，在学历教育期间按照每年4800元（每月400元）定额扣除。纳税人接受技能人员职业资格继续教育、专业技术人员职业资格继续教育支出，在取得相关证书的年度，按照每年3600元定额扣除。\n"
            "        个人接受本科以下学历（学位）继续教育，符合扣除条件的可以选择有父母或者本人扣除。";
            break;
        case TaxTypeHouseRent:
            desc = @"        纳税人本人及配偶在纳税人的主要工作城市没有住房，而在主要工作城市租赁住房发生的租金支出,可以按照以下标准定额扣除：\n"
            "（一）承租的住房位于直辖市、省会城市、计划单列市以及国务院确定的其他城市，扣除标准为每年18000元（每月1500元）\n"
            "（二）承租的住房位于其他城市的，市辖区户籍人口超过100万的，扣除标准为每年13200元（每月1100元）。\n"
            "（三）承租的住房位于其他城市的，市辖区户籍人口不超过100万（含）的，扣除标准为每年9600元（每月800元）。";
            break;
        case TaxTypeHouseLoans:
            desc = @"        纳税人本人或配偶单独或共同使用商业银行或住房公积金个人住房贷款为本人或其配偶购买中国境内住房，发生的首套住房贷款利息支出，在实际发生贷款利息的年度，可以按照每年12000元（每月1000元）标准定额扣除。\n"
            "        夫妻双方婚前分别购买住房发生首套住房贷款，其贷款利息支出，婚后可以选择其中一套购买的住房按照扣除标准的100%进行扣除，也可以由夫妻双方对各自购买的住房分别按照扣除额的50%扣除，具体扣除方式在一个纳税年度内不能变更。\n"
            "        非首套住房贷款利息支出，纳税人不得扣除。纳税人只能享受一套首套住房贷款利息扣除。";
            break;
        case TaxTypeDabingyiliao:
            desc = @"        一个纳税年度内，在社会医疗保险管理信息系统记录的（包括医保目录范围内的自付部分和医保目录范围外的自费部分）由个人负担超过15000元的医药费用支出部分，为大病医疗支出，可以按照每年80000元标准限额据实扣除。大病医疗专项附加扣除由纳税人办理汇算清缴时扣除。";
            break;
        case TaxTypeAlimonyPay:
            desc = @"        纳税人赡养60岁（含）以上父母以及其他法定赡养人的赡养支出，可以按照以下标准定额扣除：\n"
            "（一）纳税人为独生子女的，按照每年24000元（每月2000元）的标准定额扣除；\n"
            "（二）纳税人为非独生子女的，应当与其兄弟姐妹分摊每年24000元(每月2000元)的扣除额度，分摊方式包括平均分摊、被赡养人指定分摊或者赡养人约定分摊，具体分摊方式在一个纳税年度内不得变更。采取指定分摊或约定分摊方式的，每一纳税人分摊的扣除额最高不得超过每年12000元（每月1000元），并签订书面分摊协议。指定分摊与约定分摊不一致的，以指定分摊为准。纳税人赡养2个及以上老人的，不按老人人数加倍扣除。";
            break;
        case TaxTypeOther:
            break;
        default:
            break;
    }
    
    NSMutableAttributedString *desc_A = [[NSMutableAttributedString alloc] initWithString:desc];
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = 7;
    [desc_A setAttributes:@{NSParagraphStyleAttributeName : ps} range:NSMakeRange(0, desc.length-1)];
    
    return desc_A;
}

- (UIView *)taxBannerView
{
    if (!_taxBannerView) {
        
        _taxBannerView = [UIView new];
        _taxBannerView.backgroundColor = UIColor.clearColor;
        _taxBannerView.clipsToBounds = YES;
        
        // 1.banner
        UIImageView *icon = [UIImageView new];
        _bannerIconView = icon;
        icon.image = [UIImage imageNamed:[self bannerName]];
        [_taxBannerView addSubview:icon];
        
        // 计算高度
        CGFloat WHRate = icon.image.size.width/icon.image.size.height;
        CGFloat iconW = (ScreenW-30);
        CGFloat iconH = iconW/WHRate;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_taxBannerView).offset(15);
            make.left.equalTo(_taxBannerView).offset(15);
            make.right.equalTo(_taxBannerView).offset(-15);
            make.height.mas_equalTo(iconH);
        }];
        
        // 2. 说明文案Label
        UILabel *label = [[UILabel alloc] init];
        _bannerLabel = label;
        label.backgroundColor = UIColor.clearColor;
        [_taxBannerView addSubview:label];
        label.preferredMaxLayoutWidth = iconW;
        label.attributedText = [self taxDescription];
        label.numberOfLines = 0;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_bottom).offset(10);
            make.left.right.equalTo(icon);
        }];
        
        [_bannerIconView setNeedsLayout];
        [_bannerIconView layoutIfNeeded];
        
        // 3. 展开关闭按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_taxBannerView addSubview:btn];
        btn.backgroundColor = UIColor.whiteColor;
        [btn addTarget:self action:@selector(extendBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icon.mas_bottom).offset(110); // 默认110文字高度
            make.left.right.equalTo(icon);
            make.height.mas_equalTo(40);
        }];
        
        XYExtendBtn *extendBtn = [XYExtendBtn new];
        [extendBtn setFold:YES];
        [btn addSubview:extendBtn];
        [extendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(btn);
        }];
        
        // 4. 底边装饰
        UIImageView *icon2 = [UIImageView new];
        icon2.backgroundColor = self.view.backgroundColor;
        icon2.image = [UIImage imageNamed:@"headerBottonImage"];
        [_taxBannerView addSubview:icon2];
        
        [icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom);
            make.left.right.equalTo(_taxBannerView);
            make.bottom.equalTo(_taxBannerView);
        }];
        
        // 设置一个白色背景
        UIView *bgView = [UIView new];
        [_taxBannerView insertSubview:bgView atIndex:0];
        bgView.backgroundColor = UIColor.whiteColor;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_taxBannerView);
            make.left.equalTo(_taxBannerView);
            make.right.equalTo(_taxBannerView);
            make.bottom.equalTo(btn.mas_bottom);
        }];
    }
    return _taxBannerView;
}

- (UIView *)taxBottomView
{
    if (!_taxBottomView) {
        
        // 1.公司信息。网络请求，有则展示，没有则不展示
        
        // 2.个税信息
        
        // 3.同意按钮
    }
    return _taxBottomView;
}

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf6f6f6);
    
    [self buildUI];
    
    [self loadData];
}

- (void)loadData{
    
    // 实际项目中会请求很多数据，这里简化
}

- (void)buildUI{
    
    // 1.设置导航栏样式
    [self setupNav];
    
    // 创建个税页面
    
    // 1. 设置头视图
    [self setHeaderView:self.taxBannerView];
    
    // 2. 中间部分为各个税种自己内容个，子页面单独处理
    
    // 3. 设置底部视图
    [self setFooterView:self.taxBottomView];
}

- (void)setupNav{
    // rightItem 帮助页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tex_help"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - contentDelegates

#pragma mark - content Actions

- (void)rightItemClick:(id)sender
{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"进入%@帮助页面",self.title]];
}

- (void)extendBtn:(UIButton *)sender
{
    // 1. 修改样式
    sender.selected = !sender.selected;
    
    XYExtendBtn *extendBtn = nil;
    for (UIView *subView in sender.subviews) {
        if ([subView isKindOfClass:XYExtendBtn.class]) {
            extendBtn = (XYExtendBtn *)subView;
        }
    }
    [extendBtn setFold:!sender.selected];
    
    // 2. 调整约束
    CGFloat realHeight = _bannerLabel.bounds.size.height + 15;
    [sender mas_updateConstraints:^(MASConstraintMaker *make) {
        if (sender.isSelected) { // 展开状态
            make.top.equalTo(_bannerIconView.mas_bottom).offset(realHeight);
        }else
        {
            make.top.equalTo(_bannerIconView.mas_bottom).offset(110); // 默认110文字高度
        }
    }];
}

#pragma mark - privateMethods


#pragma mark - publicMethods




@end
