//
//  UserMagazineLike.h
//  GossipGeek
//
//  Created by cozhang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface UserMagazineLike : AVObject<AVSubclassing>
@property (nonatomic) BOOL liked;
@property (nonatomic, strong) AVObject *users;
@property (nonatomic, strong) AVObject *magazines;
@property(copy, nonatomic) NSString *objectId;
@end
