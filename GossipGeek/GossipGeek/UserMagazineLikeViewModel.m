//
//  UserMagazineLikeViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "UserMagazineLikeViewModel.h"
#import "Magazine.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation UserMagazineLikeViewModel
+ (void)saveMagazineLiked:(Magazine *)currentMagazine {
    UserMagazineLike *userMagazineLike = [[UserMagazineLike alloc]initWithClassName:@"UserMagazineLike"];
    userMagazineLike.liked = YES;
    [userMagazineLike setObject:[AVUser currentUser] forKey:@"users"];
    [userMagazineLike setObject:currentMagazine forKey:@"magazines"];
    [userMagazineLike saveInBackground];
}

+ (void)isLiked:(Magazine *)currentMagazine finished:(void (^)(BOOL isLiked,NSError *error))finish {
    AVUser* currentUser = [AVUser currentUser];
    AVQuery *userQuery = [AVQuery queryWithClassName:@"UserMagazineLike"];
    [userQuery whereKey:@"users" equalTo:currentUser];
    AVQuery *magazineQuery = [AVQuery queryWithClassName:@"UserMagazineLike"];
    [magazineQuery whereKey:@"magazines" equalTo:currentMagazine];
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:userQuery,magazineQuery,nil]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        finish(((UserMagazineLike *)results.firstObject).liked,error);
    }];
}
@end
