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
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
