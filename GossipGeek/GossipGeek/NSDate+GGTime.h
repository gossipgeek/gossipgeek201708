//
//  NSDate+GGTime.h
//  GossipGeek
//
//  Created by cozhang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GGTime)

- (NSString *)formatGGTimeMonthDayHourMin;
- (NSComparisonResult)compareYear:(NSDate *)other;
- (NSString *)formatGGTimeYearMonthDay;
- (NSString *)convertToStringOfYearMonthDay;

@end
