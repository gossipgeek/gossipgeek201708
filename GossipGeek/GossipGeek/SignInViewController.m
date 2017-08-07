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
#import <MBProgressHUD/MBProgressHUD.h>
#import "SignInViewModel.h"

typedef enum {
    ERROR_EMAIL_PASSWORD_NOT_MATCH = 210,
    ERROR_ACCOUNT_NOT_EXIST = 211,
    ERROR_EMAIL_NOT_VERIFED = 216,
    ERROR_SIGNIN_LIMIT = 219,
    ERROR_NETWORK_NOT_REACHABLE = -1009,
} SIGNIN_ERROR_CODE;

@interface SignInViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property SignInViewModel *signInViewModel;
@property MBProgressHUD *loadingHud;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCurrentPage];
    
    self.signInViewModel = [[SignInViewModel alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

- (IBAction)clickedSignInButton:(UIButton *)sender {
    [self setSignInButtonEnable:NO];
    NSString *email = self.emailTextField.text;
    if ([self.signInViewModel isEmailFormat:email]) {
        if ([self.signInViewModel getOnlyTWEmailEnable]) {
            if ([self.signInViewModel isTWEmailFormat:email]) {
                [self signIn];
            } else {
                [self showHud:NSLocalizedString(@"SignIn_onlyTWEmailEnable",nil)];
            }
        } else {
            [self signIn];
        }
    } else {
        [self showHud:NSLocalizedString(@"SignIn_notEmail",nil)];
    }
    [self setSignInButtonEnable:YES];
}

- (void)signIn {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    [self showOrHideLoading:YES];
    [AVUser logInWithUsernameInBackground:email password:password block:^(AVUser *user, NSError *error) {
        [self showOrHideLoading:NO];
        if (error) {
            NSLog(@"Sign In Failed : %@", error);
            [self errorTips:error];
        } else {
            NSLog(@"Sign In Success");
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.signInViewModel isBothAreNotEmptyStringWithEmail:self.emailTextField.text andPassword:self.passwordTextField.text]) {
        [self setSignInButtonEnable:YES];
    }
}

- (void)textFieldDidChangeEditing:(UITextField *)textField {
    if ([self.signInViewModel isBothAreNotEmptyStringWithEmail:self.emailTextField.text andPassword:self.passwordTextField.text]) {
        [self setSignInButtonEnable:YES];
    } else {
        [self setSignInButtonEnable:NO];
    }
}

- (void)errorTips:(NSError *)error {
    NSString *errorDescription;
    switch (error.code) {
        case ERROR_EMAIL_NOT_VERIFED:
            [self showAlertWithTitle:NSLocalizedString(@"SignIn_error", nil) andMessage:NSLocalizedString(@"SignIn_goEmailVerified", nil)];
            break;
        case ERROR_EMAIL_PASSWORD_NOT_MATCH:
            errorDescription = NSLocalizedString(@"SignIn_eamilMismatchPassword", nil);
            break;
        case ERROR_ACCOUNT_NOT_EXIST:
            errorDescription = NSLocalizedString(@"SignIn_userNotExist", nil);
            break;
        case ERROR_SIGNIN_LIMIT:
            errorDescription = NSLocalizedString(@"SignIn_signInLimit", nil);
            break;
        case ERROR_NETWORK_NOT_REACHABLE:
            errorDescription = NSLocalizedString(@"SignIn_networkError", nil);
            break;
        default:
            errorDescription = error.localizedDescription;
    }
    [self showHud:errorDescription];
}

- (void) showHud:(NSString *) error {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = error;
    [hud hideAnimated:YES afterDelay:HUD_SHOW_TIME];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"SignIn_cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"SignIn_ok", nil) style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)showOrHideLoading:(BOOL)show {
    if (show) {
        self.loadingHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    } else {
        [self.loadingHud hideAnimated:YES];
    }
}

-(void)setSignInButtonEnable:(BOOL)enable {
    if (enable) {
        self.signInButton.enabled = YES;
        self.signInButton.alpha = SIGNIN_BUTTON_ALPHA_WHEN_ENABLED;
    } else {
        self.signInButton.enabled = NO;
        self.signInButton.alpha = SIGNIN_BUTTON_ALPHA_WHEN_DISABLED;
    }
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)initCurrentPage {
    [self setSignInButtonEnable:NO];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SignIn_back", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    if ([self.signInViewModel getOnlyTWEmailEnable]) {
        self.emailTextField.placeholder = NSLocalizedString(@"SignIn_inputTWEmail", nil);
    }
}

@end
