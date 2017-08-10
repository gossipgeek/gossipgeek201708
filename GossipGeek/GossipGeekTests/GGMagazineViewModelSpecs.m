//
//  GGMagazineViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MagazineViewModel.h"
#import <AVOSCloud/AVOSCloud.h>

#define QUICK_DISABLE_SHORT_SYNTAX 1

@import Quick;
@import Nimble;

@interface MagazineViewModel ()

- (BOOL)isContainSameMagazine:(Magazine *)magazine;
@end


QuickSpecBegin(GGMagazineViewModelSpecs)

describe(@"GGModel Specs", ^{
    context(@"isContainSameMagazine", ^{
        
        __block MagazineViewModel *magazineModel = nil;
        
        beforeEach(^{
            magazineModel = [[MagazineViewModel alloc] init];
            Magazine* magazine = [[Magazine alloc] init];
            magazine.url = @"www.123.com";
            [magazineModel.magazines addObject:magazine];
        });
        
        afterEach(^{
            magazineModel = nil;
        });
        
        it(@"should be YES when magazine is exist", ^{
            Magazine* magazine = [[Magazine alloc] init];
            magazine.url = @"www.123.com";

            expect([magazineModel isContainSameMagazine:magazine]).to(equal(YES));
        });
        
        it(@"should be NO when magazine is not exist", ^{
            Magazine* magazine = [[Magazine alloc] init];
            magazine.url = @"www.asd.com";
            
            expect([magazineModel isContainSameMagazine:magazine]).to(equal(NO));
        });
        
    });
});

QuickSpecEnd
