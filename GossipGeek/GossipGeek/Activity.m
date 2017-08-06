//
//  Activity.m
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "Activity.h"

@implementation Activity

@dynamic objectId;
@dynamic title;
@dynamic content;
@dynamic url;
@dynamic logo;
@dynamic date;
@dynamic location;

+ (NSString *)parseClassName {
    return @"Activities";
}

@end
