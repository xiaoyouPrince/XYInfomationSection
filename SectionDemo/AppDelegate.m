//
//  AppDelegate.m
//  SectionDemo
//
//  Created by 渠晓友 on 2019/6/18.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#define DLog(...) NSLog(@"【%@<第%d行>%s】%@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__LINE__,__FUNCTION__,[NSString stringWithFormat:__VA_ARGS__])
#define XYFunc DLog(@"");

#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // IQKeyboardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
    // 将要注销活跃状态 - 电话，短信，系统控制面板，用户将前台程序退到多任务/后台 都会触发
    
    // 此方法用于暂停执行中的任务，停止计时器，停止绘画渲染回调。游戏需要在此暂停游戏
    
    XYFunc;
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // 程序进入后台 - 用户将App退到后台
    // 用于释放共享资源，保存用户数据，销毁定时器，保存程序当前的状态防止一会被杀死
    
    /// @note 如果 App 支持后台任务，则用户杀死进程的时候会调用此方法而不是：applicationWillTerminate:
    
    XYFunc;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // 从后台进入前台 - 可以注销很多在进入后台时候的操作
    
    XYFunc;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 成功进入前台 - 恢复之前被中止的任务(或者启动之前未启动的任务)，
    // 如果前一个状态是在后台，可以重新刷新用户页面
    
    XYFunc;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 当 App 将要终止，并完全被移出内存的时候会调用此方法。
    // 可以用来做最后的清理工作：释放共享资源，保存数据，移除定时器。
    // 自己的实现中大约有5秒时间来处理最后的工作并返回，如果超过时间任务仍未结束，系统会将未完成的任务一起杀死
    
    /**
     @note
     
     1.对于不支持后台任务的App，或者系统在iOS3.0之前。当用户杀死进程，肯定会调用此方法
     2.对于支持后台任务的App，通常此方法不会调用，当用户杀死进程时，App会短暂的进入后台状态
     3.当App在后台时候(非挂起状态)可能会调用，系统可能会因为一些原因杀死进程
     
     当次方法调用，App还会发送  UIApplicationWillTerminateNotification 通知，让有监听的对象可以进一步处理
     
     */
    
    XYFunc;
}


@end
