//
//  MagazineViewController.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewController.h"
#import "MagazineTableViewCell.h"
#import "MagazineViewModel.h"
#import "Magazine.h"
#import "ErrorView.h"
#import <AVOSCloud/AVOSCloud.h>

#import <MBProgressHUD/MBProgressHUD.h>

@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource,ErrorViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *magazineTableView;
@property (strong, nonatomic) MagazineViewModel *magazineViewModel;
@property (strong, nonatomic) ErrorView *errorView;
@property (strong, nonatomic) UIRefreshControl* refreshControl;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.magazineViewModel = [[MagazineViewModel alloc]init];
    
    [self createErrorInfoUI];
    [self initMagazineTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    [self pullDownSetupData];
    
}

- (void)initMagazineTableView {
    self.magazineTableView.delegate = self;
    self.magazineTableView.dataSource = self;
    self.magazineTableView.rowHeight = UITableViewAutomaticDimension;
    self.magazineTableView.estimatedRowHeight = 360;
    self.magazineTableView.showsVerticalScrollIndicator = NO;    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullDownSetupData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"putDownToUpdata", nil)];
    [self.magazineTableView addSubview:self.refreshControl];
    self.magazineTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

- (void)pullDownSetupData {
    [self.refreshControl beginRefreshing];
    [self.magazineViewModel fetchAVObjectData:^(int newMagazineCount, NSError *error) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.refreshControl endRefreshing];
            [MBProgressHUD hideHUDForView:self.tabBarController.view animated:YES];
            [self.magazineTableView reloadData];
            if (error) {
                [self showErrorInfoUI:YES];
            }else {
                [self showErrorInfoUI:NO];
                if (newMagazineCount == 0) {
                    [self showNotHaveMoreMagazineDataHUD];
                }
            }
        }];
    }];
}

- (void)showNotHaveMoreMagazineDataHUD {
    MBProgressHUD* notMoreDataHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    notMoreDataHud.mode = MBProgressHUDModeText;
    notMoreDataHud.label.text = NSLocalizedString(@"notMoreMagazineData", nil);
    notMoreDataHud.removeFromSuperViewOnHide = YES;
    [notMoreDataHud hideAnimated:YES afterDelay:0.5];
}

- (void)showErrorInfoUI:(BOOL)flag {
    self.errorView.hidden = !flag;
}

- (void)createErrorInfoUI {
    self.errorView = [[ErrorView alloc]init];
    self.errorView.delegate = self;
    self.errorView.hidden = YES;
    [self.view addSubview:self.errorView];
    self.errorView.userInteractionEnabled = YES;
    self.errorView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.errorView leadingAnchor] constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = YES;
    [[self.errorView trailingAnchor] constraintEqualToAnchor:self.view.trailingAnchor constant:0].active = YES;
    [[self.errorView heightAnchor] constraintEqualToAnchor:self.view.heightAnchor constant:0].active = YES;
    [[self.errorView centerYAnchor] constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}

- (void)errorViewDidClick {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
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
    cell.likeNumberLabel.text = [NSString stringWithFormat:NSLocalizedString(@"likeTotalNumber", nil),currentMagazine.likenumber];
    if (currentMagazine.image == nil) {
        cell.logoImageView.image = [UIImage imageNamed:@"default.jpg"];
    }else {
        [currentMagazine.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.logoImageView.image = [UIImage imageWithData:data];
            }else {
                cell.logoImageView.image = [UIImage imageNamed:@"default.jpg"];
            }
        }];
    }
    return cell;
}


@end
