//
//  SignUpViewController.h
//  GossipGeek
//
//  Created by Facheng Liang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetSignUpEmailToSignInEmailDelegate <NSObject>
- (void)setSignUpEmailToSignInEmail:(NSString *)email;
@end

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) id<SetSignUpEmailToSignInEmailDelegate> setEmailDelegate;

@end
