//
//  UIWebView+DetailWebView.h
//  GossipGeek
//
//  Created by Facheng Liang  on 24/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorView.h"

@interface UIWebView (DetailWebView)

- (void)loadRootURL:(NSString *)rootUrl;
- (void)clickedBackButton:(UIViewController *)viewController;
- (void)clickedCloseButton:(UIViewController *)viewController;

@end
