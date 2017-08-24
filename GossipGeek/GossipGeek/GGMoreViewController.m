//
//  GGMoreViewController.m
//  GossipGeek
//
//  Created by cozhang  on 24/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GGMoreViewController.h"
#import "GGMoreTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MagazineViewController.h"
#import "SignInViewController.h"
@interface GGMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *moreTableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation GGMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"titleMoreTitle", nil);
    [self initMorePageUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updataMorePageUI];
}

- (void)updataMorePageUI {
    self.userNameLabel.text = [AVUser currentUser].username;
}

- (void)initMorePageUI {
    self.moreTableView.delegate = self;
    self.moreTableView.dataSource = self;
    self.moreTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
    self.moreTableView.scrollEnabled = NO;
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height/2;
    self.photoImageView.layer.masksToBounds = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GGMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [AVUser logOut];
    [self performSegueWithIdentifier:@"signOutSegue" sender:nil];
    [self switchViewController];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController* nav = (UINavigationController *)segue.destinationViewController;
    SignInViewController *viewController = (SignInViewController *)nav.topViewController;
    viewController.changeUser = YES;
}

- (void)switchViewController {
    NSArray *viewControllers = self.tabBarController.viewControllers;
        for (UIViewController *item in viewControllers) {
            if ([item isKindOfClass:[UINavigationController class]]) {
                if ([((UINavigationController *)item).topViewController isKindOfClass:[MagazineViewController class]]) {
                    [self.tabBarController setSelectedViewController:item];
                    break;
                }
            }
        }
    
}

@end
