//
//  GGDemoSpecs.m
//  GossipGeek
//
//  Created by Yang Luo on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>

#define QUICK_DISABLE_SHORT_SYNTAX 1

@import Quick;
@import Nimble;

@interface GGDemo : NSObject

- (NSString *)quoteStringWithString:(NSString *) string;

@end

@implementation GGDemo

- (NSString *)quoteStringWithString:(NSString *) string {
    
    if (string != nil && string.length >0) {
        return [NSString stringWithFormat:@"\"%@\"", string];
    }
    
    return @"Empty String";
}

@end

QuickSpecBegin(GGDemoSpecs)

describe(@"GGDemo Specs", ^{
    context(@"quoteStringWithString", ^{
        
        __block GGDemo *demo = nil;
        
        beforeEach(^{
            demo = [[GGDemo alloc] init];
        });
        
        afterEach(^{
            demo = nil;
        });
        
        it(@"should be '\"abc\"' when the string is 'abc'", ^{
            NSString *string = @"abc";
            expect([demo quoteStringWithString:string]).to(equal(@"\"abc\""));
        });
        
        it(@"should be '\"1111\"' when the string is '1111'", ^{
            NSString *string = @"1111";
            expect([demo quoteStringWithString:string]).to(equal(@"\"1111\""));
        });
        
        it(@"should be '\"\"Hello World\"\"' when the string is '\"Hello World\"'", ^{
            NSString *string = @"\"Hello World\"";
            expect([demo quoteStringWithString:string]).to(equal(@"\"\"Hello World\"\""));
        });
        
        it(@"should be 'Empty String when' the string is nil", ^{
            expect([demo quoteStringWithString:nil]).to(equal(@"Empty String"));
        });
        
        it(@"should be 'Empty String when' the string is ''", ^{
            expect([demo quoteStringWithString:@""]).to(equal(@"Empty String"));
        });
        
    });
});

QuickSpecEnd
