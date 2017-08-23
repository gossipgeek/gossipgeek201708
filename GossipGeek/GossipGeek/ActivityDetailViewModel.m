//
//  ActivityDetailViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 23/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "ActivityDetailViewModel.h"

typedef enum {
    ERROR_NETWORK_NOT_REACHABLE = -1009,
    ERROR_FAILED_TO_CONNECT_SERVER = -1004,
} ACTIVITY_DETAIL_ERROR_CODE;

@implementation ActivityDetailViewModel

- (BOOL)isNetWorkError:(NSError *)error {
    return error.code == ERROR_NETWORK_NOT_REACHABLE;
}

- (BOOL)hasWebHistory:(NSString *)rootUrl whenError:(NSError *)error {
    return [[error.userInfo valueForKey:@"NSErrorFailingURLStringKey"] isEqualToString:rootUrl];
}

- (NSString *)getErrorDescription:(NSError *)error {
    NSString *errorDescription = nil;
    switch (error.code) {
        case ERROR_FAILED_TO_CONNECT_SERVER:
            errorDescription = NSLocalizedString(@"promptFailedToConnectToServer", nil);
            break;
        case ERROR_NETWORK_NOT_REACHABLE:
            errorDescription = NSLocalizedString(@"promptConnectFailed", nil);
            break;
    }
    return errorDescription;
}

@end
