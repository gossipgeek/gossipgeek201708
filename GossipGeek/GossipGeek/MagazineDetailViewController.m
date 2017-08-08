//
//  MagazineDetailViewController.m
//  GossipGeek
//
//  Created by cozhang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface MagazineDetailViewController ()<UIWebViewDelegate>
@end

@implementation MagazineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.magazineWebView.backgroundColor = [UIColor clearColor];
    self.magazineWebView.delegate = self;
    [self updataWebview];
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (IBAction)goBackList:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)zanClick:(id)sender {
    
}

- (IBAction)goBackClick:(id)sender {
    if ([self.magazineWebView canGoBack]) {
        [self.magazineWebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:true];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.tabBarController.view animated:true];
}

- (void)updataWebview {
    NSURL *magazineUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:magazineUrl];
    [self.magazineWebView loadRequest:request];
    
}

@end
