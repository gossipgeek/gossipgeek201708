//
//  Common+ShowTextHud.h
//  GossipGeek
//
//  Created by cozhang  on 15/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface MBProgressHUD (ShowTextHud)
+ (void)showTextHUD:(UIView *)superView hudText:(NSString *)text;
@end
