//
//  ActivityViewModel.h
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface ActivityViewModel : NSObject

@property (strong, nonatomic) NSMutableArray<Activity *> *activities;

- (void)fetchData: (void (^)(BOOL isFetchedNewActivity, NSError *error))response;
- (NSString *)getErrorDescription:(NSError *)error;
- (BOOL)hasHistoryData;
- (BOOL)isNetWorkError:(NSError *)error;
- (BOOL)isItemExist:(Activity *)activity inActivities:(NSArray *)activities;

@end
