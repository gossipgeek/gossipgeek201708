//
//  GossipViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GossipViewModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "GGUserGossipLike.h"

@implementation GossipViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        self.gossips = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)fetchAVObjectData:(void (^)(int newGossipCount,NSError *error))block {
    AVQuery *query = [AVQuery queryWithClassName:@"Gossip"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"content"];
    [query includeKey:@"title"];
    [query includeKey:@"time"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        int newGossipCount = 0;
        if (!error) {
            newGossipCount = [self updateGossips:objects];
            if (self.gossips.count > 0) {
                [self updateGossipsLikeNumber:self.gossips newGossipCount:newGossipCount fetchAVObject:block];
                return;
            }
        }
        block(newGossipCount,error);        
    }];
}

-(void)addGossipModel:(Gossip *)gossip {
    [self.gossips addObject:gossip];
}

- (int)updateGossips:(NSArray *) gossipAVObjects {
    int newGossipCount = 0;
    for (Gossip *item in gossipAVObjects) {
        if (![self isContainSameGossip:item]) {
            newGossipCount++;
        }
    }
    [self.gossips removeAllObjects];
    for (Gossip *item in gossipAVObjects) {
        [self addGossipModel:item];
    }
    return newGossipCount;
}

- (void)updateGossipsLikeNumber:(NSMutableArray *) gossips newGossipCount:(int) newGossipCount fetchAVObject:(void (^)(int newGossipCount,NSError *error))block {
    for (Gossip *item in gossips) {
        [self fetchOneGossipLikeNumber:item getLikeNumberBlock:^(int likeNumber, NSError *error) {
            item.likenumber = [NSString stringWithFormat:@"%d",likeNumber];
            block(newGossipCount,error);
        }];
    }
}

- (BOOL)isContainSameGossip:(Gossip *)gossip {
    BOOL isContain = NO;
    for (Gossip *item in self.gossips) {
        if ([item.objectId isEqualToString:gossip.objectId]) {
            isContain = YES;
            break;
        }
    }    
    return isContain;
}

- (void)fetchOneGossipLikeNumber:(Gossip *)currentGossip getLikeNumberBlock:(void (^)(int likeNumber,NSError *error))block {
    AVQuery *gossipQuery = [AVQuery queryWithClassName:@"GGUserGossipLike"];
    [gossipQuery whereKey:@"gossips" equalTo:currentGossip];
    [gossipQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        int likeNumber = 0;
        for (GGUserGossipLike* item in results) {
            if (item.liked) {
                likeNumber++;
            }
        }
        block(likeNumber,error);
    }];
}

@end
