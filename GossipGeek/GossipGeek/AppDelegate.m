//
//  AppDelegate.m
//  GossipGeek
//
//  Created by cozhang  on 01/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SignInViewController.h"

#import "Magazine.h"
#import "UserMagazineLike.h"
#import "GGUserGossipLike.h"
#import "Gossip.h"
#import "Activity.h"
#import "GossipViewController.h"
#import <UserNotifications/UserNotifications.h>

#define APP_ID @"NvYIsxK8CR8DPgETCjsW8bTH-gzGzoHsz"
#define APP_KEY @"0hfEA0BynwXUi2Couw2gPnks"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Magazine registerSubclass];
    [UserMagazineLike registerSubclass];
    [Gossip registerSubclass];
    [GGUserGossipLike registerSubclass];
    [Activity registerSubclass];
    
    [AVOSCloud setApplicationId:APP_ID clientKey:APP_KEY];
    //开启 SDK 的调试日志（debug log）,方便追踪问题。调试日志开启后，SDK 会把网络请求、错误消息等信息输出到 IDE 的日志窗口
    [AVOSCloud setAllLogsEnabled:YES];
    //跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    static NSString *homePageIdentifier = @"homePage";
    static NSString *storyBoardIdentifier = @"Main";
    UIViewController *homePage = [self getViewControllerWithIdentifier:homePageIdentifier
                                                     andStoryBoardName:storyBoardIdentifier];
    [self.window setRootViewController:homePage];
    [self verifiedSessionToken];
    
    [self registerForRemoteNotification];
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    [AVOSCloud handleRemoteNotificationsWithDeviceToken:deviceToken];
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

- (void)verifiedSessionToken {
    AVUser *currentUser = [AVUser currentUser];
    NSString *sessionToken = currentUser.sessionToken;
    [AVUser becomeWithSessionTokenInBackground:sessionToken
                                         block:^(AVUser *user, NSError *error) {
                                             if (!error) {
                                                 NSLog(@"User did login with session token.");
                                             } else {
                                                 if (sessionToken == nil) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self.window.rootViewController performSegueWithIdentifier:@"fromHomePageToSignIn" sender:nil];
                                                     });
                                                 }
                                             }
                                         }];
}

- (UIViewController *)getViewControllerWithIdentifier:(NSString *)identifier andStoryBoardName:(NSString *)storyBoardName {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = (UIViewController *)[storyBoard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

- (void)registerForRemoteNotification {
    // iOS10 兼容
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];
        [uncenter setDelegate:self];
        //iOS10 使用以下方法注册，才能得到授权
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                                }];
        // 获取当前的通知授权状态, UNNotificationSettings
        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                NSLog(@"未选择");
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                NSLog(@"未授权");
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                NSLog(@"已授权");
            }
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
#pragma clang diagnostic pop
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self switchViewController:userInfo];
    }
    completionHandler();
}

- (void)switchViewController:(NSDictionary *)userInfo {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    NSArray *viewControllers = tabBarController.viewControllers;
    if ([[userInfo objectForKey:@"pageName"] isEqualToString:NSLocalizedString(@"titleGossipTitle", nil)]) {
        for (UIViewController *item in viewControllers) {
            if ([item isKindOfClass:[UINavigationController class]]) {
                if ([((UINavigationController *)item).topViewController isKindOfClass:[GossipViewController class]]) {
                    [tabBarController setSelectedViewController:item];
                    break;
                }
            }
        }
    }
}

@end
