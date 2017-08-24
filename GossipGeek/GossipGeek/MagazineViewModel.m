//
//  MagazineViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UserMagazineLike.h"

@implementation MagazineViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.magazines = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)fetchAVObjectData:(void (^)(int newMagazineCount,NSError *error))block {
    AVQuery *query = [AVQuery queryWithClassName:@"Magazine"];
    [query orderByDescending:@"time"];
    [query includeKey:@"content"];
    [query includeKey:@"title"];
    [query includeKey:@"url"];
    [query includeKey:@"time"];
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        int newMagazineCount = 0;
        if (!error) {
            newMagazineCount = [self updateMagazines:objects];
            [self updateMagazinesLikeNumber:self.magazines newMagazineCount:newMagazineCount fetchAVObject:block];
        }else {
            block(newMagazineCount,error);
        }
    }];
}

- (void)addMagezineModel:(Magazine *)magazine {
    [self.magazines addObject:magazine];
}

- (int)updateMagazines:(NSArray *) magazineAVObjects {
    int newMagazineCount = 0;
    for (Magazine *item in magazineAVObjects) {
        if (![self isContainSameMagazine:item]) {
            newMagazineCount++;
        }
    }
    [self.magazines removeAllObjects];
    for (Magazine* item in magazineAVObjects) {
        [self addMagezineModel:item];
    }
    return newMagazineCount;
}

- (void)updateMagazinesLikeNumber:(NSMutableArray *) magazines
                 newMagazineCount:(int) newMagazineCount
                    fetchAVObject:(void (^)(int newMagazineCount,NSError *error))block {
    for (Magazine *item in magazines) {
        [self fetchOneMagazineLikeNumber:^(int likeNumber, NSError *error) {
            item.likenumber = [NSString stringWithFormat:@"%d",likeNumber];
            block(newMagazineCount,error);
        } currentMagazine:item];
    }
}

- (BOOL)isContainSameMagazine:(Magazine *)magazine {
    for (Magazine *item in self.magazines) {
        if ([item.objectId isEqualToString:magazine.objectId]) {
            return YES;
        }
    }
    return NO;
}

- (void)fetchOneMagazineLikeNumber:(void (^)(int likeNumber,NSError *error))block
                   currentMagazine:(Magazine *)currentMagazine {
    AVQuery *magazineQuery = [AVQuery queryWithClassName:@"UserMagazineLike"];
    [magazineQuery whereKey:@"magazines" equalTo:currentMagazine];
    [magazineQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        int likeNumber = 0;
        for (UserMagazineLike* item in results) {
            if (item.liked) {
                likeNumber++;
            }
        }
        block(likeNumber,error);
    }];
}
@end
