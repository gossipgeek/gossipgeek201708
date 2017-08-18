//
//  SignInViewController.m
//  GossipGeek
//
//  Created by Facheng Liang  on 01/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#define SIGNIN_BUTTON_ALPHA_WHEN_DISABLED 0.4
#define SIGNIN_BUTTON_ALPHA_WHEN_ENABLED  1
#define HUD_SHOW_TIME 2.f


#import "SignInViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SignInViewModel.h"
#import "SignUpViewController.h"
#import "MBProgressHUD+ShowTextHud.h"
#import "NSString+EmailFormat.h"

@interface SignInViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,SetSignUpEmailToSignInEmailDelegate>

@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) SignInViewModel *signInViewModel;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCurrentPage];
    self.emailTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromSignInToSignUp"]) {
        SignUpViewController *signUpVC = segue.destinationViewController;
        signUpVC.setEmailDelegate = self;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.passwordTextField becomeFirstResponder];
    return YES;
}

- (void)setSignUpEmailToSignInEmail:(NSString *)email {
    self.emailTextField.text = email;
    self.passwordTextField.text = nil;
}

- (SignInViewModel *)signInViewModel{
    if (_signInViewModel == nil) {
        _signInViewModel = [[SignInViewModel alloc] init];
    }
    return _signInViewModel;
}

- (IBAction)clickedSignInButton:(UIButton *)sender {
    [self setSignInButtonEnable:NO];
    [self.view endEditing:YES];
    
    NSString *email = self.emailTextField.text;
    if ([email isTWEmailFormat]) {
        [self signIn];
    } else if ([email isEmailFormat] && !self.signInViewModel.onlyTWEmailEnable) {
        [self signIn];
    } else if ([email isEmailFormat] && self.signInViewModel.onlyTWEmailEnable) {
        [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptOnlyTWEmailEnable", nil)];
    } else {
        [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptNotEmail", nil)];
    }
    
    [self setSignInButtonEnable:YES];
}

- (void)signIn {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.signInViewModel signIn:self response:^(AVUser *user, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            NSLog(@"Sign In Failed : %@", error);
            [self errorTips:error];
        } else {
            NSLog(@"Sign In Success");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)textFieldDidChangeEditing:(UITextField *)textField {
    if ([self.emailTextField.text isBothAreNotEmptyStringWithPassword:self.passwordTextField.text]) {
        [self setSignInButtonEnable:YES];
    } else {
        [self setSignInButtonEnable:NO];
    }
}

- (void)errorTips:(NSError *)error {
    NSString *errorDescription = [self.signInViewModel getErrorDescription:error];
    if ([errorDescription isEqualToString:NSLocalizedString(@"promptGoEmailVerified", nil)]) {
        [self showAlertWithTitle:NSLocalizedString(@"promptError", nil) andMessage:errorDescription];
    } else {
        [MBProgressHUD showTextHUD:self.view hudText:errorDescription];
    }
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                               message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"titleCancel", nil)
                                                           style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"titleOk", nil)
                                                       style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setSignInButtonEnable:(BOOL)enable {
    self.signInButton.enabled = enable;
    self.signInButton.alpha = enable?SIGNIN_BUTTON_ALPHA_WHEN_ENABLED:SIGNIN_BUTTON_ALPHA_WHEN_DISABLED;
}

- (void)initCurrentPage {
    [self setSignInButtonEnable:NO];
    
    self.navigationItem.title = NSLocalizedString(@"titleSignIn", nil);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"titleBack", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.signInButton setTitle:NSLocalizedString(@"titleSignIn", nil)
                       forState:UIControlStateNormal];
    [self.signUpButton setTitle:NSLocalizedString(@"titleSignUp", nil)
                       forState:UIControlStateNormal];
    [self.forgotPasswordButton setTitle:NSLocalizedString(@"titleForgotPassword", nil)
                               forState:UIControlStateNormal];
    self.emailTextField.placeholder = [self.signInViewModel getEmailTextFieldPlaceHolder];
    self.passwordTextField.placeholder = NSLocalizedString(@"titlePassword", nil);
}

@end
