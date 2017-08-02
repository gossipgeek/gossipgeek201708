//
//  AppDelegate.m
//  GossipGeek
//
//  Created by cozhang  on 01/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>

#define APP_ID @"NvYIsxK8CR8DPgETCjsW8bTH-gzGzoHsz"
#define APP_KEY @"0hfEA0BynwXUi2Couw2gPnks"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [AVOSCloud setApplicationId:APP_ID clientKey:APP_KEY];
    //开启 SDK 的调试日志（debug log）,方便追踪问题。调试日志开启后，SDK 会把网络请求、错误消息等信息输出到 IDE 的日志窗口
    [AVOSCloud setAllLogsEnabled:YES];
    //跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}


- (void)applicationWillTerminate:(UIApplication *)application {
  
}


@end
