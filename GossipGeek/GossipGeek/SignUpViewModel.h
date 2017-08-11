//
//  SignUpViewModel.h
//  GossipGeek
//
//  Created by Facheng Liang  on 11/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface SignUpViewModel : NSObject

@property (nonatomic) BOOL onlyTWEmailEnable;
- (BOOL)isEmailFormat:(NSString *)email;
- (BOOL)isTWEmailFormat:(NSString *)email;
- (NSString *)getErrorDescription:(NSError *)error;
- (BOOL)isBothAreNotEmptyStringWithEmail:(NSString *)email andPassword:(NSString *)password;
- (AVUser *)setUserInfoWithEmial:(NSString *)email andPassword:(NSString *)password;
- (NSString *)getEmailTextFieldPlaceHolder;

@end
