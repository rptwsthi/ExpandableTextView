//
//  ExpandableChatInputView.m
//  SaudiaCrew
//
//  Created by Developer on 19/03/15.
//  Copyright (c) 2015 tchnologies33. All rights reserved.
//

#import "ExpandableChatInputView.h"

@implementation ExpandableChatInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) awakeFromNib{
    _textView.delegate = self;

    //set layer
    [_textView.layer setCornerRadius:4.0f];
    
    //
    [self resetView];
    
    //
}

//set placeholder
- (void) setPlaceHolder:(NSString *)placeHolder{
    //placeholder stuff
    _placeHolder = placeHolder;
    [_textView setText:placeHolder];
    [_textView setTextColor:[UIColor lightGrayColor]];
    [_sendButton setEnabled:NO];
}

#pragma mark - Text View Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    //placeholder stuff
    if ([textView.text isEqualToString:_placeHolder]) {
        textView.text = @"";
        [textView setTextColor:[UIColor darkGrayColor]];
    }
    return YES;
}

- (void) textViewDidEndEditing:(UITextView *)textView{
    //placeholder stuff
    if (![textView.text length]) {
        [textView setTextColor:[UIColor lightGrayColor]];
        [self setPlaceHolder:_placeHolder];;
    }
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *finalText = [textView.text stringByAppendingPathComponent:text];
    //enable button
    if ([finalText length] <= 1 && ![text length])
        [_sendButton setEnabled:NO];
    else
        [_sendButton setEnabled:YES];
    
    [self updateTextView:textView heightWithText:finalText];
    
    return YES;
}

#pragma mark - Text Height Support
//update view height
- (void) updateTextView : (UITextView *) textView heightWithText : (NSString *) text{
    CGSize constraintSize = textView.frame.size;
    constraintSize.height = MESSAGE_VIEW_MAX_HEIGHT;
    CGSize textSize = [text sizeWithFont:textView.font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    
    textSize.height = (textSize.height < 44.0f) ? 44.0f : textSize.height;

    CGRect frame = self.frame;
    frame.origin.y -= (textSize.height - frame.size.height);
    frame.size.height = textSize.height;

    [UIView animateWithDuration:0.3f animations:^{
        _heightConstraint.constant = frame.size.height - 8.0f;
        self.frame = frame;
    }];
}

- (CGFloat) getHeightOfVisibleCells : (UITableView *) tableView{
    CGFloat height = 0.0f;
    NSArray *paths = [tableView indexPathsForVisibleRows];
    
    for (NSIndexPath *path in paths) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
        height += cell.frame.size.height;
    }
    
    return height;
}

//
- (IBAction)sendButtonTouched:(id)sender{
    [_delegate textView:self message:_textView.text send:self];
    
    //reset view
    [self resetView];
}

- (IBAction)cameraButtonTouhed:(id)sender{
    [_delegate textView:self mediaButton:self touched:YES];
}

- (void) resetView {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(frame.size.width, MESSAGE_VIEW_MIN_HEIGHT);
    self.frame = frame;
    
    [_sendButton setEnabled:NO];

    //set placeholder
    [_textView setText:@""];
}

#pragma mark - Keyboard Show Hide
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void) unregisterForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

//scroll view up
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.superview.frame;
    aRect.origin.y -= kbSize.height;
//    aRect.size.height -= kbSize.height;
    
    [UIView animateWithDuration:10.9f animations:^{
        self.superview.frame = aRect;
    }];
}

//scroll view down
// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    CGRect aRect = self.superview.frame;
    aRect.origin.y = 0;
    
    //resizeView
    /*
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    aRect.size.height += kbSize.height;
     */
    
    [[self superview] setFrame:aRect];
}


@end