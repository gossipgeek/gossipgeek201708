//
//  ErrorView.h
//  GossipGeek
//
//  Created by cozhang  on 04/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErrorViewDelegate <NSObject>
- (void) errorViewDidClick;
@end

@interface ErrorView : UIView
@property (weak, nonatomic) id<ErrorViewDelegate> delegate;
- (void)viewClick;
+ (void)createErrorView:(UIView *)superView errorView:(ErrorView *)view;
@end
