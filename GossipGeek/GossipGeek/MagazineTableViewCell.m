//
//  MagazineTableViewCell.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//
#define grayBorderColor [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00].CGColor

#import "MagazineTableViewCell.h"
@implementation MagazineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.logoImageView.layer.borderColor = grayBorderColor;
}
@end
