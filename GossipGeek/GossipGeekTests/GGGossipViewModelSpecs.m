//
//  GGGossipViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GossipViewModel.h"
#import <AVOSCloud/AVOSCloud.h>

#define QUICK_DISABLE_SHORT_SYNTAX 1

@import Quick;
@import Nimble;

@interface GossipViewModel ()
- (BOOL)isContainSameGossip:(Gossip *)gossip;
@end


QuickSpecBegin(GGGossipViewModelSpecs)

describe(@"GGModel Specs", ^{
    context(@"isContainSameGossip", ^{
        
        __block GossipViewModel *gossipModel = nil;
        
        beforeEach(^{
            gossipModel = [[GossipViewModel alloc] init];
            Gossip* gossip = [[Gossip alloc] init];
            gossip.objectId = @"12321asdsa";
            [gossipModel.gossips addObject:gossip];
        });
        
        afterEach(^{
            gossipModel = nil;
        });
        
        it(@"should be YES when gossip is exist", ^{
            Gossip* gossip = [[Gossip alloc] init];
            gossip.objectId = @"12321asdsa";
            BOOL result = [gossipModel isContainSameGossip:gossip];
            expect(result).to(equal(YES));
        });
        
        it(@"should be NO when gossip is not exist", ^{
            Gossip* gossip = [[Gossip alloc] init];
            gossip.objectId = @"fgggggg";
            BOOL result = [gossipModel isContainSameGossip:gossip];
            expect(result).to(equal(NO));
        });
        
    });
});

QuickSpecEnd
