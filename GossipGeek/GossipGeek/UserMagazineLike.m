//
//  UserMagazineLike.m
//  GossipGeek
//
//  Created by cozhang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "UserMagazineLike.h"

@implementation UserMagazineLike
@dynamic users;
@dynamic liked;
@dynamic magazines;
@dynamic objectId;

+ (NSString*)parseClassName {
    return @"UserMagazineLike";
}
@end
