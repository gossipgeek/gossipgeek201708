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

@interface SignInViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) SignInViewModel *signInViewModel;
@property (weak, nonatomic) MBProgressHUD *loadingHud;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initCurrentPage];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeEditing:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (SignInViewModel *)signInViewModel{
    if (_signInViewModel == nil) {
        _signInViewModel = [[SignInViewModel alloc] init];
    }
    return _signInViewModel;
}

- (IBAction)clickedSignInButton:(UIButton *)sender {
    [self setSignInButtonEnable:NO];
    
    NSString *email = self.emailTextField.text;
    if (self.signInViewModel.onlyTWEmailEnable) {
        if ([self.signInViewModel isTWEmailFormat:email]) {
            [self signIn];
        } else {
            [self showHud:NSLocalizedString(@"SignIn_onlyTWEmailEnable",nil)];
        }
    } else {
        if ([self.signInViewModel isEmailFormat:email]) {
            [self signIn];
        } else {
            [self showHud:NSLocalizedString(@"SignIn_notEmail",nil)];

        }
    }
    
    [self setSignInButtonEnable:YES];
}

- (void)signIn {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    [self shouldShowLoading:YES];
    [AVUser logInWithUsernameInBackground:email password:password block:^(AVUser *user, NSError *error) {
        [self shouldShowLoading:NO];
        if (error) {
            NSLog(@"Sign In Failed : %@", error);
            [AVUser logOut];
            [self errorTips:error];
        } else {
            NSLog(@"Sign In Success");
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
    NSString *errorDescription = [self.signInViewModel getErrorDescription:error];
    if (errorDescription == NSLocalizedString(@"SignIn_goEmailVerified", nil)) {
        [self showAlertWithTitle:NSLocalizedString(@"SignIn_error", nil) andMessage:errorDescription];
    } else {
        [self showHud:errorDescription];
    }
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

-(void)shouldShowLoading:(BOOL)show {
    if (show) {
        self.loadingHud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    } else {
       [self.loadingHud hideAnimated:NO];
    }
}

-(void)setSignInButtonEnable:(BOOL)enable {
    self.signInButton.enabled = enable;
    self.signInButton.alpha = enable?SIGNIN_BUTTON_ALPHA_WHEN_ENABLED:SIGNIN_BUTTON_ALPHA_WHEN_DISABLED;
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)initCurrentPage {
    [self setSignInButtonEnable:NO];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SignIn_back", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    if (self.signInViewModel.onlyTWEmailEnable) {
        self.emailTextField.placeholder = NSLocalizedString(@"SignIn_inputTWEmail", nil);
    }
}

@end
