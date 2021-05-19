//
//  XYInfomationSwitchCell.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/5/19.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYInfomationSwitchCell.h"

@implementation XYInfomationSwitchCell
{
    UISwitch *_switch;
}

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        _switch = [UISwitch new];
        [_switch addTarget:self action:@selector(switchHasChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_switch];
    }
    return self;
}

- (void)switchHasChange:(UISwitch*)sender{
    self.model.on = sender.isOn;
    
    // 向上传递事件，告知被点击了
    if (self.cellTouchBlock) {
        self.cellTouchBlock(self);
    }
    
}

- (void)setModel:(XYInfomationItem *)model{
    model.accessoryView = _switch;
    [super setModel:model];
    _switch.on = model.isOn;
    self.backgroundColor = UIColor.clearColor;
}


@end
