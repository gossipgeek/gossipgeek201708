//
//  GossipViewModel.h
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gossip.h"
@interface GossipViewModel : NSObject
@property(strong, nonatomic) NSMutableArray<Gossip*> *gossips;
-(instancetype)init;
-(void)getDataFromNetWork:(void(^)(NSError* error))block;
-(void)avobjectToGossipModel:(NSArray*)gossipAVObjects;
-(void)addGossipModel:(Gossip*)gossip;
-(void)userTimeSort;
@end
