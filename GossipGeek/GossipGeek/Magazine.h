//
//  Magazine.h
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
@interface Magazine : NSObject
@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *content;
@property(copy, nonatomic) NSString *time;
@property(copy, nonatomic) NSString *likeNumber;
@property(copy, nonatomic) NSString *url;
@property(strong, nonatomic) AVFile *imageFile;

@end
