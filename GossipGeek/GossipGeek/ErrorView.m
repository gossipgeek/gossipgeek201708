//
//  ErrorView.m
//  GossipGeek
//
//  Created by cozhang  on 04/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "ErrorView.h"
@interface ErrorView()
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) UIImageView *errorImageView;
@end
@implementation ErrorView

- (instancetype)init {
    self = [super init];
    if (self) {        
        [self initErrorLabel];
        [self initErrorImageView];
        UITapGestureRecognizer *tapGestuerRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
        [self addGestureRecognizer:tapGestuerRecognizer];
    }
    return self;
}

- (void)initErrorImageView {
    self.errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"networkError.jpeg"]];
    [self addSubview:self.errorImageView];
    self.errorImageView.translatesAutoresizingMaskIntoConstraints = false;
    [[self.errorImageView bottomAnchor] constraintEqualToAnchor:self.errorLabel.topAnchor constant:15].active = true;
    [[self.errorImageView centerXAnchor] constraintEqualToAnchor:self.errorLabel.centerXAnchor].active = true;
    [[self.errorImageView widthAnchor] constraintEqualToAnchor:self.widthAnchor constant:-100].active = true;
    [[self.errorImageView heightAnchor] constraintEqualToAnchor:self.errorImageView.widthAnchor multiplier:0.8125 constant:0].active = true;
}

- (void)initErrorLabel {
    self.errorLabel = [[UILabel alloc]init];
    self.errorLabel.font = [UIFont systemFontOfSize:15];
    self.errorLabel.textColor = [UIColor grayColor];
    [self addSubview:self.errorLabel];
    self.errorLabel.translatesAutoresizingMaskIntoConstraints = false;
    [[self.errorLabel leadingAnchor] constraintEqualToAnchor:self.leadingAnchor constant:0].active = true;
    [[self.errorLabel trailingAnchor] constraintEqualToAnchor:self.trailingAnchor constant:0].active = true;
    [[self.errorLabel heightAnchor] constraintEqualToConstant:44].active = true;
    [[self.errorLabel centerYAnchor] constraintEqualToAnchor:self.centerYAnchor constant:80].active = true;
    self.errorLabel.textAlignment = NSTextAlignmentCenter;
    self.errorLabel.text = NSLocalizedString(@"networkConnectionFailed", nil);
}

- (void)viewClick {
    [self.delegate errorViewClick];
}

@end
