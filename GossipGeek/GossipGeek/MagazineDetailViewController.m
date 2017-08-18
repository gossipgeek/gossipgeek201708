//
//  MagazineDetailViewController.m
//  GossipGeek
//
//  Created by cozhang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Magazine.h"
#import "UserMagazineLikeViewModel.h"
#import "ErrorView.h"
#import "Reachability+CheckNetwork.h"
#import "MBProgressHUD+ShowTextHud.h"

#define LIKE_NUMBER_ADD_ONE 1
@interface MagazineDetailViewController ()<UIWebViewDelegate,ErrorViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIWebView *magazineWebView;
@property (weak, nonatomic) IBOutlet UILabel *likeNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (strong, nonatomic) MBProgressHUD *waitUpdateHud;
@property (strong, nonatomic) ErrorView *errorView;
@end

@implementation MagazineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"titleMagazineDetailTitle", nil);
    self.tabBarItem.title = NSLocalizedString(@"titleMagazineDetailTitle", nil);
    [self.closeButton setTitle:NSLocalizedString(@"titleMagazineDetailCloseButton", nil)];
    self.magazineWebView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initConnectFailUI];
    self.toolView.hidden = YES;
    
    [self updateLikeUI];
    [self updateWebview];
}

- (void)updateLikeUI {
    [UserMagazineLikeViewModel isLiked:self.magazine finished:^(BOOL isLiked,NSError *error) {
        if (!error) {
            self.likeButton.enabled = !isLiked;
            self.likeNumberLabel.text = self.magazine.likenumber;
            self.toolView.hidden = NO;
        }else {
            self.errorView.hidden = NO;
            self.toolView.hidden = YES;
        }
    }];
}

- (IBAction)likeButtonDidClick:(id)sender {
    if ([Reachability internetStatus] == GossipGeekStatusNotReachable) {
        [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptConnectFailed", nil)];
        return;
    }
    self.magazine.likenumber =[NSString stringWithFormat:@"%d",(self.magazine.likenumber).intValue + LIKE_NUMBER_ADD_ONE];
    self.likeNumberLabel.text = self.magazine.likenumber;
    self.likeButton.enabled = NO;
    [UserMagazineLikeViewModel saveMagazineLiked:self.magazine];
    if ([self.delegate respondsToSelector:@selector(likeNumberDidUpdate)]) {
        [self.delegate likeNumberDidUpdate];
    }
}

- (IBAction)commentButtonDidClick:(id)sender {
    [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptHaveNothing", nil)];
}

- (void)errorViewDidClick {
    self.errorView.hidden = YES;
    [self updateLikeUI];
    [self updateWebview];
}

- (IBAction)goBackList:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goBackClick:(id)sender {
    if ([self.magazineWebView canGoBack]) {
        [self.magazineWebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.tabBarController.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.tabBarController.view animated:YES];
    if ([webView.request.URL isEqual:self.magazine.url]) {
        self.errorView.hidden = NO;
        self.toolView.hidden = YES;
    }else {
        if (self.errorView.hidden == YES) {
            [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptConnectFailed", nil)];
        }
    }
}

- (void)updateWebview {
    NSURL *magazineUrl = [NSURL URLWithString:self.magazine.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:magazineUrl];
    [self.magazineWebView loadRequest:request];
}

- (void)initConnectFailUI {
    self.errorView = [[ErrorView alloc]init];
    self.errorView.delegate = self;
    [self.errorView createErrorView:self.view];
}
@end
