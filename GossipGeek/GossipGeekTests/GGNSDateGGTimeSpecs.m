//
//  GGNSDateGGTimeSpecs.m
//  GossipGeek
//
//  Created by cozhang  on 18/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "NSDate+GGTime.h"
@import XCTest;
@import AVOSCloud;
@import Foundation;
@import Quick;
@import Nimble;

#define QUICK_DISABLE_SHORT_SYNTAX 1

QuickSpecBegin(GGNSDateGGTimeSpecs)

describe(@"GGCategory Specs", ^{
    context(@"compareYear", ^{
        
        __block NSDateFormatter *formatter = nil;
        
        beforeEach(^{
            formatter = [[NSDateFormatter alloc] init];
        });
        
        afterEach(^{
            formatter = nil;
        });
        
        it(@"should be same when other date year equal current year", ^{
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *other = [formatter dateFromString:@"2017-03-11"];
            NSComparisonResult result = [[NSDate date] compareYear:other];
            expect((long)result).to(equal(NSOrderedSame));
        });
        
        it(@"should be less when other date year less than current year", ^{
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *other = [formatter dateFromString:@"2016-03-11"];
            NSComparisonResult result = [[NSDate date] compareYear:other];
            expect((long)result).to(equal(NSOrderedDescending));
        });
        
        it(@"should be more when other date year more than current year", ^{
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *other = [formatter dateFromString:@"2018-03-11"];
            NSComparisonResult result = [[NSDate date] compareYear:other];
            expect((long)result).to(equal(NSOrderedAscending));
        });
        
    });
});

QuickSpecEnd
