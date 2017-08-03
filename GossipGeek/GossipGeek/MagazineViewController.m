//
//  MagazineViewController.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineViewController.h"
#import "MagazineTableViewCell.h"
#import "Magazine.h"
#import <AVOSCloud/AVOSCloud.h>
@interface MagazineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *magazineTableView;
@property (strong, nonatomic) NSArray *magazineAVObjects;
@property (strong, nonatomic) NSMutableArray<Magazine*> *magazineModels;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMagazineTableView];
    self.magazineModels = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = false;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataFromNetWork];

}

-(void)initMagazineTableView {
    self.magazineTableView.delegate = self;
    self.magazineTableView.dataSource = self;
    self.magazineTableView.tableHeaderView = [[UIView alloc]initWithFrame:(CGRectZero)];
    self.magazineTableView.tableFooterView = [[UIView alloc]initWithFrame:(CGRectZero)];
}

-(void)getDataFromNetWork {
    AVQuery *query = [AVQuery queryWithClassName:@"Magazine"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"content"];
    [query includeKey:@"title"];
    [query includeKey:@"URL"];
    [query includeKey:@"zannumber"];
    [query includeKey:@"time"];
    [query includeKey:@"image"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.magazineAVObjects = objects;
            [self changeMagazineModels];
        }
    }];
}

-(void)changeMagazineModels {
    for (int i = 0; i < self.magazineAVObjects.count; i++) {
        Magazine *magazine = [[Magazine alloc]init];
        AVObject *avobjec = self.magazineAVObjects[i];
        magazine.title = [avobjec objectForKey:@"title"];
        magazine.content = [avobjec objectForKey:@"content"];
        magazine.time = [avobjec objectForKey:@"time"];
        magazine.URL = [avobjec objectForKey:@"URL"];
        magazine.zanNumber = [NSString stringWithFormat:@"共%@人点赞",[avobjec objectForKey:@"zannumber"]];
        AVFile *file = [avobjec objectForKey:@"image"];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            NSLog(@"%@",error);
            if (!error) {
                magazine.image = [UIImage imageWithData:data];
                [self.magazineModels addObject:magazine];
                [self.magazineTableView reloadData];
            }
            
        }];
    }
    
    
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.magazineModels.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MagazineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"magezineCell"];
  //  AVObject *magazine = self.magazineAVObjects[indexPath.row];
    
    cell.titleLabel.text = self.magazineModels[indexPath.row].title;
    cell.contantLabel.text = self.magazineModels[indexPath.row].content;
    cell.timeLabel.text = self.magazineModels[indexPath.row].time;
    cell.zanNumberLabel.text = self.magazineModels[indexPath.row].zanNumber;
    cell.logoImageView.image = self.magazineModels[indexPath.row].image;

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
