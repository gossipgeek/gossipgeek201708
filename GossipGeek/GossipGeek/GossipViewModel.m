//
//  GossipViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GossipViewModel.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation GossipViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        self.gossips = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)getDataFromNetWork:(void (^)(NSError *))block {
    [self.gossips removeAllObjects];
    AVQuery *query = [AVQuery queryWithClassName:@"Gossip"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"content"];
    [query includeKey:@"title"];

    [query includeKey:@"zannumber"];
    [query includeKey:@"time"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self avobjectToGossipModel:objects];
        }
        block(error);
    }];
}

-(void)avobjectToGossipModel:(NSArray *)gossipAVObjects {
    for (int i = 0; i < gossipAVObjects.count; i++) {
        Gossip *gossip = [[Gossip alloc]init];
        AVObject *avobjec = gossipAVObjects[i];
        gossip.title = [avobjec objectForKey:@"title"];
        gossip.content = [avobjec objectForKey:@"content"];
        gossip.time = [avobjec objectForKey:@"time"];
       
        gossip.zanNumber = [NSString stringWithFormat:@"共%@人点赞",[avobjec objectForKey:@"zannumber"]];
        [self addGossipModel:gossip];
    }
    [self userTimeSort];
}

-(void)addGossipModel:(Gossip *)magazine {
    [self.gossips addObject:magazine];
}

-(void)userTimeSort {
    [self.gossips sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSArray *obj1Times = [((Gossip*)obj1).time componentsSeparatedByString:@"-"];
        NSArray *obj2Times = [((Gossip*)obj2).time componentsSeparatedByString:@"-"];
        for (int i = 0; i < obj1Times.count; i++) {
            if ([obj1Times[i] intValue] > [obj2Times[i] intValue]) {
                return false;
            }else if([obj1Times[i] intValue] < [obj2Times[i] intValue]){
                return true;
            }
        }
        return true;
    }];
}
@end
