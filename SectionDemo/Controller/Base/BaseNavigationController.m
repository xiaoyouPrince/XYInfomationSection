//
//  BaseNavigationController.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/26.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

// 设置nav的字体颜色和大小等
+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[UINavigationController.class]];
    
    // title 的大小和颜色
    NSMutableDictionary *attrs = [NSMutableDictionary new];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     
     系统边缘返回手势
     <UIScreenEdgePanGestureRecognizer: 0x7fdd2be13460; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fdd2bf24140>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fdd2be13120>)>>
     
     系统边缘返回手势的代理的私有类
     <_UINavigationInteractiveTransition: 0x7fdd2be13120>
     */
    
    /// 保留系统默认的 边缘返回手势
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    
    /// 创建一个返回手势添加到self.view上，直接target和action使用系统的target和action
    //    self.interactivePopGestureRecognizer.enabled = NO;
    //    UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    //    edgePan.delegate = self;
    //    [self.view addGestureRecognizer:edgePan];
    //
    //    self.interactivePopGestureRecognizer.enabled = NO;
    
}




- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    NSLog(@"%@ 返回手势",self.childViewControllers.count > 1 ? @"有" : @"没有");
    
    return (self.childViewControllers.count > 0);//有自控制器的时候恢复返回手势
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) { //非rootViewController
        
        // 设置返回按钮
        UIImage *backImage = [[UIImage imageNamed:@"customBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImageView *iv = [[UIImageView alloc] initWithImage:backImage];
        UIControl *backView = [UIControl new];
        [backView addSubview:iv];
        backView.frame = CGRectMake(0, 0, 100, 44);
        iv.frame = CGRectMake(10, (44-backImage.size.height)/2, backImage.size.width, backImage.size.height);
        backView.backgroundColor = UIColor.clearColor;
        [backView addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        
    }
    
    
    if (__autoResetNavBarUntransparent) { // 自动重置navbar透明性
        [self.navigationBar setBackgroundImage:__navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = __navBarShadowImage;
    }
    
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *popVc = [super popViewControllerAnimated:animated];
    
    
    if (__autoResetNavBarUntransparent) { // 自动重置navbar透明性
        [self.navigationBar setBackgroundImage:__navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = __navBarShadowImage;
    }
    
    return popVc;
}


#pragma actions

- (void)setNavBarTransparent
{
    [self setNavBarTransparentWithAutoReset:YES];
}

/// 设置几个变量，处理是否自动管理 navbar 的是否透明操作
static BOOL __autoResetNavBarUntransparent = NO;
static UIImage* __navBarBackgroundImage = nil;
static UIImage* __navBarShadowImage = nil;

- (void)setNavBarTransparentWithAutoReset:(BOOL)autoReset
{
    __autoResetNavBarUntransparent = autoReset;
//    __navBarBackgroundImage = [self.navigationBar valueForKey:@"backgroundImage"];
    __navBarShadowImage = [self.navigationBar valueForKey:@"shadowImage"];
    
    [self.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:UIImage.new];
    self.navigationBar.userInteractionEnabled = YES;
}

@end
