//
//  MagazineViewModel.m
//  GossipGeek
//
//  Created by cozhang  on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewModel.h"
@implementation MagazineViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.magazines = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)getDataFromNetWork:(void (^)(NSError* error))block {
    [self.magazines removeAllObjects];
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
        block(error);
    }];
}

- (void)avobjectToMagazineModel:(NSArray *)magazineAVObjects {
    for (int i = 0; i < magazineAVObjects.count; i++) {
        Magazine *magazine = [[Magazine alloc]init];
        AVObject *avobjec = magazineAVObjects[i];
        magazine.title = [avobjec objectForKey:@"title"];
        magazine.content = [avobjec objectForKey:@"content"];
        magazine.time = [avobjec objectForKey:@"time"];
        magazine.url = [avobjec objectForKey:@"URL"];
        magazine.likeNumber = [NSString stringWithFormat:@"共%@人点赞",[avobjec objectForKey:@"zannumber"]];
        magazine.imageAvfile = [avobjec objectForKey:@"image"];
        [self addMagezineModel:magazine];
    }
    [self userTimeSort];
}

- (void)addMagezineModel:(Magazine *)magazine {
    [self.magazines addObject:magazine];
}

- (void)userTimeSort {
    [self.magazines sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSArray *obj1Times = [((Magazine*)obj1).time componentsSeparatedByString:@"-"];
        NSArray *obj2Times = [((Magazine*)obj2).time componentsSeparatedByString:@"-"];
        for (int i = 0; i < obj1Times.count; i++) {
            if ([obj1Times[i] intValue] > [obj2Times[i] intValue]) {
                return false;
            }else if([obj1Times[i] intValue] < [obj2Times[i] intValue]){
                return true;
            }
        }
        return true;
    }];
}
@end
