//
//  XYTaxBaseCompanyInfoCell.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/11/23.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYTaxBaseCompanyInfoCell.h"

@interface XYTaxBaseCompanyInfoCell ()

@property (weak, nonatomic)  UILabel *companyLabel;
@property (weak, nonatomic)  UILabel *idCodeLabel;
@property (weak, nonatomic)  UILabel *workTimeLabel;
@property (weak, nonatomic)  UIImageView *selIcon;

@end

// 选中的时候，传出自己model
static NSString *cell_sel_noti_name = @"cell_noti_name";
@implementation XYTaxBaseCompanyInfoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupContent];
}


- (void)setupContent{
    
    [self buildUI];
 
    [self addTapGesture];

    [self addNotification];
    
    //self.backgroundColor = UIColor.clearColor; // defalut is whiteColor
    UIImage *image = [UIImage imageNamed:@"tax_water_maker"];
    self.backgroundColor = [UIColor colorWithPatternImage:image];
}


- (void)buildUI{
    
    UILabel *companyLabel = [[UILabel alloc] init];
    [self addSubview:companyLabel];
    self.companyLabel = companyLabel;
    
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
    }];
    
    UILabel *idCodeLabel = [[UILabel alloc] init];
    idCodeLabel.text = @"纳税人识别号:";
    [self addSubview:idCodeLabel];
    self.idCodeLabel = idCodeLabel;
    
    [idCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(15);
    }];
    
    UILabel *workTimeLabel = [[UILabel alloc] init];
    workTimeLabel.text = @"入职时间:";
    [self addSubview:workTimeLabel];
    self.workTimeLabel = workTimeLabel;
    
    [workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(idCodeLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
    }];
    
    UIImageView *selIcon = [UIImageView new];
    selIcon.image = [UIImage imageNamed:@"tax_comp_sel"];
    [self addSubview:selIcon];
    self.selIcon = selIcon;
    
    [selIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
    }];
}


- (XYTaxBaseCompany *)setSelected
{
    // 发通知取消所有其他被选中的 cell 的选中状态
    [kNotificationCenter postNotificationName:cell_sel_noti_name object:nil];
    
    // 设置自己被选中
    self.selIcon.hidden = NO;
    
    _isChoosen = YES;
    
    // 返回对应的model
    return self.model;
}


- (void)addTapGesture{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setSelected)];
    [self addGestureRecognizer:tap];
    
}

- (void)addNotification
{
    [kNotificationCenter addObserverForName:cell_sel_noti_name object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
        self.selIcon.hidden = YES;
        self->_isChoosen = NO;
    }];
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

- (void)setModel:(XYTaxBaseCompany *)model
{
     _model = model;
    
    self.companyLabel.text = model.qymc;
    self.idCodeLabel.text = [self.idCodeLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@",model.nsrsbh]];
    self.workTimeLabel.text = [self.workTimeLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@",model.rzrq]];
}

@end
