//
//  SignInViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "SignInViewModel.h"

typedef enum {
    ERROR_EMAIL_PASSWORD_NOT_MATCH = 210,
    ERROR_ACCOUNT_NOT_EXIST = 211,
    ERROR_EMAIL_NOT_VERIFED = 216,
    ERROR_SIGNIN_LIMIT = 219,
    ERROR_NETWORK_NOT_REACHABLE = -1009,
} SIGNIN_ERROR_CODE;

@implementation SignInViewModel

- (id) init {
    self = [super init];
    self.onlyTWEmailEnable = [self getOnlyTWEmailEnable];
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
    NSString *nullString = @"";
    if (email == nil || password == nil) {
        return NO;
    }
    if ([email isEqualToString:nullString] || [password isEqualToString:nullString]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)getErrorDescription:(NSError *)error {
    NSString *errorDescription = nil;
    switch (error.code) {
        case ERROR_EMAIL_NOT_VERIFED:
            errorDescription = NSLocalizedString(@"SignIn_goEmailVerified", nil);
            break;
        case ERROR_EMAIL_PASSWORD_NOT_MATCH:
            errorDescription = NSLocalizedString(@"SignIn_eamilMismatchPassword", nil);
            break;
        case ERROR_ACCOUNT_NOT_EXIST:
            errorDescription = NSLocalizedString(@"SignIn_userNotExist", nil);
            break;
        case ERROR_SIGNIN_LIMIT:
            errorDescription = NSLocalizedString(@"SignIn_signInLimit", nil);
            break;
        case ERROR_NETWORK_NOT_REACHABLE:
            errorDescription = NSLocalizedString(@"SignIn_networkError", nil);
            break;
        default:
            errorDescription = error.localizedDescription;
    }
    return errorDescription;
}

@end
