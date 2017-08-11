//
//  SignInViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "SignInViewModel.h"
#import "SignInViewController.h"

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
        self.onlyTWEmailEnable = [self getOnlyTWEmailEnable];
    }
    return self;
}

- (BOOL)getOnlyTWEmailEnable {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"project" ofType:@"plist"];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [[plist objectForKey:@"onlyTWEmailEnable"] boolValue];
}

- (BOOL)isEmailFormat:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isTWEmailFormat:(NSString *)email {
    NSString *twEmailRegex = @"[A-Z0-9a-z._%+-]+@thoughtworks.com";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", twEmailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isBothAreNotEmptyStringWithEmail:(NSString *)email andPassword:(NSString *)password {
    return (email.length > 0) && (password.length > 0);
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
    NSString *placeHolder =  self.onlyTWEmailEnable ? NSLocalizedString(@"titleInputTWEmail", nil) : NSLocalizedString(@"titleEmail", nil);
    return placeHolder;
}

@end
