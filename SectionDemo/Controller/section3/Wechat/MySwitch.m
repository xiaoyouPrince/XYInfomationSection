//
//  MySwitch.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/4.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "MySwitch.h"

@implementation MySwitch

- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(changeSeting:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)changeSeting:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:self.settingKey];
}

@end
