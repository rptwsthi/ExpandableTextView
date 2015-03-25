//
//  ExpandableChatInputView.h
//  SaudiaCrew
//
//  Created by Developer on 19/03/15.
//  Copyright (c) 2015 tchnologies33. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExpandableChatInputView;
@protocol ExpandableChatInputViewDelegate <NSObject>

@required
- (void) textView : (ExpandableChatInputView *) textView message : (NSString *) text send : (id) sender;
- (void) textView : (ExpandableChatInputView *) textView mediaButton : (id) sender touched : (BOOL) condition;
//- (void) textView : (ExpandableChatInputView *) textView needBottomCell : (BOOL)yes;


@end

#define MESSAGE_VIEW_MAX_HEIGHT 140.0f
#define MESSAGE_VIEW_MIN_HEIGHT 44.0f

@interface ExpandableChatInputView : UIView<UITextViewDelegate>
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *sendButton;
@property (nonatomic, retain) IBOutlet UIButton *cameraButton;

- (IBAction)sendButtonTouched:(id)sender;
- (IBAction)cameraButtonTouhed:(id)sender;

@property (nonatomic, retain) NSString *placeHolder;
@property (nonatomic, retain) UIScrollView *containerScrollView;
@property (nonatomic, retain) id <ExpandableChatInputViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

- (void) setViewAtBottom : (UITableView *) tableView;
- (void)registerForKeyboardNotifications;
- (void) unregisterForKeyboardNotifications;

@end