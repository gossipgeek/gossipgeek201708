//
//  GGActivitiesCollectionViewCellSpecs.m
//  GossipGeek
//
//  Created by Facheng Liang  on 22/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Activity.h"
#import "ActivitiesCollectionViewCell.h"
@import Quick;
@import Nimble;

#define QUICK_DISABLE_SHORT_SYNTAX 1

QuickSpecBegin(GGActivitiesCollectionViewCellSpecs)

describe(@"GGActivitiesCollectionViewCell Specs", ^{
    context(@"formatTitle", ^{
        
        __block ActivitiesCollectionViewCell *activityCell = nil;
        __block Activity *activity = nil;
        
        beforeEach(^{
            activityCell = [[ActivitiesCollectionViewCell alloc] init];
            activity = [[Activity alloc] init];
        });
        
        afterEach(^{
            activityCell = nil;
            activity = nil;
        });
        
        it(@"should be 【123】456", ^{
            [activity setValue:@"123" forKey:@"location"];
            [activity setValue:@"456" forKey:@"title"];
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@"【123】456"));
        });
        
        it(@"should be 456", ^{
            [activity setValue:nil forKey:@"location"];
            [activity setValue:@"456" forKey:@"title"];
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@"456"));
        });
        
        it(@"should be 456", ^{
            [activity setValue:@"" forKey:@"location"];
            [activity setValue:@"456" forKey:@"title"];
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@"456"));
        });
        
        it(@"should be 【123】", ^{
            [activity setValue:@"123" forKey:@"location"];
            [activity setValue:nil forKey:@"title"];
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@"【123】"));
        });
        
        it(@"should be 【123】", ^{
            [activity setValue:@"123" forKey:@"location"];
            [activity setValue:@"" forKey:@"title"];
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@"【123】"));
        });
        
        it(@"should be null", ^{
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@""));
        });
        
        it(@"should be null", ^{
            [activity setValue:@"" forKey:@"location"];
            [activity setValue:@"" forKey:@"title"];
            NSString *result = [activityCell formatTitle:activity];
            expect(result).to(equal(@""));
        });
        
    });
    
});

QuickSpecEnd
