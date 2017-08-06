//
//  ActivitiesCollectionViewCell.h
//  GossipGeek
//
//  Created by Facheng Liang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ActivitiesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (void)setActivityInfo:(Activity *)activity;
- (NSString *)formatTitle:(Activity *)activity;

@end
