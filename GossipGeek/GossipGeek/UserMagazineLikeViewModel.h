//
//  UserMagazineLikeViewModel.h
//  GossipGeek
//
//  Created by cozhang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserMagazineLike.h"

@class Magazine;
@interface UserMagazineLikeViewModel : NSObject
+ (void)saveMagazineLiked:(Magazine* )currentMagazine;
+ (void)isLiked:(Magazine *)currentMagazine finished:(void (^)(BOOL isLiked,NSError *error))finish;
@end
