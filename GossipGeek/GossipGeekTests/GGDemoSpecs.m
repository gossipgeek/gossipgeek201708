//
//  GGDemoSpecs.m
//  GossipGeek
//
//  Created by Yang Luo on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>

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

SPEC_BEGIN(GGDemoSpecs)

describe(@"GGDemo Specs", ^{
    context(@"quoteStringWithString", ^{
        
        __block GGDemo *demo = nil;
        
        beforeAll(^{
            demo = [[GGDemo alloc] init];
        });
        
        afterAll(^{
            demo = nil;
        });
        
        it(@"should be '\"abc\"' when the string is 'abc'", ^{
            NSString *string = @"abc";
            [[[demo quoteStringWithString:string] should] equal:@"\"abc\""];
        });
        
        it(@"should be '\"1111\"' when the string is '1111'", ^{
            NSString *string = @"1111";
            [[[demo quoteStringWithString:string] should] equal:@"\"1111\""];
        });
        
        it(@"should be '\"\"Hello World\"\"' when the string is '\"Hello World\"'", ^{
            NSString *string = @"\"Hello World\"";
            [[[demo quoteStringWithString:string] should] equal:@"\"\"Hello World\"\""];
        });
        
        it(@"should be 'Empty String when' the string is nil", ^{
            [[[demo quoteStringWithString:nil] should] equal:@"Empty String"];
        });
        
        it(@"should be 'Empty String when' the string is ''", ^{
            [[[demo quoteStringWithString:@""] should] equal:@"Empty String"];
        });
        
    });
});

SPEC_END
