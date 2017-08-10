//
//  MagazineViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewModel.h"
#import <AVOSCloud/AVOSCloud.h>
@implementation MagazineViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.magazines = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)fetchAVObjectData:(void (^)(int newMagazineCount,NSError* error))block {
    
    AVQuery *query = [AVQuery queryWithClassName:@"Magazine"];
    [query orderByDescending:@"time"];
    [query includeKey:@"content"];
    [query includeKey:@"title"];
    [query includeKey:@"url"];
    [query includeKey:@"likenumber"];
    [query includeKey:@"time"];
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        int newMagazineCount = 0;
        if (!error) {
            newMagazineCount = [self upDataMagazines:objects];
        }
        block(newMagazineCount,error);
    }];
}

- (void)addMagezineModel:(Magazine *)magazine {
    [self.magazines addObject:magazine];
}

- (int)upDataMagazines:(NSArray* ) magazineAVObjects {
    int newMagazineCount = 0;
    for (Magazine* item in magazineAVObjects) {
        if (![self isContainSameMagazine:item]) {
            [self addMagezineModel:item];
            newMagazineCount++;
        }
    }
    return newMagazineCount;
}

- (BOOL)isContainSameMagazine:(Magazine *)magazine {
    for (Magazine* item in self.magazines) {
        if ([item.url isEqualToString:magazine.url]) {
            return YES;
        }
    }
    return NO;
}
@end
