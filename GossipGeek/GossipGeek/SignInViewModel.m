//
//  SignInViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "SignInViewModel.h"
#import "NSString+EmailFormat.h"
#import "MBProgressHUD+ShowTextHud.h"

typedef enum {
    ERROR_EMAIL_PASSWORD_NOT_MATCH = 210,
    ERROR_ACCOUNT_NOT_EXIST = 211,
    ERROR_EMAIL_NOT_VERIFED = 216,
    ERROR_SIGNIN_LIMIT = 219,
    ERROR_NETWORK_NOT_REACHABLE = -1009,
} SIGNIN_ERROR_CODE;

@implementation SignInViewModel

- (id)init {
    if (self = [super init]) {
        self.onlyTWEmailEnable = [NSString getOnlyTWEmailEnable];
    }
    return self;
}

- (NSString *)getErrorDescription:(NSError *)error {
    NSString *errorDescription = nil;
    switch (error.code) {
        case ERROR_EMAIL_NOT_VERIFED:
            errorDescription = NSLocalizedString(@"promptGoEmailVerified", nil);
            break;
        case ERROR_EMAIL_PASSWORD_NOT_MATCH:
            errorDescription = NSLocalizedString(@"promptEamilMismatchPassword", nil);
            break;
        case ERROR_ACCOUNT_NOT_EXIST:
            errorDescription = NSLocalizedString(@"promptUserNotExist", nil);
            break;
        case ERROR_SIGNIN_LIMIT:
            errorDescription = NSLocalizedString(@"promptSignInLimit", nil);
            break;
        case ERROR_NETWORK_NOT_REACHABLE:
            errorDescription = NSLocalizedString(@"promptNetworkError", nil);
            break;
        default:
            errorDescription = error.localizedDescription;
    }
    return errorDescription;
}

- (NSString *)getEmailTextFieldPlaceHolder {
    return self.onlyTWEmailEnable ? NSLocalizedString(@"titleInputTWEmail", nil)
                                  : NSLocalizedString(@"titleEmail", nil);
}

- (void)signIn:(SignInViewController *)signInVC response:(void (^)(AVUser *user, NSError *error))response {
    [AVUser logInWithUsernameInBackground:signInVC.emailTextField.text
                                 password:signInVC.passwordTextField.text block:response];
}

@end
