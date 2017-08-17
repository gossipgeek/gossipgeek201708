//
//  NSString+EmailFormat.m
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "NSString+EmailFormat.h"

@implementation NSString (EmailFormat)

- (BOOL)isEmailFormat {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isTWEmailFormat {
    NSString *twEmailRegex = @"[A-Z0-9a-z._%+-]+@thoughtworks.com";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", twEmailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isBothAreNotEmptyStringWithPassword:(NSString *)password {
    return (self.length > 0) && (password.length > 0);
}

+ (BOOL)getOnlyTWEmailEnable {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"project" ofType:@"plist"];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [[plist objectForKey:@"onlyTWEmailEnable"] boolValue];
}

@end
