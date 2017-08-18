//
//  GGUserGossipLike.m
//  GossipGeek
//
//  Created by cozhang  on 16/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GGUserGossipLike.h"

@implementation GGUserGossipLike
@dynamic users;
@dynamic liked;
@dynamic gossips;
@dynamic objectId;

+ (NSString*)parseClassName {
    return @"GGUserGossipLike";
}
@end
