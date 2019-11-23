//
//  XYTaxBaseBottomView.m
//  DemoPersonalTax
//
//  Created by 渠晓友 on 2018/12/20.
//  Copyright © 2018年 渠晓友. All rights reserved.
//

#import "XYTaxBaseBottomView.h"

@interface XYTaxBaseBottomView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation XYTaxBaseBottomView

static BOOL chooseOrNot = NO;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = XYColor(240, 242, 250);
    
    
    // 默认自己未选中的
    self.iconView.image = [UIImage imageNamed:@"icon_tax_unchoose"];
    
    chooseOrNot = NO;
    
}




- (IBAction)agreeBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.iconView.image = [UIImage imageNamed:@"icon_tax_choose"];
        
        chooseOrNot = YES;
        
    }else
    {
        self.iconView.image = [UIImage imageNamed:@"icon_tax_unchoose"];
        
        chooseOrNot = NO;
    }
}



- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    
    if (!chooseOrNot) {

        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请确认对自己提交材料真实性负责" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];

    }else
    {
        if (self.block) {
            self.block();
        }
    }
    
}

+ (instancetype)bottomView
{
    XYTaxBaseBottomView *instance = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    return instance;
}



@end
