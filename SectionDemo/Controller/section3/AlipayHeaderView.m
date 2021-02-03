//
//  AlipayHeaderView.m
//  SectionDemo
//
//  Created by 渠晓友 on 2021/2/3.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "AlipayHeaderView.h"

@interface AlipayHeaderView ()

@end

@implementation AlipayHeaderView

+ (instancetype)viewWithHeaderImage:(NSString *)imageName name:(NSString *)name phone:(NSString *)phone{
    AlipayHeaderView *view = AlipayHeaderView.new;
    view.backgroundColor = UIColor.systemBlueColor;
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [view addSubview:avatar];
    avatar.layer.cornerRadius = 4;
    avatar.layer.borderWidth = 2;
    avatar.layer.borderColor = [UIColor.whiteColor colorWithAlphaComponent:0.8].CGColor;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = name;
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    nameLabel.textColor = UIColor.whiteColor;
    [view addSubview:nameLabel];
    
    UILabel *phoneLabel = [UILabel new];
    phoneLabel.text = phone;
    phoneLabel.font = [UIFont boldSystemFontOfSize:13];
    phoneLabel.textColor = [UIColor.whiteColor colorWithAlphaComponent:0.7];
    [view addSubview:phoneLabel];
    
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.left.equalTo(view).offset(25);
        make.bottom.equalTo(view).offset(-25);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10);
        make.left.equalTo(avatar.mas_right).offset(25);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(7);
        make.left.equalTo(nameLabel);
    }];

    return view;
}

@end
