//
//  GGMoreTableViewCell.m
//  GossipGeek
//
//  Created by cozhang  on 24/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GGMoreTableViewCell.h"

@implementation GGMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.signOutLabel.text = NSLocalizedString(@"titleSignOut", nil);
}

@end
