//
//  MagazineViewModel.h
//  GossipGeek
//
//  Created by cozhang  on 03/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Magazine.h"

@interface MagazineViewModel : NSObject
@property(strong, nonatomic) NSMutableArray<Magazine* > *magazines;
- (void)fetchAVObjectData:(void(^)(int newMagazineCount, NSError* error))block;
@end
