//
//  GGSignInViewControllerSpecs.m
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#define QUICK_DISABLE_SHORT_SYNTAX 1

#import <XCTest/XCTest.h>
#import "SignInViewModel.h"

@import Quick;
@import Nimble;

QuickSpecBegin(GGSignInViewControllerSpecs)

describe(@"SignInViewModel Specs", ^{
    context(@"isEmailFormat", ^{
        
        __block SignInViewModel *signInViewModel = nil;
        
        beforeEach(^{
            signInViewModel = [[SignInViewModel alloc] init];
        });
        
        afterEach(^{
            signInViewModel = nil;
        });
        
        it(@"should return NO when the email is '18829042843'", ^{
            NSString *email = @"18829042843";
            expect([signInViewModel isEmailFormat:email]).to(equal(NO));
        });
        
        it(@"should return NO when the email is 'liangfc@gmail'", ^{
            NSString *email = @"liangfc@gmail";
            expect([signInViewModel isEmailFormat:email]).to(equal(NO));
        });
        
        it(@"should return NO when the email is 'liangfc@gmail.12'", ^{
            NSString *email = @"liangfc@gmail.12";
            expect([signInViewModel isEmailFormat:email]).to(equal(NO));
        });
        
        it(@"should return YES when the email is '18829042843@163.com'", ^{
            NSString *email = @"18829042843@163.com";
            expect([signInViewModel isEmailFormat:email]).to(equal(YES));
        });
        
        it(@"should return YES when the email is 'liangfc@xiangov.cn'", ^{
            NSString *email = @"liangfc@xiangov.cn";
            expect([signInViewModel isEmailFormat:email]).to(equal(YES));
        });
        
        it(@"should return YES when the email is 'liang_fc@xiangov.cn'", ^{
            NSString *email = @"liang_fc@xiangov.cn";
            expect([signInViewModel isEmailFormat:email]).to(equal(YES));
        });
        
            
    });
    
    context(@"isTWEmailFormat", ^{
        
        __block SignInViewModel *signInViewModel = nil;
        
        beforeEach(^{
            signInViewModel = [[SignInViewModel alloc] init];
        });
        
        afterEach(^{
            signInViewModel = nil;
        });
        
        it(@"should return NO when the email is '18829042843@163.com'", ^{
            NSString *email = @"18829042843@163.com";
            expect([signInViewModel isTWEmailFormat:email]).to(beFalse());
        });
        
        it(@"should return NO when the email is '18829042843'", ^{
            NSString *email = @"18829042843";
            expect([signInViewModel isTWEmailFormat:email]).to(beFalse());
        });
        
        it(@"should return YES when the email is '18829042843@thoughtworks.com'", ^{
            NSString *email = @"18829042843@thoughtworks.com";
            expect([signInViewModel isTWEmailFormat:email]).to(beTrue());
        });
        
        it(@"should return YES when the email is 'fcliang@thoughtworks.com'", ^{
            NSString *email = @"fcliang@thoughtworks.com";
            expect([signInViewModel isTWEmailFormat:email]).to(beTrue());
        });
        
    });
    
    context(@"isBothAreNotEmptyStringWithEmailandPassword", ^{
        
        __block SignInViewModel *signInViewModel = nil;
        
        beforeEach(^{
            signInViewModel = [[SignInViewModel alloc] init];
        });
        
        afterEach(^{
            signInViewModel = nil;
        });
        
        it(@"should return NO when the email is @'123' and password is @''", ^{
            NSString *email = @"123";
            NSString *password = @"";
            expect([signInViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return NO when the email is @'' and password is @'123'", ^{
            NSString *email = @"";
            NSString *password = @"123";
            expect([signInViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return NO when the email is @'' and password is @''", ^{
            NSString *email = @"";
            NSString *password = @"";
            expect([signInViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return NO when the email is nil and password is nil", ^{
            NSString *email = nil;
            NSString *password = nil;
            expect([signInViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return YES when the email is @'123' and password is @'123'", ^{
            NSString *email = @"123";
            NSString *password = @"123";
            expect([signInViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beTrue());
        });

    });

});

QuickSpecEnd

