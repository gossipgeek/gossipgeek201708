//
//  Activity.h
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

@interface Activity : AVObject<AVSubclassing>

@property (copy, readonly, nonatomic) AVFile   *logo;
@property (copy, readonly, nonatomic) NSString *title;
@property (copy, readonly, nonatomic) NSString *content;
@property (copy, readonly, nonatomic) NSDate   *date;
@property (copy, readonly, nonatomic) NSString *url;
@property (copy, readonly, nonatomic) NSString *location;
@property (copy, readonly, nonatomic) NSString *objectId;
+ (NSString *)parseClassName;

@end
