//
//  Magazine.h
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface Magazine : AVObject<AVSubclassing>
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *content;
@property(copy, nonatomic) NSString *time;
@property(copy, nonatomic) NSString *likenumber;
@property(copy, nonatomic) NSString *url;
@property(strong, nonatomic) AVFile *image;

@end
