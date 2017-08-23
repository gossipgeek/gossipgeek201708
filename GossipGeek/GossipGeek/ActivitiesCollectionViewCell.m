//
//  ActivitiesCollectionViewCell.m
//  GossipGeek
//
//  Created by Facheng Liang  on 05/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "ActivitiesCollectionViewCell.h"
#import "ActivityViewModel.h"
#import "NSDate+GGTime.h"

#define BACKGROUND_IMAGE_ALPHA 0.2

@implementation ActivitiesCollectionViewCell

- (void)setActivityInfo:(Activity *)activity {
    self.titleLabel.text = [self formatTitle:activity];
    self.bodyLabel.text = activity.content;
    self.dateLabel.text = [activity.date convertToStringOfYearMonthDay];
    [self fetchLogoImage:activity.logo withBlock:^(UIImage *image) {
        self.backgroundView = [[UIImageView alloc] initWithImage:image];
        self.backgroundView.alpha = BACKGROUND_IMAGE_ALPHA;
    }];
}

- (NSString *)formatTitle:(Activity *)activity {
    BOOL isTitleEmptyOrNil = (activity.title == nil || [activity.title isEqualToString:@""]);
    BOOL isLocationEmptyOrNil = (activity.location == nil || [activity.location isEqualToString:@""]);
    if (isTitleEmptyOrNil && isLocationEmptyOrNil) {
        return @"";
    } else if (isTitleEmptyOrNil) {
        return [NSString stringWithFormat:@"【%@】",activity.location];
    } else if (isLocationEmptyOrNil) {
        return activity.title;
    } else {
        return [NSString stringWithFormat:@"【%@】%@",activity.location,activity.title];
    }
}

- (void)fetchLogoImage:(AVFile *)logo withBlock:(void (^)(UIImage *image))response {
    if (logo == nil) {
        response([UIImage imageNamed:@"activity.png"]);
    } else {
        [logo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                response([UIImage imageWithData:data]);
            } else {
                NSLog(@"fetchLogoImage failed");
            }
        }];
    }
}

@end
