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
-(void)fetchAVObjectData:(void (^)(int newGossipCount,NSError *error))block;
+ (void)saveGossip:(NSString *)title gossipContent:(NSString *) content saveBlock:(AVBooleanResultBlock)block;
@end
