//
//  GGAddGossipViewController.m
//  GossipGeek
//
//  Created by cozhang  on 18/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//

#import "GGAddGossipViewController.h"
#import "GossipViewModel.h"
#import "MBProgressHUD+ShowTextHud.h"
#import "GGPush.h"
#import "DefineHeader.h"
@interface GGAddGossipViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *gossipTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *maxWord;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *releaseButton;
@property (assign,nonatomic) CGFloat keyboardOffY;
@end

@implementation GGAddGossipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"titleGossipTitle", nil);
    [self initPageUI];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *) notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect maxWordRect = self.maxWord.frame;
    self.keyboardOffY = (self.view.frame.size.height-maxWordRect.origin.y)
                        -(keyboardFrame.size.height+maxWordRect.size.height+5);
    [UIView animateWithDuration:0.5 animations:^{
        CGRect contentFrame = self.contentTextView.frame;
        self.contentTextView.frame = CGRectMake(contentFrame.origin.x, contentFrame.origin.y,
                                                contentFrame.size.width, contentFrame.size.height + self.keyboardOffY);
        self.maxWord.frame = CGRectMake(maxWordRect.origin.x, maxWordRect.origin.y + self.keyboardOffY,
                                        maxWordRect.size.width, maxWordRect.size.height);
    }];
}

- (void)keyboardDidHide:(NSNotification *) notification {
    [UIView animateWithDuration:0.5 animations:^{
        CGRect contentFrame = self.contentTextView.frame;
        self.contentTextView.frame = CGRectMake(contentFrame.origin.x, contentFrame.origin.y,
                                                contentFrame.size.width, contentFrame.size.height - self.keyboardOffY);
        CGRect maxWordRect = self.maxWord.frame;
        self.maxWord.frame = CGRectMake(maxWordRect.origin.x,maxWordRect.origin.y - self.keyboardOffY,
                                        maxWordRect.size.width, maxWordRect.size.height);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)initPageUI {
    self.gossipTitleTextField.delegate = self;
    self.contentTextView.delegate = self;
    self.contentTextView.text = @"";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)sendGossipClick:(id)sender {
    if (![self.gossipTitleTextField.text isEqualToString:@""]) {
        self.releaseButton.enabled = NO;
        [GossipViewModel saveGossip:self.gossipTitleTextField.text gossipContent:self.contentTextView.text
                          saveBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptSendMessageSuccess", nil)];
                [self createPushNotification];
                [self.delegate gossipDidAdd];
                [NSTimer scheduledTimerWithTimeInterval:POP_DELAY
                                                 target:self
                                               selector:@selector(goBackGossipList)
                                               userInfo:nil
                                                repeats:NO];
            }else {
                [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptSendMessageFailed", nil)];
                self.releaseButton.enabled = YES;
            }
        }];
    }else {
        [MBProgressHUD showTextHUD:self.view hudText:NSLocalizedString(@"promptGossipTitleNil", nil)];
    }
}

- (void)goBackGossipList {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createPushNotification {
    NSDictionary *data = @{
                           @"data": @{
                                   @"alert":self.gossipTitleTextField.text,
                                   @"pageName":NSLocalizedString(@"titleGossipTitle", nil),
                                   @"parameter":@{
                                           @"objectId":@""
                                           }
                                   }
                           };
    [GGPush pushNotification:data];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < TEXT_WROD_NUMBER){
        self.placeholder.hidden = NO;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeholder.hidden = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *content = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (content.length > CONTENT_MAX_WORD) {
        textView.text = [content substringToIndex:CONTENT_MAX_WORD];
        self.maxWord.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)textView.text.length,CONTENT_MAX_WORD];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.maxWord.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)textView.text.length,CONTENT_MAX_WORD];
}

@end
