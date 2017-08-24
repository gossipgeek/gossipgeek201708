//
//  ActivitiesViewController.m
//  GossipGeek
//
//  Created by Facheng Liang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "ActivitiesViewController.h"
#import "ActivitiesCollectionViewCell.h"
#import "Activity.h"
#import "ActivityViewModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MBProgressHUD+ShowTextHud.h"
#import "ErrorView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define NUMBER_OF_SECTION 1
#define CELL_NUMBER_PER_LINE 3
#define FLOAT_PRECISION  0.00001

@interface ActivitiesViewController () <ErrorViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) ActivityViewModel *activityViewModel;
@property (strong, nonatomic) ErrorView *errorView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityViewModel = [ActivityViewModel defaultViewModel];
    [self initCurrentPage];
    [self updateActivitiesList];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return NUMBER_OF_SECTION;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.activityViewModel.activities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *activityCellIdentifier = @"activityCell";
    NSString *reuseIdentifier = activityCellIdentifier;
    ActivitiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];
    [cell setActivityInfo:self.activityViewModel.activities[indexPath.row]];
    return cell;
}

- (void)updateActivitiesList {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.refreshControl beginRefreshing];
    [self.activityViewModel fetchData:^(BOOL isFetchedNewActivity, NSError *error) {
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            [self.collectionView reloadData];
        }
        [self handleException:error hasNewActivity:isFetchedNewActivity];
    }];
}

- (void)handleException:(NSError *)error hasNewActivity:(BOOL)isFetchedNewActivity {
    [self shouldShowErrorView:NO withTips:nil];

    if (![self.activityViewModel hasHistoryData]) {
        NSString *errorViewTips = [self.activityViewModel isNetWorkError:error] ? NSLocalizedString(@"promptNetworkConnectionFailed", nil) : NSLocalizedString(@"promptHaveNothingOfActivity", nil);
        [self shouldShowErrorView:YES withTips:errorViewTips];
    } else if (!isFetchedNewActivity) {
        NSString *textHudTips = [self.activityViewModel isNetWorkError:error] ? NSLocalizedString(@"promptConnectFailed", nil): NSLocalizedString(@"promptNoMoreData", nil);
        [MBProgressHUD showTextHUD:self.view hudText:textHudTips];
    }
}

- (void)shouldShowErrorView:(BOOL)show withTips:(NSString *)tips{
    [self.errorView setErrorLabelText:tips];
    self.errorView.hidden = !show;
}

- (void)createErrorView {
    self.errorView = [[ErrorView alloc]initWithSuperview:self.view];
    self.errorView.delegate = self;
}

- (void)errorViewDidClick {
    [self updateActivitiesList];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewFlowLayout *collectionViewFlowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    float spacing = collectionViewFlowLayout.minimumInteritemSpacing*(CELL_NUMBER_PER_LINE-1)+
    collectionViewFlowLayout.sectionInset.left+collectionViewFlowLayout.sectionInset.right;
    float cellWeightAndHeight = (SCREEN_WIDTH-spacing)/CELL_NUMBER_PER_LINE - FLOAT_PRECISION;
    return CGSizeMake(cellWeightAndHeight, cellWeightAndHeight);
}

- (void)initCurrentPage {
    [self createErrorView];
    self.navigationItem.title = NSLocalizedString(@"titleActivity", nil);
    self.collectionView.alwaysBounceVertical =YES;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(updateActivitiesList)
                  forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"promptPutDownToUpdate", nil)];
    [self.collectionView addSubview:self.refreshControl];
}

@end
