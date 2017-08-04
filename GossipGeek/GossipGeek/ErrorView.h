//
//  ErrorView.h
//  GossipGeek
//
//  Created by cozhang  on 04/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ErrorViewClickDelegate <NSObject>
- (void) errorViewClickDelegate;
@end

@interface ErrorView : UIView
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) UIImageView *errorImageView;
@property (weak, nonatomic) id<ErrorViewClickDelegate> delegate;
- (instancetype)init;
-(void)viewClick;
@end
