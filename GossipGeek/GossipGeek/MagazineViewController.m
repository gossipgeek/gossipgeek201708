//
//  MagazineViewController.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewController.h"

@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *magazineTableView;

@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)initMagazineTableView {
    self.magazineTableView.delegate = self;
    self.magazineTableView.dataSource = self;
    self.magazineTableView.estimatedRowHeight = 200.0f;
    self.magazineTableView.rowHeight = UITableViewAutomaticDimension;
    self.magazineTableView.tableHeaderView = [[UIView alloc]initWithFrame:(CGRectZero)];
    self.magazineTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"magezineCell"];
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
