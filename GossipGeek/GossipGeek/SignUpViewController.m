//
//  SignUpViewController.m
//  GossipGeek
//
//  Created by Facheng Liang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#define SIGNUP_BUTTON_ALPHA_WHEN_DISABLED 0.4
#define SIGNUP_BUTTON_ALPHA_WHEN_ENABLED  1
#define HUD_SHOW_TIME 2.f

#import "SignUpViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SignUpViewModel.h"
#import "MBProgressHUD+ShowTextHud.h"
#import "NSString+EmailFormat.h"

@interface SignUpViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) SignUpViewModel *signUpViewModel;
@property (weak, nonatomic) MBProgressHUD *loadingHud;

@end

@implementation SignUpViewController

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.passwordTextField becomeFirstResponder];
    return YES;
}

- (SignUpViewModel *)signUpViewModel {
    if (_signUpViewModel == nil) {
        _signUpViewModel = [[SignUpViewModel alloc] init];
    }
    return _signUpViewModel;
}

- (IBAction)clickedSignUpButton:(UIButton *)sender {
    [self setSignUpButtonEnable:NO];
    [self.view endEditing:YES];
    
    NSString *email = self.emailTextField.text;
    if ([email isTWEmailFormat]) {
        [self signUp];
    } else if ([email isEmailFormat] && !self.signUpViewModel.onlyTWEmailEnable) {
        [self signUp];
    } else if ([email isEmailFormat] && self.signUpViewModel.onlyTWEmailEnable) {
        [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptOnlyTWEmailEnable", nil)];
    } else {
        [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptNotEmail", nil)];
    }
    
    [self setSignUpButtonEnable:YES];
}

- (void)signUp {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.signUpViewModel signUp:self response:^(BOOL succeeded, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(succeeded) {
            [self showAlertWithTitle:NSLocalizedString(@"promptSignUpSucceeded", nil)
                          andMessage:NSLocalizedString(@"promptGoEmailVerified", nil)];
        } else {
            [self errorTips:error];
        }
    }];
}

- (void)goSignInPage {
    SEL selector = NSSelectorFromString(@"setSignUpEmailToSignInEmail:");
    if ([self.setEmailDelegate respondsToSelector:selector]) {
        [self.setEmailDelegate setSignUpEmailToSignInEmail:self.emailTextField.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)errorTips:(NSError *)error {
    NSString *errorDescription = [self.signUpViewModel getErrorDescription:error];
    if (errorDescription != nil) {
        [MBProgressHUD showTextHUD:self.view hudText:errorDescription];
    }
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"titleOk", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
        [self goSignInPage];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)textFieldDidChangeEditing:(UITextField *)textField {
    if ([self.emailTextField.text isBothAreNotEmptyStringWithPassword:self.passwordTextField.text]) {
        [self setSignUpButtonEnable:YES];
    } else {
        [self setSignUpButtonEnable:NO];
    }
}

- (void)setSignUpButtonEnable:(BOOL)enable {
    self.signUpButton.enabled = enable;
    self.signUpButton.alpha = enable?SIGNUP_BUTTON_ALPHA_WHEN_ENABLED:SIGNUP_BUTTON_ALPHA_WHEN_DISABLED;
}

- (void)initCurrentPage {
    [self setSignUpButtonEnable:NO];
    
    self.navigationItem.title = NSLocalizedString(@"titleSignUp", nil);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"titleBack", nil)
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    self.emailTextField.placeholder = [self.signUpViewModel getEmailTextFieldPlaceHolder];
    self.passwordTextField.placeholder = NSLocalizedString(@"titlePassword", nil);
    [self.signUpButton setTitle:NSLocalizedString(@"titleSignUp", nil) forState:UIControlStateNormal];    
}

@end
