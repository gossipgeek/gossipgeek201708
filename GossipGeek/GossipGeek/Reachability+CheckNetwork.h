//
//  Common+CheckNetwork.h
//  GossipGeek
//
//  Created by cozhang  on 15/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>

typedef enum ReachabilityType {
    GossipGeekStatusNotReachable,
    GossipGeekStatusReachableWWAN,
    GossipGeekStatusReachableWiFi
}ReachabilityType;
@interface Reachability (CheckNetwork)
+(ReachabilityType)internetStatus;
@end
