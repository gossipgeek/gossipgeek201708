//
//  GGAddGossipViewController.h
//  GossipGeek
//
//  Created by cozhang  on 18/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddGossipDelegate <NSObject>
- (void) gossipDidAdd;
@end
@interface GGAddGossipViewController : UIViewController
@property (weak, nonatomic) id<AddGossipDelegate> delegate;
@end
