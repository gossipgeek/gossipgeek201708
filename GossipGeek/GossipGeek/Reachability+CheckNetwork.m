//
//  Common+CheckNetwork.m
//  GossipGeek
//
//  Created by cozhang  on 15/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "Reachability+CheckNetwork.h"
@implementation Reachability (CheckNetwork)
+(ReachabilityType )internetStatus {
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"https://leancloud.cn"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    ReachabilityType reachabilityType = GossipGeekStatusNotReachable;
    switch (internetStatus) {
        case ReachableViaWiFi:
            reachabilityType = GossipGeekStatusReachableWiFi;
            break;
        case ReachableViaWWAN:
            reachabilityType = GossipGeekStatusReachableWWAN;
            break;
        case NotReachable:
            reachabilityType = GossipGeekStatusNotReachable;
            break;
    }
    return reachabilityType;
}
@end
