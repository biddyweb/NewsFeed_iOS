//
//  LoginView.m
//  NewsFeed
//
//  Created by AlexKern on 30.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "LoginView.h"
#import "AppDelegate.h"

@implementation LoginView

// BackgroundImage
@synthesize backgroundImageView;
// StatusBar
@synthesize statusBarBackground;
// LoginItemsContainer
@synthesize containerTopConstraint, containerWidthConstraint, user, password;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LoginView: viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"LoginView: viewWillAppear");
    [self updateViewForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"LoginView: viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"LoginView: viewDidDisappear");
}

- (IBAction)deleteUserText:(id)sender {
    user.text = @"";
}
- (IBAction)deletePwText:(id)sender {
    password.text = @"";
}
- (IBAction)sendUserPw:(id)sender {
    if (([user.text caseInsensitiveCompare:@"wer"] == NSOrderedSame) && [password.text isEqualToString:@"wer"]) {
        [self textFieldReturn:user];
        [self textFieldReturn:password];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LanguageView_SID"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:NULL];}
    else {
        UIAlertView* loginAlertView = [[UIAlertView alloc] initWithTitle:@"Login Failed!"
                                                                 message:@"Wrong User or Password."
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
        [loginAlertView show];}
}

-(IBAction)textFieldShouldReturn:(UITextField*)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];}
    else {
        [textField resignFirstResponder];}
}
-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateViewForOrientation:toInterfaceOrientation];
}
- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation {
    backgroundImageView.image = [UIImage imageNamed:@"MainBackground"];
    containerTopConstraint.constant = SCALEFACTOR_Y * LOGIN_PT_TOP_GAP;
    containerWidthConstraint.constant = SCREEN_PT_WIDTH - 2*LOGIN_HOR_GAP;
    statusBarBackground.hidden = false;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        backgroundImageView.image = [UIImage imageNamed:@"MainBackground_Ls"];
        if ( IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
            containerTopConstraint.constant = LOGIN_LS_TOP_GAP;
        else if (IS_IPHONE_6)
            containerTopConstraint.constant = LOGIN_LS_TOP_GAP + 55;
        else if (IS_IPHONE_6P)
            containerTopConstraint.constant = LOGIN_LS_TOP_GAP + 94;
        statusBarBackground.hidden = true;}
}
@end