//
//  NSString+EmailFormat.h
//  GossipGeek
//
//  Created by Facheng Liang  on 17/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EmailFormat)

- (BOOL)isEmailFormat;
- (BOOL)isTWEmailFormat;
- (BOOL)isBothAreNotEmptyStringWithPassword:(NSString *)password;
+ (BOOL)getOnlyTWEmailEnable;

@end
