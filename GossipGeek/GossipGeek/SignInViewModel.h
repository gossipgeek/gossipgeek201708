//
//  SignInViewModel.h
//  GossipGeek
//
//  Created by Facheng Liang  on 09/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignInViewModel : NSObject

- (BOOL)isEmailFormat:(NSString *)email;
- (BOOL)isTWEmailFormat:(NSString *)email;
- (NSString *)getErrorDescription:(NSError *)error;
- (BOOL)isBothAreNotEmptyStringWithEmail:(NSString *)email andPassword:(NSString *)password;
@property BOOL onlyTWEmailEnable;

@end
