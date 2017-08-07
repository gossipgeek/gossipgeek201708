//
//  MagazineDetailViewController.m
//  GossipGeek
//
//  Created by cozhang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineDetailViewController.h"

@interface MagazineDetailViewController ()
//@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;


@end

@implementation MagazineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.magazineWebView.backgroundColor = [UIColor clearColor];
  //  [self.magazineWebView setOpaque:false];
  //  [[[self.magazineWebView subviews] objectAtIndex:0] setBounds:true];
//    self.toolBar.backgroundColor = [UIColor clearColor];
//    self.toolBar.alpha = 0;
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
