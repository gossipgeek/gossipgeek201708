//
//  GossipViewController.m
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GossipViewController.h"
#import "Gossip.h"
#import "MJRefresh.h"
#import "GossipViewModel.h"
#import "ErrorView.h"
#import <AVOSCloud/AVOSCloud.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "GossipTableViewCell.h"
@interface GossipViewController ()<UITableViewDelegate,UITableViewDataSource,ErrorViewClickDelegate>
@property (strong, nonatomic) GossipViewModel *gossipViewModel;
@property (weak, nonatomic) IBOutlet UITableView *gossipTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addGossip;

@property (strong, nonatomic) ErrorView *errorView;
@end

@implementation GossipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createErrorInfoUI];
    self.gossipViewModel = [[GossipViewModel alloc]init];
    [self initGossipTableView];
    self.automaticallyAdjustsScrollViewInsets = false;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:true];
    [self pullDownSetupData];
    
}

-(void)initGossipTableView {
    self.gossipTableView.delegate = self;
    self.gossipTableView.dataSource = self;
    self.gossipTableView.rowHeight = UITableViewAutomaticDimension;
    self.gossipTableView.estimatedRowHeight = 360;
    self.gossipTableView.showsVerticalScrollIndicator = NO;
    MJRefreshNormalHeader *mjHeader = [[MJRefreshNormalHeader alloc] init];
    [mjHeader setRefreshingTarget:self refreshingAction:@selector(pullDownSetupData)];
    self.gossipTableView.mj_header = mjHeader;
    self.gossipTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

-(void)pullDownSetupData {
    [self.gossipViewModel getDataFromNetWork:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.tabBarController.view animated:true];
        [self.gossipTableView.mj_header endRefreshing];
        [self.gossipTableView reloadData];
        if (error) {
            [self hiddenErrorInfoUI:true];
        }else {
            [self hiddenErrorInfoUI:false];
        }
    }];
}

-(void)hiddenErrorInfoUI:(Boolean)flag {
    if (flag) {
        self.errorView.hidden = false;
    }else {
        self.errorView.hidden = true;
    }
}

-(void)createErrorInfoUI {
    self.errorView = [[ErrorView alloc]init];
    self.errorView.delegate = self;
    self.errorView.hidden = true;
    [self.view addSubview:self.errorView];
    self.errorView.userInteractionEnabled = true;
    self.errorView.translatesAutoresizingMaskIntoConstraints = false;
    [[self.errorView leadingAnchor] constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = true;
    [[self.errorView trailingAnchor] constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = true;
    [[self.errorView heightAnchor] constraintEqualToAnchor:self.view.heightAnchor constant:0].active = true;
    [[self.errorView centerYAnchor] constraintEqualToAnchor:self.view.centerYAnchor].active = true;
}

-(void)errorViewClickDelegate {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:true];
    [self pullDownSetupData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gossipViewModel.gossips.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GossipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gossipCell"];
    Gossip* currentGossip = self.gossipViewModel.gossips[indexPath.row];
    cell.titleLabel.text = currentGossip.title;
    cell.contentLabel.text = currentGossip.content;
    cell.timeLabel.text = currentGossip.time;
    cell.zanNumberLabel.text = currentGossip.zanNumber;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
