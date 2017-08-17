//
//  SignUpViewModel.h
//  GossipGeek
//
//  Created by Facheng Liang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import "SignUpViewController.h"

@interface SignUpViewModel : NSObject

@property (nonatomic) BOOL onlyTWEmailEnable;
- (NSString *)getErrorDescription:(NSError *)error;
- (AVUser *)setUserInfoWithEmial:(NSString *)email andPassword:(NSString *)password;
- (NSString *)getEmailTextFieldPlaceHolder;
- (void)signUp:(SignUpViewController *)signUpVC response:(void (^)(BOOL succeeded, NSError *error))response;

@end
