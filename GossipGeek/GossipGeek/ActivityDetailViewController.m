//
//  ActivityDetailViewController.m
//  GossipGeek
//
//  Created by Facheng Liang  on 23/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ErrorView.h"
#import "MBProgressHUD+ShowTextHud.h"
#import "ActivityDetailViewModel.h"
#import "UIWebView+DetailWebView.h"
@interface ActivityDetailViewController () <UIWebViewDelegate,ErrorViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (strong, nonatomic) ErrorView *errorView;
@property (strong, nonatomic) ActivityDetailViewModel *activityDetailViewModel;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCurrentPage];
    [self.webView loadRootURL:self.activityDetailViewModel.rootUrl];
}

- (void)setRootUrl:(NSString *)url {
    self.activityDetailViewModel.rootUrl = url;
}

- (ActivityDetailViewModel *)activityDetailViewModel{
    if (_activityDetailViewModel == nil) {
        _activityDetailViewModel = [[ActivityDetailViewModel alloc] init];
    }
    return _activityDetailViewModel;
}

- (IBAction)clickedBackButton:(UIBarButtonItem *)sender {
    [self.webView clickedBackButton:self];
}

- (IBAction)clickedCloseButton:(UIBarButtonItem *)sender {
    [self.webView clickedCloseButton:self];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)createErrorView {
    self.errorView = [[ErrorView alloc] initWithSuperview:self.view];
    self.errorView.delegate = self;
}

- (void)errorViewDidClick {
    self.errorView.hidden = YES;
    [self.webView loadRootURL:self.activityDetailViewModel.rootUrl];
}

- (void)shouldShowErrorView:(BOOL)show withTips:(NSString *)tips{
    [self.errorView setErrorLabelText:tips];
    self.errorView.hidden = !show;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
    NSString *errorDescription = [self.activityDetailViewModel getErrorDescription:error];
    if ([self.activityDetailViewModel hasWebHistory:self.activityDetailViewModel.rootUrl whenError:error]) {
        if ([self.activityDetailViewModel isNetWorkError:error]) {
            errorDescription = NSLocalizedString(@"promptNetworkConnectionFailed", nil);
        }
        [self shouldShowErrorView:YES withTips:errorDescription];
    } else if (errorDescription) {
        [MBProgressHUD showTextHUD:self.view hudText:errorDescription];
    }
}

- (void)initCurrentPage {
    self.navigationItem.title = NSLocalizedString(@"titleActivityDetail", nil);
    self.closeButton.title = NSLocalizedString(@"titleClose", nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.webView.delegate = self;
    [self createErrorView];
}

@end
