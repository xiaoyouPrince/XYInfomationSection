//
//  ViewController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import "SectionDemo-Swift.h"

// 此页面为菜单列表页面
/**
 section1 基本使用(一个页面之内)
    -> 只使用 XYInfomationSection
        section 1.1 -> 只有选择类型(无图和accessoryView)
        section 1.2 -> 只有输入类型(无图和accessoryView)
        section 1.3 -> 选择&输入类型(无图和accessoryView)
        section 1.4 -> 选择&输入类型(有图和accessoryView)
        section 1.5 -> 选择&输入&禁用类型(仅供展示)
 
 section2 高级使用举例
     -> 继承自 XYInfomationBaseViewController
         section 2.1 -> 个人中心页面
         section 2.2 -> 用户详细信息页面
         section 2.3 -> 设置页面
 
 section3 综合实例
     -> 继承自 XYInfomationBaseViewController
         section 3.1 -> 添加家庭成员信息
         section 3.2 -> 个人所得税
 
 section4 自定义Cell实例: 需自实现cell
     -> 继承自 XYInfomationBaseViewController
         section 4.1 ->
         section 4.2 ->
         section 4.3 ->
         section 4.4 ->
 */

@interface ViewController ()<UIGestureRecognizerDelegate>

/** 数据 */
@property(nonatomic , strong)     UserModel *userDetailInfo;
/** customContentView */
@property (nonatomic, weak)         UIView * customContentView;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // getContent
    [self setContentView:[self getContentView]];
    
    // new demo for swipe delete, add 2023年 5月25日 星期四 18时41分06秒 CST
    SwipeDemoViewController *swipe = [SwipeDemoViewController new];
    [swipe viewDidLoad];
    [self setFooterView:swipe.contentView edgeInsets:UIEdgeInsetsMake(10, 20, 20, 20)];
    
    
    
}

- (UIView *)buttonWithTitle:(NSString *)title width:(CGFloat)width color:(UIColor *)color {
    
    UIButton *a = [UIButton new];
    [a setTitle:title forState:UIControlStateNormal];
    a.bounds = CGRectMake(0, 0, width, 100);
    a.backgroundColor = color;
    
    [a addTarget:self action:@selector(deleteActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return a;
}

- (UIView *)labelWithTitle:(NSString *)title width:(CGFloat)width color:(UIColor *)color{
    
    UILabel *a = [UILabel new];
    a.text = title;
    a.bounds = CGRectMake(0, 0, width, 100);
    a.backgroundColor = color;
    a.textAlignment = NSTextAlignmentCenter;
    a.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction:)];
    [a addGestureRecognizer:tap];
    return a;
}

- (NSArray<UIView *> *)actionBtns:(int)type{
    
    if (type == 0) {
        UIView *delete = [self buttonWithTitle:@"delete" width:80 color: UIColor.redColor];
        
        UIView *more = [self buttonWithTitle:@"more" width:60 color: UIColor.greenColor];
        
        return @[delete, more];
    }
    
    UIView *delete = [self labelWithTitle:@"delete" width:80 color: UIColor.yellowColor];

    UIView *more = [self labelWithTitle:@"more" width:60 color: UIColor.grayColor];

    return @[delete, more];
}

- (void)realActionWithTitle:(NSString *)title cell:(XYInfomationCell *)cell{
    
    if ([title isEqualToString:@"delete"]) {
        cell.model.fold = YES;
        cell.model = cell.model;// just modify self
        
    }else if ([title isEqualToString:@"more"]) {
        [SVProgressHUD showInfoWithStatus:@"点击了更多, 当前 demo 做复位功能"];
        XYInfomationSection *section = (XYInfomationSection *)cell.superview;
        for (XYInfomationItem *item in section.dataArray) {
            item.fold = NO;
        }
        
        [section unfoldAllCells];
    }
}

- (void)deleteAction:(UITapGestureRecognizer *)tap{
    Console(@"deleteAction -- tap.view.tag = %ld", tap.view.tag);
    
    UILabel *label = (UILabel *)tap.view;
    NSString *title = label.text;
    XYInfomationCell *cell = (XYInfomationCell *)tap.view.superview;
    
    [self realActionWithTitle:title cell:cell];
}

- (void)deleteActionBtn:(UIButton *)sender{
    Console(@"deleteAction -- sender.tag = %ld", sender.tag);

    UIButton *label = (UIButton *)sender;
    NSString *title = label.currentTitle;
    
    XYInfomationCell *cell = (XYInfomationCell *)sender.superview;
    
    [self realActionWithTitle:title cell:cell];
}

#pragma mark - user content all in the blow

- (UIView *)getContentView {
    
    self.title = @"SectionDemo";
    
    [SVProgressHUD setBackgroundColor:UIColor.lightGrayColor];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = HEXCOLOR(0xf6f6f6);
    self.view.backgroundColor = contentView.backgroundColor;
    
    self.userDetailInfo = [DataTool userModel];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"基本使用";
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"高级使用举例";
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"综合使用";
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.text = @"开启试试";
    UISwitch *open = [UISwitch new];
    open.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"open"];
    [open addTarget:self action:@selector(openValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.text = @"自定义示例";
    
    XYInfomationSection *section1 = [XYInfomationSection new];
    XYInfomationSection *section2 = [XYInfomationSection new];
    XYInfomationSection *section3 = [XYInfomationSection new];
    XYInfomationSection *section4 = [XYInfomationSection new];
    XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"基本使用" titleKey:@"BaseUseViewController" type:1 value:@"仅使用XYInfomationSection,自己处理页面内部布局" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item1 = [XYInfomationItem modelWithTitle:@"个人中心页面" titleKey:@"UserCenterViewController" type:1 value:@"基于XYInfomationBaseViewController" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item2 = [XYInfomationItem modelWithTitle:@"用户详细信息页面" titleKey:@"UserInfoViewController" type:1 value:@"基于XYInfomationBaseViewController" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item3 = [XYInfomationItem modelWithTitle:@"设置页面" titleKey:@"SettingViewController" type:1 value:@"基于XYInfomationBaseViewController" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item4 = [XYInfomationItem modelWithTitle:@"添加家庭成员信息" titleKey:@"FamilyMemberListViewController" type:1 value:@"基于XYInfomationBaseViewController" placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item5 = [XYInfomationItem modelWithTitle:@"个人所得税" titleKey:@"XYTaxViewController" type:1 value:@"基于XYInfomationBaseViewController" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item6 = [XYInfomationItem modelWithTitle:@"支付宝" titleKey:@"AlipayViewController" type:XYInfoCellTypeChoose value:@"个人中心页面" placeholderValue:nil disableUserAction:NO];
    XYInfomationItem *item7 = [XYInfomationItem modelWithTitle:@"微信" titleKey:@"WeChatViewController" type:XYInfoCellTypeChoose value:@"隐私设置页面" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item8 = [XYInfomationItem modelWithTitle:@"微博" titleKey:@"WeiboViewController" type:XYInfoCellTypeChoose value:@"设置页面" placeholderValue:nil disableUserAction:YES];
    XYInfomationItem *item9 = [XYInfomationItem modelWithTitle:@"自定义" titleKey:@"SectionDemo.PersonInfoController" type:XYInfoCellTypeChoose value:@"个人信息" placeholderValue:nil disableUserAction:YES];
//    section4.separatorInset = UIEdgeInsetsMake(10, 50, 20, 10);
//    section4.separatorColor = UIColor.yellowColor;
//    section4.backgroundColor = UIColor.redColor;
    
    // 设置 swipe delete 功能
    NSArray *items = @[item,
                       item1,
                       item2,
                       item3,
                       item4,
                       item5,
                       item6,
                       item7,
                       item8,
                       item9];
    for (XYInfomationItem *item in items) {
        XYInfomationItemSwipeConfig *config = [[XYInfomationItemSwipeConfig alloc] init];
        config.canSwipe = YES;
        config.type = 1;
        config.actionBtns = ^NSArray<UIView *> * _Nonnull(XYInfomationCell * _Nonnull cell) {
            
            if (arc4random() % 2){
                return [self actionBtns:0];
            }else{
                return [self actionBtns:1];
            }
        };
        item.swipeConfig = config;
    }
    
    section1.dataArray = @[item];
    section2.dataArray = @[item1,item2,item3];
    section3.dataArray = @[item4,item5];
    section4.dataArray = @[item6,item7,item8,item9];
    
    [contentView addSubview:label1];
    [contentView addSubview:label2];
    [contentView addSubview:label3];
    [contentView addSubview:label4];
    [contentView addSubview:open];
    [contentView addSubview:label5];
    [contentView addSubview:section1];
    [contentView addSubview:section2];
    [contentView addSubview:section3];
    [contentView addSubview:section4];
    
    CGFloat margin = 15;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(25);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    
    [open mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1).offset(0);
        make.right.equalTo(contentView).offset(-15);
    }];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1).offset(0);
        make.right.equalTo(open.mas_left).offset(-15);
    }];
    
    [section1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section1.mas_bottom).offset(2*margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [section2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section2.mas_bottom).offset(2*margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [section3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(section3.mas_bottom).offset(2*margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
    }];
    [section4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label5.mas_bottom).offset(margin);
        make.left.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-15);
        make.bottom.equalTo(contentView.mas_bottom).offset(-25);
    }];
    
    // 点击回调
    NSArray *sections = @[section1,section2,section3,section4];
    section2.customMovableCellwithSnap = ^UIView * _Nonnull(UIImageView * _Nonnull cellSnap) {
        return cellSnap;
    };
    section3.customMovableCellwithSnap = ^UIView * _Nonnull(UIImageView * _Nonnull cellSnap) {
        cellSnap.backgroundColor = UIColor.greenColor;
        cellSnap.layer.shadowColor = [UIColor yellowColor].CGColor;
        cellSnap.layer.masksToBounds = NO;
        cellSnap.layer.cornerRadius = 0;
        cellSnap.layer.shadowOffset = CGSizeMake(-5, 0);
        cellSnap.layer.shadowOpacity = 0.9;
        cellSnap.layer.shadowRadius = 5;
        return cellSnap;
    };
    section4.customMovableCellwithSnap = ^UIView * _Nonnull(UIImageView * _Nonnull cellSnap) {
        UIView *snap = UIView.new;
        snap.backgroundColor = UIColor.systemPinkColor;
        UILabel *label = [[UILabel alloc] init];
        label.text = @"兄弟，把我放哪里啊";
        [snap addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(label.superview);
        }];
        return snap;
    };
    section4.sectionCellHasMoved = ^(XYInfomationSection * _Nonnull section, NSArray * _Nonnull oldData) {
        
        // 模拟耗时操作
        [SVProgressHUD show];
        
        NSLog(@"-------------cellHasMoved-log-begin-----------------");
        NSLog(@"原数据 = %@",oldData);
        NSLog(@"新数据 = %@",section.dataArray);
        NSLog(@"-------------cellHasMoved-log-end-----------------");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                int success = arc4random() % 2;
                if (success) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    NSLog(@"dataArray -修改成功- 新数据 = %@",section.dataArray);
                }else{
                    [SVProgressHUD showErrorWithStatus:@"修改失败"];
                    NSLog(@"dataArray -修改失败- 旧数据 = %@",oldData);
                    [section refreshSectionWithDataArray:oldData];
                }
            });
        });
    };
    
    
    // 测试代码手动移动 cell 位置从 3 -> 0
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"dataArray - before = %@",section4.dataArray);
            [section4 moveCellFrom:3 to:0 completed:^{
                NSLog(@"dataArray - after = %@",section4.dataArray);
            }];
        });
    });
    
    
    for (XYInfomationSection *section in sections) {
        section.editMode = YES;
        section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
            NSLog(@"index = %ld",index);
            [self didClickInfoCell:cell];
        };
    }
    
    self.customContentView = contentView;
    return contentView;
}

- (void)didClickInfoCell:(XYInfomationCell *)cell
{
    UIViewController *detail = [NSClassFromString(cell.model.titleKey) new];
    detail.title = cell.model.title;
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)openValueChanged:(UISwitch *)sender
{
    // NSLog(@"open = %@",sender.isOn?@"开启":@"关闭");
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"open"];
    
    NSMutableArray *sections = @[].mutableCopy;
    for (UIView *view in self.customContentView.subviews) {
        if ([view isKindOfClass:XYInfomationSection.class]) {
            [sections addObject:view];
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        for (XYInfomationSection *section in sections) {
            for (XYInfomationItem *item in section.dataArray) {
                
                if (sender.isOn) {
                    item.titleColor = UIColor.greenColor;
                    item.titleFont = [UIFont systemFontOfSize:19];
                    
                    item.valueColor = [UIColor cyanColor];
                    item.valueFont = [UIFont systemFontOfSize:25];
                    
                    item.placeholderColor = [UIColor redColor];
                    item.placeholderFont = [UIFont systemFontOfSize:15];
                }else
                {
                    item.titleColor = UIColor.blackColor;
                    item.titleFont = [UIFont systemFontOfSize:14];
                    
                    item.valueColor = [UIColor blackColor];
                    item.valueFont = [UIFont systemFontOfSize:14];
                    
                    item.placeholderColor = [UIColor lightGrayColor];
                    item.placeholderFont = [UIFont systemFontOfSize:14];
                }
            }
            section.dataArray = section.dataArray;
        }
    }];
}

@end



