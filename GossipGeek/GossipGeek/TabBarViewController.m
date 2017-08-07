//
//  TabBarViewController.m
//  GossipGeek
//
//  Created by Facheng Liang  on 04/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "TabBarViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SignInViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Reachability/Reachability.h>


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self detectNetwork];
    [self verifiedSessionToken];
}

- (void) verifiedSessionToken {
    AVUser *currentUser = [AVUser currentUser];
    NSString *sessionToken = currentUser.sessionToken;
    [AVUser becomeWithSessionTokenInBackground:sessionToken
                                         block:^(AVUser *user, NSError *error) {
                                             if (!error) {
                                                 NSLog(@"User did login with session token.");
                                             }
                                             else {
                                                 AVUser *currentUser = [AVUser currentUser];
                                                 if (currentUser.sessionToken == nil) {
                                                     [self performSegueWithIdentifier:@"fromHomePageToSignIn" sender:nil];
                                                 }
                                             }
                                         }];
}

- (void)detectNetwork {
    Reachability *reachability = [Reachability reachabilityWithHostName:@"https://leancloud.cn"];
    if([reachability currentReachabilityStatus] == NotReachable) {
        [self showHud:NSLocalizedString(@"SignIn_networkError", nil)];
    }
}

- (void)showHud:(NSString *) error {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = error;
    [hud hideAnimated:YES afterDelay:2.f];
}

@end
