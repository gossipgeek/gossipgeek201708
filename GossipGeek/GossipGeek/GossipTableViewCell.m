//
//  GossipTableViewCell.m
//  GossipGeek
//
//  Created by cozhang  on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GossipTableViewCell.h"
#import "Gossip.h"
#import "NSDate+GGTime.h"

@implementation GossipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateGossipCell:(Gossip *)currentGossip {
    self.titleLabel.text = currentGossip.title;
    self.contentLabel.text = currentGossip.content;
    self.timeLabel.text = [self formatGossipTime:currentGossip.createdAt];
    self.likeNumberLabel.text = [NSString stringWithFormat:NSLocalizedString(@"promptLikeTotalNumber", nil),currentGossip.likenumber];
}

- (NSString *)formatGossipTime:(NSDate *)time {
    if ([time compareYear:[NSDate date]] == NSOrderedSame) {
        return [time formatGGTimeMonthDayHourMin];
    }
    return [time formatGGTimeYearMonthDay];
}

@end
