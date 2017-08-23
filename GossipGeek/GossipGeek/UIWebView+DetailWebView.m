//
//  UIWebView+DetailWebView.m
//  GossipGeek
//
//  Created by Facheng Liang  on 24/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "UIWebView+DetailWebView.h"
#import "MBProgressHUD+ShowTextHud.h"


typedef enum {
    ERROR_NETWORK_NOT_REACHABLE = -1009,
} WEB_ERROR_CODE;

@implementation UIWebView (DetailWebView)

- (void)loadRootURL:(NSString *)rootUrl {
    NSURL *url = [NSURL URLWithString:rootUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

- (void)clickedBackButton:(UIViewController *)viewController {
    if ([self canGoBack]) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        [self goBack];
    }else {
        [viewController.navigationController popViewControllerAnimated:YES];
    }
}

- (void)clickedCloseButton:(UIViewController *)viewController {
    [viewController.navigationController popViewControllerAnimated:YES];
}


@end
