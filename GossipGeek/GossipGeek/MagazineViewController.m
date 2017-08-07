//
//  MagazineViewController.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewController.h"
#import "MagazineTableViewCell.h"
#import "MJRefresh/MJRefresh.h"
#import "MagazineViewModel.h"
#import "Magazine.h"
#import "ErrorView.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MagazineDetailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource,ErrorViewClickDelegate>
@property (weak, nonatomic) IBOutlet UITableView *magazineTableView;
@property (strong, nonatomic) MagazineViewModel *magazineViewModel;
@property (strong, nonatomic) MagazineDetailViewController *magazineDetailViewController;
@property (strong, nonatomic) ErrorView *errorView;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createErrorInfoUI];
    self.magazineViewModel = [[MagazineViewModel alloc]init];
    [self initMagazineTableView];
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:true];
    [self pullDownSetupData];
    
}

- (void)initMagazineTableView {
    self.magazineTableView.delegate = self;
    self.magazineTableView.dataSource = self;
    self.magazineTableView.rowHeight = UITableViewAutomaticDimension;
    self.magazineTableView.estimatedRowHeight = 360;
    self.magazineTableView.showsVerticalScrollIndicator = NO;
    MJRefreshNormalHeader *mjHeader = [[MJRefreshNormalHeader alloc] init];
    [mjHeader setRefreshingTarget:self refreshingAction:@selector(pullDownSetupData)];
    self.magazineTableView.mj_header = mjHeader;
    self.magazineTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

- (void)pullDownSetupData {
    [self.magazineViewModel getDataFromNetWork:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.tabBarController.view animated:true];
        [self.magazineTableView.mj_header endRefreshing];
        [self.magazineTableView reloadData];
        if (error) {
            [self hiddenErrorInfoUI:true];
        }else {
            [self hiddenErrorInfoUI:false];
        }
    }];
}

- (void)hiddenErrorInfoUI:(Boolean)flag {
    if (flag) {
        self.errorView.hidden = false;
    }else {
        self.errorView.hidden = true;
    }
}

- (void)createErrorInfoUI {
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

- (void)errorViewClickDelegate {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:true];
    [self pullDownSetupData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.magazineViewModel.magazines.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"magezineCell"];
    Magazine* currentMagazine = self.magazineViewModel.magazines[indexPath.row];
    cell.titleLabel.text = currentMagazine.title;
    cell.contantLabel.text = currentMagazine.content;
    cell.timeLabel.text = currentMagazine.time;
    cell.zanNumberLabel.text = currentMagazine.zanNumber;
    
    if (currentMagazine.imageAvfile == nil) {
        cell.logoImageView.image = [UIImage imageNamed:@"default.jpg"];
    }else {
        [currentMagazine.imageAvfile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.logoImageView.image = [UIImage imageWithData:data];
            }else {
                cell.logoImageView.image = [UIImage imageNamed:@"default.jpg"];
            }
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Magazine* selectMagazine = self.magazineViewModel.magazines[indexPath.row];
    self.magazineDetailViewController.url = selectMagazine.url;
    self.magazineDetailViewController.tabBarController.tabBar.hidden = true;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"magazineSegue"]) {
        self.magazineDetailViewController = (MagazineDetailViewController*)[segue destinationViewController];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
