//
//  MagazineViewModel.h
//  GossipGeek
//
//  Created by cozhang  on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Magazine.h"
#import <AVOSCloud/AVOSCloud.h>
@interface MagazineViewModel : NSObject
@property(strong, nonatomic) NSMutableArray<Magazine*> *magazines;
- (instancetype)init;
- (void)getDataFromNetWork:(void(^)(NSError* error))block;
- (void)avobjectToMagazineModel:(NSArray*)magazineAVObjects;
- (void)addMagezineModel:(Magazine*)magazine;
- (void)userTimeSort;
@end
