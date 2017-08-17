//
//  SignUpViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "SignUpViewModel.h"
#import "NSString+EmailFormat.h"
#import "MBProgressHUD+ShowTextHud.h"

typedef enum {
    ERROR_EMAIL_ALREADY_OCCUPIED = 203,
    ERROR_NETWORK_NOT_REACHABLE = -1009,
} SIGNUP_ERROR_CODE;

@implementation SignUpViewModel

- (id)init {
    if (self = [super init]) {
        self.onlyTWEmailEnable = [NSString getOnlyTWEmailEnable];
    }
    return self;
}

- (NSString *)getErrorDescription:(NSError *)error {
    NSString *errorDescription = nil;
    switch (error.code) {
        case ERROR_EMAIL_ALREADY_OCCUPIED:
            errorDescription = NSLocalizedString(@"promptEmailAlreadyOccupied", nil);
            break;
        case ERROR_NETWORK_NOT_REACHABLE:
            errorDescription = NSLocalizedString(@"promptNetworkError", nil);
            break;
        default:
            errorDescription = error.localizedDescription;
    }
    return errorDescription;
}

- (AVUser *)setUserInfoWithEmial:(NSString *)email andPassword:(NSString *)password {
    AVUser *user = [AVUser user];
    user.email = email;
    user.password = password;
    user.username = email;
    return user;
}

- (NSString *)getEmailTextFieldPlaceHolder {
    NSString *placeHolder =  self.onlyTWEmailEnable ? NSLocalizedString(@"titleInputTWEmail", nil) : NSLocalizedString(@"titleEmail", nil);
    return placeHolder;
}

- (void)signUp:(SignUpViewController *)signUpVC response:(void (^)(BOOL succeeded, NSError *error))response {
    AVUser *user = [self setUserInfoWithEmial:signUpVC.emailTextField.text
                                  andPassword:signUpVC.passwordTextField.text];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded) {
            NSLog(@"sign up succeeded");
            //注册成功后leadCloud会保存currentUser
            //因为要求邮箱必须验证才能登录，所以这里清空currentUser缓存
            [AVUser logOut];
        } else {
            NSLog(@"sign up faield, %@",error);
        }
        response(succeeded, error);
    }];
}

@end
