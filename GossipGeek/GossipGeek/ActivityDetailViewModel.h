//
//  ActivityDetailViewModel.h
//  GossipGeek
//
//  Created by Facheng Liang  on 23/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailViewModel : NSObject
@property (copy, nonatomic) NSString *rootUrl;
- (BOOL)hasWebHistory:(NSString *)rootUrl whenError:(NSError *)error;
- (NSString *)getErrorDescription:(NSError *)error;
- (BOOL)isNetWorkError:(NSError *)error;
@end
