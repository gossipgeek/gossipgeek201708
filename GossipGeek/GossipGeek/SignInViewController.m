//
//  SignInViewController.m
//  GossipGeek
//
//  Created by Facheng Liang  on 01/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "SignInViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* 测试
    AVObject *user = [AVObject objectWithClassName:@"userTest"];
    [user setObject:@"fcliang@thoughtworks.com"    forKey:@"email"];
    [user setObject:@"admin" forKey:@"userName"];
    [user setObject:@"admin" forKey:@"password"];
    [user save];
     */

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
