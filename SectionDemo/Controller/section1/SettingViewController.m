//
//  SettingViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/20.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.headerView = addBtn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
