//
//  GGNSStringAndEmailFormatSpecs.m
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+EmailFormat.h"

#define QUICK_DISABLE_SHORT_SYNTAX 1

@import Quick;
@import Nimble;

QuickSpecBegin(GGNSStringAndEmailFormatSpecs)

describe(@"NSString+EmailFormat Specs", ^{
    context(@"isEmailFormat", ^{
        
        it(@"should return NO when the email is '123456'", ^{
            NSString *email = @"123456";
            BOOL result = [email isEmailFormat];
            expect(result).to(beFalse());
        });
        
        it(@"should return NO when the email is 'test@test'", ^{
            NSString *email = @"test@gmail";
            BOOL result = [email isEmailFormat];
            expect(result).to(beFalse());
        });
        
        it(@"should return NO when the email is '123@gmail.12'", ^{
            NSString *email = @"123@gmail.12";
            BOOL result = [email isEmailFormat];
            expect(result).to(beFalse());
        });
        
        it(@"should return YES when the email is '123@123.com'", ^{
            NSString *email = @"123@123.com";
            BOOL result = [email isEmailFormat];
            expect(result).to(beTrue());
        });
        
        it(@"should return YES when the email is 'test@test.cn'", ^{
            NSString *email = @"liangfc@test.cn";
            BOOL result = [email isEmailFormat];
            expect(result).to(beTrue());
        });
        
        it(@"should return YES when the email is '1_test@test.cn'", ^{
            NSString *email = @"liang_fc@test.cn";
            BOOL result = [email isEmailFormat];
            expect(result).to(beTrue());
        });
        
        
    });
    
    context(@"isTWEmailFormat", ^{
        
        it(@"should return NO when the email is '123@123.com'", ^{
            NSString *email = @"123@123.com";
            BOOL result = [email isTWEmailFormat];
            expect(result).to(beFalse());
        });
        
        it(@"should return NO when the email is 'test'", ^{
            NSString *email = @"test";
            BOOL result = [email isTWEmailFormat];
            expect(result).to(beFalse());
        });
        
        it(@"should return YES when the email is '123@thoughtworks.com'", ^{
            NSString *email = @"123@thoughtworks.com";
            BOOL result = [email isTWEmailFormat];
            expect(result).to(beTrue());
        });
        
    });
    
    context(@"isBothAreNotEmptyStringWithPassword", ^{
        
        it(@"should return NO when the email is @'123' and password is @''", ^{
            NSString *email = @"123";
            NSString *password = @"";
            BOOL result = [email isBothAreNotEmptyStringWithPassword:password];
            expect(result).to(beFalse());
        });
        
        it(@"should return NO when the email is @'' and password is @'123'", ^{
            NSString *email = @"";
            NSString *password = @"123";
            BOOL result = [email isBothAreNotEmptyStringWithPassword:password];
            expect(result).to(beFalse());
        });
        
        it(@"should return NO when the email is @'' and password is @''", ^{
            NSString *email = @"";
            NSString *password = @"";
            BOOL result = [email isBothAreNotEmptyStringWithPassword:password];
            expect(result).to(beFalse());
        });
        
        it(@"should return NO when the email is nil and password is nil", ^{
            NSString *email = nil;
            NSString *password = nil;
            BOOL result = [email isBothAreNotEmptyStringWithPassword:password];
            expect(result).to(beFalse());
        });
        
        it(@"should return YES when the email is @'123' and password is @'123'", ^{
            NSString *email = @"123";
            NSString *password = @"123";
            BOOL result = [email isBothAreNotEmptyStringWithPassword:password];
            expect(result).to(beTrue());
        });
        
    });
    
});

QuickSpecEnd

