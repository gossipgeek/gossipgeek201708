//
//  SignInViewModel.h
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignInViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface SignInViewModel : NSObject

@property (nonatomic) BOOL onlyTWEmailEnable;

- (NSString *)getErrorDescription:(NSError *)error;
- (NSString *)getEmailTextFieldPlaceHolder;
- (void)signIn:(SignInViewController *)signInVC response:(void (^)(AVUser *user, NSError *error))response;

@end
