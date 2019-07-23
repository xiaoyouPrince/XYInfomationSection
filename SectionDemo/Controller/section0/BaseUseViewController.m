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
#import "BaseNavigationController.h"

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
    label1.text = @"只有输入类型(默认圆角样式)";
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"只有选择类型(基本样式)";
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"设置 imageView";
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"选择&输入类型&自定义accessoryView";
    UILabel *label5 = [[UILabel alloc] init];
    label5.text = @"自定义背景图片";
    
    XYInfomationSection *section1 = [XYInfomationSection new];
    XYInfomationSection *section2 = [XYInfomationSection sectionForOriginal];
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
    
    static NSString *InputTitle = @"要录入字段title";
    static NSString *ChooseTitle = @"要选择字段title";
    
    for (int i = 0; i < 25; i ++){
        XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"自定义标题" titleKey:@" " type:0 value:@"" placeholderValue:nil disableUserAction:YES];
        if (i < 5) {
            item.type = XYInfoCellTypeInput;
            NSString *title = item.type ? ChooseTitle : InputTitle;
            item.title = title;
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
            NSString *title = item.type ? ChooseTitle : InputTitle;
            item.title = title;
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
            NSString *title = item.type ? ChooseTitle : InputTitle;
            item.title = title;
            item.imageName = [NSString stringWithFormat:@"icon_mine_%d",(i-10)%5];
            item.disableUserAction = type;
            
            // 加入数据源
            [array3 addObject:item];
        }
        
        if (i >= 15 && i < 20) {
            int type = arc4random()%2;
            item.type = type;
            NSString *title = item.type ? ChooseTitle : InputTitle;
            item.title = title;
            item.imageName = [NSString stringWithFormat:@"icon_mine_%d",(i-10)%5];
            item.disableUserAction = type;
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
            UISwitch *switc = [UISwitch new];
            item.accessoryView = type ? addBtn : switc;
            
            // 加入数据源
            [array4 addObject:item];
        }
        if (i >= 20 && i < 25) {
            int type = arc4random()%2;
            item.type = type;
            NSString *title = item.type ? ChooseTitle : InputTitle;
            item.title = title;
            item.imageName = [NSString stringWithFormat:@"icon_mine_%d",(i-10)%5];
            item.value = type? @"仅用于展示" : @"";
            item.backgroundImage = ((i-10)%5 == 0)? @"bg_top" : @"bg_middle";
            if ((i-10)%5 == 4) {
                item.backgroundImage = @"bg_bottom";
            }
            
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
    
    NSArray *sections = @[section1,section2,section3,section4,section5];
    __weak typeof(self) weakSelf = self;
    for (XYInfomationSection *section in sections) {
        section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
            [weakSelf sectionCellClicked:cell];
        };
    }
    
    
    [(BaseNavigationController *)self.navigationController setNavBarTransparentWithAutoReset:NO];
    
}


- (void)sectionCellClicked:(XYInfomationCell *)cell{
    
    if (cell.model.type == XYInfoCellTypeInput) {
        // 这里控制键盘弹出，能正常展示到 输入框的下面
        if (cell.model.disableUserAction) {
            [SVProgressHUD showSuccessWithStatus:@"此cell仅用于展示"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"弹出键盘，输入内容"];
        }
    }
    
    if (cell.model.type == XYInfoCellTypeChoose) {
        // 这里控制选择类型的cell,根据cell.model.titleKey去加载要展示的正确数据
        if (cell.model.disableUserAction) {
            [SVProgressHUD showSuccessWithStatus:@"此cell仅用于展示"];
        }else
        {
            [SVProgressHUD showSuccessWithStatus:@"弹出pickerView，选择对应项目值"];
        }
    }
}



@end
