//
//  LoginView.h
//  NewsFeed
//
//  Created by AlexKern on 30.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIViewController

// Background Image
@property (strong, nonatomic) IBOutlet UIImageView          *backgroundImageView;
// StatusBar
@property (strong, nonatomic) IBOutlet UIImageView          *statusBarBackground;
// LoginItemsContainer
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *containerTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *containerWidthConstraint;
@property (strong, nonatomic) IBOutlet UITextField          *user;
@property (strong, nonatomic) IBOutlet UITextField          *password;

- (IBAction) deleteUserText:(id)sender;
- (IBAction) deletePwText:(id)sender;
- (IBAction) sendUserPw:(id)sender;
- (IBAction) textFieldShouldReturn:(UITextField*)textField;
- (IBAction) textFieldReturn:(id)sender;

- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation;
@end