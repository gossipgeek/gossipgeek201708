//
//  SignInViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "SignInViewModel.h"

@implementation SignInViewModel

- (BOOL)getOnlyTWEmailEnable {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"project" ofType:@"plist"];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    BOOL onlyTWEmailEnable = [[plist objectForKey:@"onlyTWEmailEnable"] boolValue];
    return onlyTWEmailEnable;
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
    if (email == NULL || password == NULL) {
        return NO;
    }
    return (![email isEqualToString:nullString] && ![password isEqualToString:nullString]);
}

@end
