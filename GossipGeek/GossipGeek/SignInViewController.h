//
//  SignInViewController.h
//  GossipGeek
//
//  Created by Facheng Liang  on 01/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SignInDelegate <NSObject>
@required
- (void)signInDidSuccess;
@end
@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) id<SignInDelegate> delegate;
@end
