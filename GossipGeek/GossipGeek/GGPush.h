//
//  GGPush.h
//  GossipGeek
//
//  Created by cozhang  on 23/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGPush : NSObject
+ (void)pushNotification:(NSDictionary *)data;
@end
