//
//  MagazineTableViewCell.m
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//


#import "MagazineTableViewCell.h"
#define GRAY_BORDER_COLOR [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00].CGColor

@implementation MagazineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.logoImageView.layer.borderColor = GRAY_BORDER_COLOR;
}
@end
