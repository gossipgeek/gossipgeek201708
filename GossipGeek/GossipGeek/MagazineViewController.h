//
//  MagazineViewController.h
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineViewModel.h"
@interface MagazineViewController : UIViewController
- (void)pullDownSetupData;
@property (strong, nonatomic) MagazineViewModel *magazineViewModel;
@end
