//
//  GossipViewController.m
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GossipViewController.h"
#import "Gossip.h"
#import "GossipViewModel.h"
#import "ErrorView.h"
#import <AVOSCloud/AVOSCloud.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "GossipTableViewCell.h"
#import "MBProgressHUD+ShowTextHud.h"
#import "GGAddGossipViewController.h"
#import "DefineHeader.h"
@interface GossipViewController ()<UITableViewDelegate,UITableViewDataSource,ErrorViewDelegate,AddGossipDelegate>
@property (strong, nonatomic) GossipViewModel *gossipViewModel;
@property (strong, nonatomic) ErrorView *errorView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *gossipTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addGossipBarItem;
@end

@implementation GossipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"titleGossipTitle", nil);
    self.tabBarItem.title = NSLocalizedString(@"titleGossipTitle", nil);
    self.addGossipBarItem.title = NSLocalizedString(@"titleAddGossipButton", nil);
    [self createErrorInfoUI];
    [self initGossipTableView];
    
    self.gossipViewModel = [[GossipViewModel alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadGossip) name:UPDATA_ALL_VIEWCONTROLLER object:nil];
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:true];
    [self pullDownSetupData];
}

-(void)initGossipTableView {
    self.gossipTableView.delegate = self;
    self.gossipTableView.dataSource = self;
    self.gossipTableView.rowHeight = UITableViewAutomaticDimension;
    self.gossipTableView.estimatedRowHeight = 360;
    self.gossipTableView.showsVerticalScrollIndicator = NO;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullDownSetupData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:NSLocalizedString(@"promptPutDownToUpdate", nil)];
    [self.gossipTableView addSubview:self.refreshControl];
    self.gossipTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

- (void)reloadGossip {
    [self.gossipViewModel.gossips removeAllObjects];
    [self pullDownSetupData];
}

-(void)pullDownSetupData {
    [self.refreshControl beginRefreshing];
    [self.gossipViewModel fetchAVObjectData:^(int newGossipCount, NSError *error) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.refreshControl endRefreshing];
            [MBProgressHUD hideHUDForView:self.tabBarController.view animated:YES];
            [self.gossipTableView reloadData];
            if (error) {
                if (self.gossipViewModel.gossips.count != 0) {
                    [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptConnectFailed", nil)];
                }else {
                    [self showErrorInfoUI:YES errorText:NSLocalizedString(@"promptNetworkConnectionFailed", nil)];
                }
                return;
            }
            [self showErrorInfoUI:NO errorText:@""];
            if (self.gossipViewModel.gossips.count == 0) {
                [self showErrorInfoUI:YES errorText:NSLocalizedString(@"promptHaveNothingOfGossip", nil)];
                return;
            }
            if (newGossipCount == 0) {
                [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptNotMoreMagazineDate", nil)];
            }
        }];
    }];
}

- (void)showErrorInfoUI:(BOOL)flag errorText:(NSString *)text {
    [self.errorView setErrorLabelText:text];
    self.errorView.hidden = !flag;
}

- (void)createErrorInfoUI {
    self.errorView = [[ErrorView alloc] initWithSuperview:self.view];
    self.errorView.delegate = self;
}

- (void)gossipDidAdd {
    [self pullDownSetupData];
}

- (void)errorViewDidClick {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    [self pullDownSetupData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gossipViewModel.gossips.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GossipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gossipCell"];
    Gossip* currentGossip = self.gossipViewModel.gossips[indexPath.row];
    [cell updateGossipCell:currentGossip];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addGossipSegue"]) {
        GGAddGossipViewController *viewController = segue.destinationViewController;
        viewController.delegate = self;
    }
}

@end
