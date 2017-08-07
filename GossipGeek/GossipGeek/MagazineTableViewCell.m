//
//  MagazineTableViewCell.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MagazineTableViewCell.h"

@implementation MagazineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contantLabel.numberOfLines = 3;
    self.logoImageView.layer.borderWidth = 1.0;
    self.logoImageView.layer.borderColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
