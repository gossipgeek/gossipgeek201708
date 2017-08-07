//
//  MagazineDetailViewController.h
//  GossipGeek
//
//  Created by cozhang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *magazineWebView;
@property (strong, nonatomic) NSString *url;
@end
