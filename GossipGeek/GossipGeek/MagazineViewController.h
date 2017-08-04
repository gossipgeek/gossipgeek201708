//
//  MagazineViewController.h
//  GossipGeek
//
//  Created by cozhang  on 02/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineViewController : UIViewController
-(void)initMagazineTableView;
-(void)pullDownSetupData;
-(void)createErrorInfoUI;
-(void)hiddenErrorInfoUI:(Boolean) flag;
@end
