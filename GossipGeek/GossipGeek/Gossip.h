//
//  Gossip.h
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface Gossip : AVObject<AVSubclassing>
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *content;
@property(strong, nonatomic) NSDate *createdAt;
@property(copy, nonatomic) NSString *likenumber;
@property(copy, nonatomic) NSString *objectId;
@property(strong, nonatomic) AVObject *userId;
@end
