//
//  ActivityViewModel.m
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "ActivityViewModel.h"
#import <AVOSCloud/AVOSCloud.h>

typedef enum {
    ERROR_NETWORK_NOT_REACHABLE = -1009,
} ACTIVITIES_LIST_ERROR_CODE;

@implementation ActivityViewModel

- ()init {
    if (self = [super init]) {
        self.activities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fetchData:(void (^)(BOOL isFetchedNewActivity, NSError *error))response {
    AVQuery *query = [AVQuery queryWithClassName:[Activity parseClassName]];
    [query orderByDescending:@"date"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        BOOL isFetchedNewActivity = NO;
        if (!error) {
            NSLog(@"query succeeded %@",objects);
            isFetchedNewActivity = [self isFetchedNewActivity:objects];
            [self updateActivities:objects];
        } else {
            NSLog(@"query failed %@",error);
        }
        response(isFetchedNewActivity,error);
    }];
}

- (void)updateActivities:(NSArray *)ActivitiesObjectsOfOrigin {
    [self.activities removeAllObjects];
    [self.activities addObjectsFromArray:ActivitiesObjectsOfOrigin];
}

- (NSUInteger)isFetchedNewActivity:(NSArray *)ActivitiesObjectsOfOrigin {
    if (ActivitiesObjectsOfOrigin.count > self.activities.count) {
        return YES;
    } else {
        for (Activity *item in ActivitiesObjectsOfOrigin) {
            if (![self isItemExist:item inActivities:self.activities]) {
                return YES;
            }
        }
        return NO;
    }
}

- (BOOL)hasHistoryData {
    return self.activities.count;
}

- (BOOL)isNetWorkError:(NSError *)error {
    return error.code == ERROR_NETWORK_NOT_REACHABLE;
}

- (BOOL)isItemExist:(Activity *)activity inActivities:(NSArray *)activities {
    for (Activity* item in activities) {
        if ([activity.objectId isEqualToString:item.objectId]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)getErrorDescription:(NSError *)error {
    return error.code == ERROR_NETWORK_NOT_REACHABLE?NSLocalizedString(@"promptConnectFailed", nil)
                                                    :error.localizedDescription;
}

@end
