//
//  GGUserGossipLike.h
//  GossipGeek
//
//  Created by cozhang  on 16/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface GGUserGossipLike : AVObject<AVSubclassing>
@property (assign, nonatomic) BOOL liked;
@property (strong, nonatomic) AVObject *users;
@property (strong, nonatomic) AVObject *gossips;
@property (copy, nonatomic) NSString *objectId;
@end
