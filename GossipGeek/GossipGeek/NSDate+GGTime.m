//
//  NSDate+GGTime.m
//  GossipGeek
//
//  Created by cozhang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "NSDate+GGTime.h"

static NSDateFormatter *formatterYearMonthDay;
static NSDateFormatter *formatterMonthDayHourMin;
@implementation NSDate (GGTime)
- (void)initDateFormatter {
    if (formatterYearMonthDay == nil) {
        formatterYearMonthDay = [[NSDateFormatter alloc]init];
        [formatterYearMonthDay setDateStyle:NSDateFormatterMediumStyle];
        [formatterYearMonthDay setTimeStyle:NSDateFormatterShortStyle];
        [formatterYearMonthDay setDateFormat:@"YYYY-MM-dd"];
    }
    
    if (formatterMonthDayHourMin == nil) {
        formatterMonthDayHourMin = [[NSDateFormatter alloc]init];
        [formatterMonthDayHourMin setDateStyle:NSDateFormatterMediumStyle];
        [formatterMonthDayHourMin setTimeStyle:NSDateFormatterShortStyle];
        [formatterMonthDayHourMin setDateFormat:@"MM-dd hh:mm"];
    }
}
- (NSString *)formatGGTimeYearMonthDay {
    [self initDateFormatter];
    return [formatterYearMonthDay stringFromDate:self];
}

- (NSString *)formatGGTimeMonthDayHourMin {
    [self initDateFormatter];
    return [formatterMonthDayHourMin stringFromDate:self];
}

- (NSComparisonResult)compareYear:(NSDate *)other {
    if ([self getDateYear] > [other getDateYear]) {
        return NSOrderedDescending;
    }else if ([self getDateYear] < [other getDateYear]) {
        return NSOrderedAscending;
    }
    return NSOrderedSame;
}

- (NSInteger)getDateYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return [components year];
}
@end
