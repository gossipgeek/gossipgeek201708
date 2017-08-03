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
#import <AVOSCloud/AVOSCloud.h>
@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *magazineTableView;
@property (strong, nonatomic) MagazineViewModel *magazineViewModel;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.magazineViewModel = [[MagazineViewModel alloc]init];
    [self initMagazineTableView];
    self.automaticallyAdjustsScrollViewInsets = false;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  //  [self pullDownSetupData];

}

-(void)initMagazineTableView {
    self.magazineTableView.delegate = self;
    self.magazineTableView.dataSource = self;
    MJRefreshNormalHeader *mjHeader = [[MJRefreshNormalHeader alloc] init];
    [mjHeader setRefreshingTarget:self refreshingAction:@selector(pullDownSetupData)];
    self.magazineTableView.mj_header = mjHeader;
    self.magazineTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

-(void)pullDownSetupData {
    [self.magazineViewModel getDataFromNetWork:^{
        [self.magazineTableView.mj_header endRefreshing];
        [self.magazineTableView reloadData];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.magazineViewModel.magazines.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"magezineCell"];
    Magazine* currentMagazine = self.magazineViewModel.magazines[indexPath.row];
    cell.titleLabel.text = currentMagazine.title;
    cell.contantLabel.text = currentMagazine.content;
    cell.timeLabel.text = currentMagazine.time;
    cell.zanNumberLabel.text = currentMagazine.zanNumber;
    
    [currentMagazine.imageAvfile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.logoImageView.image = [UIImage imageWithData:data];
        }
    }];
    return cell;
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
