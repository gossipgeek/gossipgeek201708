//
//  Gossip.m
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "Gossip.h"

@implementation Gossip
@dynamic objectId;
@dynamic title;
@dynamic content;
@dynamic createdAt;
@dynamic userId;

+ (NSString*)parseClassName {
    return @"Gossip";
}
@end
