//
//  Magazine.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "Magazine.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation Magazine

@dynamic objectId;
@dynamic title;
@dynamic content;
@dynamic time;
@dynamic url;
@dynamic image;

+ (NSString*)parseClassName {
    return @"Magazine";
}

@end
