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

- (void)fetchAVObjectDataFromService:(void (^)(NSArray *objects,NSError* error))block {
    AVQuery *query = [AVQuery queryWithClassName:@"Magazine"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"content"];
    [query includeKey:@"title"];
    [query includeKey:@"URL"];
    [query includeKey:@"zannumber"];
    [query includeKey:@"time"];
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self avobjectToMagazineModel:objects];
        }
        block(objects,error);
    }];
}

- (void)avobjectToMagazineModel:(NSArray *)magazineAVObjects {
    [self.magazines removeAllObjects];
    for (AVObject *avobject in magazineAVObjects) {
        Magazine *magazine = [[Magazine alloc]init];
        magazine.title = [avobject objectForKey:@"title"];
        magazine.content = [avobject objectForKey:@"content"];
        magazine.time = [avobject objectForKey:@"time"];
        magazine.url = [avobject objectForKey:@"URL"];
        magazine.likeNumber = [NSString stringWithFormat:@"共%@人点赞",[avobject objectForKey:@"zannumber"]];
        magazine.imageFile = [avobject objectForKey:@"image"];
        [self addMagezineModel:magazine];
    }
    [self useMagazineReleaseTimeToSort];
}

- (void)addMagezineModel:(Magazine *)magazine {
    [self.magazines addObject:magazine];
}

- (void)useMagazineReleaseTimeToSort {
    [self.magazines sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {

        return [self isTimeOneSmallThanTimeTwo:((Magazine*)obj1).time TimeTwo:((Magazine*)obj2).time];
    }];
}

- (BOOL)isTimeOneSmallThanTimeTwo:(NSString*)time1 TimeTwo:(NSString*)time2 {
    NSArray *obj1Times = [time1 componentsSeparatedByString:@"-"];
    NSArray *obj2Times = [time2 componentsSeparatedByString:@"-"];
    for (int i = 0; i < obj1Times.count; i++) {
        if ([obj1Times[i] intValue] > [obj2Times[i] intValue]) {
            return false;
        }else if([obj1Times[i] intValue] < [obj2Times[i] intValue]){
            return true;
        }
    }
    return true;
}

@end
