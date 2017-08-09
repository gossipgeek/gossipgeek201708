//
//  MagazineDetailViewController.m
//  GossipGeek
//
//  Created by cozhang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineDetailViewController.h"

@interface MagazineDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIWebView *magazineWebView;
@end

@implementation MagazineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.magazineWebView.backgroundColor = [UIColor clearColor];
    [self updataWebview];
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (IBAction)goBackClick:(id)sender {
    if ([self.magazineWebView canGoBack]) {
        [self.magazineWebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)updataWebview {
    NSURL *magazineUrl = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:magazineUrl];
    [self.magazineWebView loadRequest:request];
    
}

@end
