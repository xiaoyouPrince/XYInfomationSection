//
//  BaseUseViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/25.
//  Copyright © 2019 渠晓友. All rights reserved.
//

/// 基础使用示例页面
/**
 section 1 -> 只有选择类型(无图和accessoryView)
 section 2 -> 只有输入类型(无图和accessoryView)
 section 3 -> 选择&输入类型(无图和accessoryView)
 section 4 -> 选择&输入类型(有图和accessoryView)
 section 5 -> 选择&输入&禁用类型(仅供展示)
 */


#import "BaseUseViewController.h"
#import "XYInfomationSection.h"

@interface BaseUseViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWCons;

@end

@implementation BaseUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"只有输入类型";
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"只有选择类型";
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"选择&输入类型";
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"设置 imageView";
    UILabel *label5 = [[UILabel alloc] init];
    label5.text = @"禁用用户事件，仅展示数据";
    
    XYInfomationSection *section1 = [XYInfomationSection new];
    XYInfomationSection *section2 = [XYInfomationSection new];
    XYInfomationSection *section3 = [XYInfomationSection new];
    XYInfomationSection *section4 = [XYInfomationSection new];
    XYInfomationSection *section5 = [XYInfomationSection new];
    
    NSArray *subViews = @[label1,label2,label3,label4,label5,section1,section2,section3,section4,section5];
    for (UIView *subView in subViews) {
        [self.contentView addSubview:subView];
    }
    
    NSMutableArray *array1 = @[].mutableCopy;
    NSMutableArray *array2 = @[].mutableCopy;
    NSMutableArray *array3 = @[].mutableCopy;
    NSMutableArray *array4 = @[].mutableCopy;
    NSMutableArray *array5 = @[].mutableCopy;
    for (int i = 0; i < 25; i ++){
        XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"自定义标题" titleKey:@" " type:0 value:@"" placeholderValue:nil disableUserAction:YES];
        if (i < 5) {
            
            item.type = XYInfoCellTypeInput;
            item.title = @"要录入字段title";
            item.value = @"仅用来展示值，禁用录入";
            
            if ( (i%5) == 1) {
                item.disableUserAction = NO;
                item.value = @"可以用来输入";
            }
            
            if ( (i%5) == 2) {
                item.disableUserAction = NO;
                item.value = @"自定义accessoryView";
                item.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bian"]];
            }
            
            if ( (i%5) == 3) {
                item.disableUserAction = NO;
                item.value = @"默认accessoryView为空,但占空间";
                //item.accessoryView = [UIView new];
            }
            
            if ( (i%5) == 4) {
                item.disableUserAction = NO;
                item.value = @"accessoryView 设置为UIView.new";
                item.accessoryView = [UIView new];
            }
            // 加入数据源
            [array1 addObject:item];
        }
        
        if (i >= 5 && i < 10) {
            item.type = XYInfoCellTypeChoose;
            item.title = @"要选择字段title";
            item.value = @"仅用来展示值，禁用选择";
            
            if ( (i%5) == 1) {
                item.disableUserAction = NO;
                item.value = @"可以用来选择";
            }
            
            if ( (i%5) == 2) {
                item.disableUserAction = NO;
                item.value = @"自定义accessoryView";
                item.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bian"]];
            }
            
            if ( (i%5) == 3) {
                item.disableUserAction = NO;
                item.value = @"默认accessoryView为箭头";
                //item.accessoryView = [UIView new];
            }
            
            if ( (i%5) == 4) {
                item.disableUserAction = NO;
                item.value = @"accessoryView 设置为UIView.new";
                item.accessoryView = [UIView new];
            }
            
            // 加入数据源
            [array2 addObject:item];
        }
        
        if (i >= 10 && i < 15) {
            int type = arc4random()%2;
            item.type = type;
            item.imageName = [NSString stringWithFormat:@"icon_mine_%d",(i-10)%5];
            
            // 加入数据源
            [array3 addObject:item];
        }
        
        if (i >= 15 && i < 20) {
            int type = arc4random()%2;
            item.type = type;
            
            
            // 加入数据源
            [array4 addObject:item];
        }
        if (i >= 20 && i < 25) {
            int type = arc4random()%2;
            item.type = type;
            
            // 加入数据源
            [array5 addObject:item];
        }
    }
    
    section1.dataArray = array1;
    section2.dataArray = array2;
    section3.dataArray = array3;
    section4.dataArray = array4;
    section5.dataArray = array5;
    
    CGFloat margin = 15;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(2*margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section2.mas_bottom).offset(2*margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3.mas_bottom).offset(2*margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section4.mas_bottom).offset(2*margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    [section5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label5.mas_bottom).offset(margin);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    self.contentWCons.constant = UIScreen.mainScreen.bounds.size.width;
    self.contentHCons.constant = CGRectGetMaxY(section5.frame) + 3*margin;
    
}



@end
