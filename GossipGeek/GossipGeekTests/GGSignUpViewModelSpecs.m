//
//  GGSignUpViewModelSpecs.m
//  GossipGeek
//
//  Created by Facheng Liang  on 15/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SignUpViewModel.h"

#define QUICK_DISABLE_SHORT_SYNTAX 1

@import Quick;
@import Nimble;

QuickSpecBegin(GGSignUpViewControllerSpecs)

describe(@"SignUpViewModel Specs", ^{
    context(@"isEmailFormat", ^{
        
        __block SignUpViewModel *signUpViewModel = nil;
        
        beforeEach(^{
            signUpViewModel = [[SignUpViewModel alloc] init];
        });
        
        afterEach(^{
            signUpViewModel = nil;
        });
        
        it(@"should return NO when the email is '18829042843'", ^{
            NSString *email = @"18829042843";
            expect([signUpViewModel isEmailFormat:email]).to(equal(NO));
        });
        
        it(@"should return NO when the email is 'liangfc@gmail'", ^{
            NSString *email = @"liangfc@gmail";
            expect([signUpViewModel isEmailFormat:email]).to(equal(NO));
        });
        
        it(@"should return NO when the email is 'liangfc@gmail.12'", ^{
            NSString *email = @"liangfc@gmail.12";
            expect([signUpViewModel isEmailFormat:email]).to(equal(NO));
        });
        
        it(@"should return YES when the email is '18829042843@163.com'", ^{
            NSString *email = @"18829042843@163.com";
            expect([signUpViewModel isEmailFormat:email]).to(equal(YES));
        });
        
        it(@"should return YES when the email is 'liangfc@xiangov.cn'", ^{
            NSString *email = @"liangfc@xiangov.cn";
            expect([signUpViewModel isEmailFormat:email]).to(equal(YES));
        });
        
        it(@"should return YES when the email is 'liang_fc@xiangov.cn'", ^{
            NSString *email = @"liang_fc@xiangov.cn";
            expect([signUpViewModel isEmailFormat:email]).to(equal(YES));
        });
        
        
    });
    
    context(@"isTWEmailFormat", ^{
        
        __block SignUpViewModel *signUpViewModel = nil;
        
        beforeEach(^{
            signUpViewModel = [[SignUpViewModel alloc] init];
        });
        
        afterEach(^{
            signUpViewModel = nil;
        });
        
        it(@"should return NO when the email is '18829042843@163.com'", ^{
            NSString *email = @"18829042843@163.com";
            expect([signUpViewModel isTWEmailFormat:email]).to(beFalse());
        });
        
        it(@"should return NO when the email is '18829042843'", ^{
            NSString *email = @"18829042843";
            expect([signUpViewModel isTWEmailFormat:email]).to(beFalse());
        });
        
        it(@"should return YES when the email is '18829042843@thoughtworks.com'", ^{
            NSString *email = @"18829042843@thoughtworks.com";
            expect([signUpViewModel isTWEmailFormat:email]).to(beTrue());
        });
        
        it(@"should return YES when the email is 'fcliang@thoughtworks.com'", ^{
            NSString *email = @"fcliang@thoughtworks.com";
            expect([signUpViewModel isTWEmailFormat:email]).to(beTrue());
        });
        
    });
    
    context(@"isBothAreNotEmptyStringWithEmailandPassword", ^{
        
        __block SignUpViewModel *signUpViewModel = nil;
        
        beforeEach(^{
            signUpViewModel = [[SignUpViewModel alloc] init];
        });
        
        afterEach(^{
            signUpViewModel = nil;
        });
        
        it(@"should return NO when the email is @'123' and password is @''", ^{
            NSString *email = @"123";
            NSString *password = @"";
            expect([signUpViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return NO when the email is @'' and password is @'123'", ^{
            NSString *email = @"";
            NSString *password = @"123";
            expect([signUpViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return NO when the email is @'' and password is @''", ^{
            NSString *email = @"";
            NSString *password = @"";
            expect([signUpViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return NO when the email is nil and password is nil", ^{
            NSString *email = nil;
            NSString *password = nil;
            expect([signUpViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beFalse());
        });
        
        it(@"should return YES when the email is @'123' and password is @'123'", ^{
            NSString *email = @"123";
            NSString *password = @"123";
            expect([signUpViewModel isBothAreNotEmptyStringWithEmail:email andPassword:password]).to(beTrue());
        });
        
    });
    
});

QuickSpecEnd
