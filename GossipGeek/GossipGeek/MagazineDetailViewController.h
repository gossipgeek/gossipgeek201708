//
//  MagazineDetailViewController.h
//  GossipGeek
//
//  Created by cozhang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
@class Magazine;

@protocol UpdateLikeNumerDelegate <NSObject>
- (void) likeNumberDidUpdate;
@end

@interface MagazineDetailViewController : UIViewController
@property (strong, nonatomic) Magazine *magazine;
@property (weak, nonatomic) id<UpdateLikeNumerDelegate> delegate;
@end
