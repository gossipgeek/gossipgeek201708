//
//  GGActivityViewModelSpecs.m
//  GossipGeek
//
//  Created by Facheng Liang  on 20/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ActivityViewModel.h"
#import "Activity.h"
@import Quick;
@import Nimble;

#define QUICK_DISABLE_SHORT_SYNTAX 1

QuickSpecBegin(GGActivityViewModelSpecs)

describe(@"GGActivityViewModel Specs", ^{
    context(@"isItemExistInActivities", ^{
        
        __block ActivityViewModel *activityViewModel = nil;
        __block Activity *activity = nil;
        
        beforeEach(^{
            activityViewModel = [[ActivityViewModel alloc] init];
            activity = [[Activity alloc] init];
        });
        
        afterEach(^{
            activityViewModel = nil;
            activity = nil;
        });
        
        it(@"should be YES", ^{
            [activity setValue:@"123" forKey:@"objectId"];
            [activityViewModel.activities addObject:activity];
            Activity *item = [[Activity alloc] init];
            [item setValue:@"123" forKey:@"objectId"];
            BOOL result = [activityViewModel isItemExist:item inActivities:activityViewModel.activities];
            expect(result).to(beTrue());
        });
        
        it(@"should be NO", ^{
            [activity setValue:@"123" forKey:@"objectId"];
            [activityViewModel.activities addObject:activity];
            Activity *item = [[Activity alloc] init];
            [item setValue:@"456" forKey:@"objectId"];
            BOOL result = [activityViewModel isItemExist:item inActivities:activityViewModel.activities];
            expect(result).to(beFalse());
        });
        
        it(@"should be NO", ^{
            Activity *item = [[Activity alloc] init];
            [item setValue:@"456" forKey:@"objectId"];
            BOOL result = [activityViewModel isItemExist:item inActivities:activityViewModel.activities];
            expect(result).to(beFalse());
        });
        
        it(@"should be NO", ^{
            [activity setValue:@"123" forKey:@"objectId"];
            [activityViewModel.activities addObject:activity];
            Activity *item = [[Activity alloc] init];
            BOOL result = [activityViewModel isItemExist:item inActivities:activityViewModel.activities];
            expect(result).to(beFalse());
        });
        
    });
});

QuickSpecEnd

