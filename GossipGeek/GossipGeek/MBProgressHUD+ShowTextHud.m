//
//  Common+ShowTextHud.m
//  GossipGeek
//
//  Created by cozhang  on 15/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "MBProgressHUD+ShowTextHud.h"
#define HUD_TEXT_DELAY 1.0

@implementation MBProgressHUD (ShowTextHud)
+ (void)showTextHUD:(UIView *)superView hudText:(NSString *)text {
    MBProgressHUD *notMoreDataHud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    notMoreDataHud.mode = MBProgressHUDModeText;
    notMoreDataHud.label.text = text;
    notMoreDataHud.removeFromSuperViewOnHide = YES;
    [notMoreDataHud hideAnimated:YES afterDelay:HUD_TEXT_DELAY];
}
@end
