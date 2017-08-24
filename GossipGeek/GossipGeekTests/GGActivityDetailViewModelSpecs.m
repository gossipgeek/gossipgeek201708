//
//  GGActivityDetailViewModelSpecs.m
//  GossipGeek
//
//  Created by Facheng Liang  on 24/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ActivityDetailViewModel.h"
@import Quick;
@import Nimble;

#define QUICK_DISABLE_SHORT_SYNTAX 1
typedef enum {
    ERROR_NETWORK_NOT_REACHABLE = -1009,
    ERROR_FAILED_TO_CONNECT_SERVER = -1004,
} ACTIVITY_DETAIL_ERROR_CODE;

QuickSpecBegin(GGActivityDetailViewModelSpecs)

describe(@"GGActivitiesCollectionViewCell Specs", ^{
    context(@"isNetWorkError", ^{
        
        __block ActivityDetailViewModel *activityDetailViewModel = nil;
        __block NSError *error = nil;
        __block NSDictionary *userInfo = nil;
        __block NSErrorDomain errorDomain = nil;
        
        beforeEach(^{
            activityDetailViewModel = [[ActivityDetailViewModel alloc] init];
            errorDomain = @"test";
            userInfo = [NSDictionary dictionaryWithObject:@"test" forKey:@"test"];
        });
        
        afterEach(^{
            activityDetailViewModel = nil;
            error = nil;
            errorDomain = nil;
            userInfo = nil;
        });
        
        it(@"should be YES", ^{
            error = [[NSError alloc] initWithDomain:errorDomain code:-1009 userInfo:userInfo];
            BOOL result = [activityDetailViewModel isNetWorkError:error];
            expect(result).to(beTrue());
        });
        
        it(@"should be NO", ^{
            error = [[NSError alloc] initWithDomain:errorDomain code:200 userInfo:userInfo];
            BOOL result = [activityDetailViewModel isNetWorkError:error];
            expect(result).to(beFalse());
        });
        
        it(@"should be NO", ^{
            BOOL result = [activityDetailViewModel isNetWorkError:error];
            expect(result).to(beFalse());
        });
        
    });
    
    context(@"hasWebHistorywhenError", ^{
        
        __block ActivityDetailViewModel *activityDetailViewModel = nil;
        __block NSError *error = nil;
        __block NSDictionary *userInfo = nil;
        __block NSString *url = nil;
        __block NSErrorDomain errorDomain = nil;

        beforeEach(^{
            activityDetailViewModel = [[ActivityDetailViewModel alloc] init];
            errorDomain = @"test";
        });
        
        afterEach(^{
            activityDetailViewModel = nil;
            error = nil;
            userInfo = nil;
            url = nil;
            errorDomain = nil;
        });
        
        it(@"should be YES", ^{
            userInfo = [NSDictionary dictionaryWithObject:@"https://123.com"
                                                   forKey:@"NSErrorFailingURLStringKey"];
            url = @"https://123.com";
            error = [[NSError alloc] initWithDomain:errorDomain code:1 userInfo:userInfo];
            BOOL result = [activityDetailViewModel hasWebHistory:url whenError:error];
            expect(result).to(beTrue());
        });
        
        it(@"should be NO", ^{
            userInfo = [NSDictionary dictionaryWithObject:@"https://123.com"
                                                   forKey:@"NSErrorFailingURLStringKey"];
            url = @"https://12345.com";
            error = [[NSError alloc] initWithDomain:errorDomain code:1 userInfo:userInfo];
            BOOL result = [activityDetailViewModel hasWebHistory:url whenError:error];
            expect(result).to(beFalse());
        });
        
        it(@"should be NO", ^{
            userInfo = [NSDictionary dictionaryWithObject:@"https://123.com"
                                                   forKey:@"NSErrorFailingURLStringKey"];
            url = @"";
            error = [[NSError alloc] initWithDomain:errorDomain code:1 userInfo:userInfo];
            BOOL result = [activityDetailViewModel hasWebHistory:url whenError:error];
            expect(result).to(beFalse());
        });
        
    });
    
    context(@"getErrorDescription", ^{
        
        __block ActivityDetailViewModel *activityDetailViewModel = nil;
        __block NSError *error = nil;
        __block NSErrorDomain errorDomain = nil;
        __block NSDictionary *userInfo = nil;
        
        beforeEach(^{
            activityDetailViewModel = [[ActivityDetailViewModel alloc] init];
            errorDomain = @"test";
            userInfo = [NSDictionary dictionaryWithObject:@"test" forKey:@"test"];
        });
        
        afterEach(^{
            activityDetailViewModel = nil;
            error = nil;
            errorDomain = nil;
            userInfo = nil;
        });
        
        it(@"should be Localized promptFailedToConnectToServer", ^{
            error = [[NSError alloc] initWithDomain:errorDomain code:-1004 userInfo:userInfo];
            NSString *result = [activityDetailViewModel getErrorDescription:error];
            expect(result).to(equal(NSLocalizedString(@"promptFailedToConnectToServer", nil)));
        });
        
        it(@"should be Localized promptConnectFailed", ^{
            error = [[NSError alloc] initWithDomain:errorDomain code:-1009 userInfo:userInfo];
            NSString *result = [activityDetailViewModel getErrorDescription:error];
            expect(result).to(equal(NSLocalizedString(@"promptConnectFailed", nil)));
        });
        
        it(@"should be nil", ^{
            error = [[NSError alloc] initWithDomain:errorDomain code:200 userInfo:userInfo];
            NSString *result = [activityDetailViewModel getErrorDescription:error];
            expect(result).to(beNil());
        });
        
    });    
    
});

QuickSpecEnd
