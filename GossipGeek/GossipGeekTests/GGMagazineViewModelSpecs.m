//
//  GGMagazineViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//
#define QUICK_DISABLE_SHORT_SYNTAX 1
#import <XCTest/XCTest.h>
#import "MagazineViewModel.h"

@import Quick;
@import Nimble;

@interface MagazineViewModel ()

- (BOOL)isTimeOneSmallThanTimeTwo:(NSString*)time1 TimeTwo:(NSString*)time2;

@end


QuickSpecBegin(GGMagazineViewModelSpecs)

describe(@"GGModel Specs", ^{
    context(@"useMagazineTimeToSort", ^{
        
        __block MagazineViewModel *magazineModel = nil;
        
        beforeEach(^{
            magazineModel = [[MagazineViewModel alloc] init];
            
        });
        
        afterEach(^{
            magazineModel = nil;
        });
        
        it(@"should be false when time1 is 2017-03-11 and time2 is 2016-11-12", ^{
            expect([magazineModel isTimeOneSmallThanTimeTwo:@"2017-03-11" TimeTwo:@"2016-11-12"]).to(equal(false));
        });
        
        it(@"should be true when time1 is 2016-03-11 and time2 is 2016-11-12", ^{
            expect([magazineModel isTimeOneSmallThanTimeTwo:@"2016-03-11" TimeTwo:@"2016-11-12"]).to(equal(true));
        });
        
        it(@"should be true when time1 is 2017-03-11 and time2 is 2017-03-11", ^{
            expect([magazineModel isTimeOneSmallThanTimeTwo:@"2017-03-11" TimeTwo:@"2017-03-11"]).to(equal(true));
        });
        
    });
});

QuickSpecEnd
