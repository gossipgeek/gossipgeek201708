//
//  GGPush.m
//  GossipGeek
//
//  Created by cozhang  on 23/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GGPush.h"
#import <AVOSCloud/AVOSCloud.h>
#define PUSH_EXPIRE_TIME 604800

@implementation GGPush
+ (void)pushNotification:(NSDictionary *)data {
    AVQuery *query = [AVInstallation query];
    [query includeKey:@"objectId"];
    AVPush *push = [[AVPush alloc] init];
    [AVPush setProductionMode:NO];
    [push expireAfterTimeInterval:PUSH_EXPIRE_TIME];
    [push setQuery:query];
    [push setData:data];
    [push sendPushInBackground];
}
@end
