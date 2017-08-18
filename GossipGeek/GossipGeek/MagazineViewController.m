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
#import "MagazineDetailViewController.h"
#import "UserMagazineLikeViewModel.h"
#import "MBProgressHUD+ShowTextHud.h"
#import "SignInViewController.h"
@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource,ErrorViewDelegate,UpdateLikeNumerDelegate,SignInDelegate>
@property (weak, nonatomic) IBOutlet UITableView *magazineTableView;
@property (strong, nonatomic) MagazineViewModel *magazineViewModel;
@property (strong, nonatomic) ErrorView *errorView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"titleMagazineTitle", nil);
    self.tabBarItem.title = NSLocalizedString(@"titleMagazineTitle", nil);
    [self createErrorInfoUI];
    [self initMagazineTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.magazineViewModel = [[MagazineViewModel alloc]init];

    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    [self pullDownSetupData];
}

- (void)likeNumberDidUpdate {
    [self.magazineTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.selectIndexPath.row inSection:self.selectIndexPath.section], nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)initMagazineTableView {
    self.magazineTableView.delegate = self;
    self.magazineTableView.dataSource = self;
    self.magazineTableView.rowHeight = UITableViewAutomaticDimension;
    self.magazineTableView.estimatedRowHeight = 360;
    self.magazineTableView.showsVerticalScrollIndicator = NO;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullDownSetupData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"promptPutDownToUpdate", nil)];
    [self.magazineTableView addSubview:self.refreshControl];
    self.magazineTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

- (void)pullDownSetupData {
    [self.refreshControl beginRefreshing];
    [self.magazineViewModel fetchAVObjectData:^(int newMagazineCount, NSError *error) {
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.tabBarController.view animated:YES];
        [self.magazineTableView reloadData];
        if (error) {
            if (self.magazineViewModel.magazines.count != 0) {
                [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptConnectFailed", nil)];
            }else {
                [self showErrorInfoUI:YES];
            }
        }else {
            [self showErrorInfoUI:NO];
            if (newMagazineCount == 0) {
                [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptNotMoreMagazineDate", nil)];
            }
        }
    }];
}

- (void)signInDidSuccess {
    [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    [self pullDownSetupData];
}

- (void)showErrorInfoUI:(BOOL)flag {
    self.errorView.hidden = !flag;
}

- (void)createErrorInfoUI {
    self.errorView = [[ErrorView alloc]init];
    self.errorView.delegate = self;
    [self.errorView createErrorView:self.view];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"magezineCell"];
    Magazine *currentMagazine = self.magazineViewModel.magazines[indexPath.row];
    cell.titleLabel.text = currentMagazine.title;
    cell.contantLabel.text = currentMagazine.content;
    cell.timeLabel.text = currentMagazine.time;
    cell.likeNumberLabel.text = [NSString stringWithFormat:NSLocalizedString(@"promptLikeTotalNumber", nil),currentMagazine.likenumber];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexPath = indexPath;
    [self performSegueWithIdentifier:@"magazineDetailSegue" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    NSIndexPath *indexPath = sender;
    Magazine *selectMagazine = self.magazineViewModel.magazines[indexPath.row];
    MagazineDetailViewController *viewController = segue.destinationViewController;
    viewController.magazine = selectMagazine;
    viewController.delegate = self;
}
@end
