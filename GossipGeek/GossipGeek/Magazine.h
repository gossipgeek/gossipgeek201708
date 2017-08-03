//
//  Magazine.h
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
@interface Magazine : NSObject
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *time;
@property(strong, nonatomic) NSString *zanNumber;
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) AVFile *imageAvfile;

@end
