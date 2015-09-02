//
//  LanguageView.m
//  NewsFeed
//
//  Created by AlexKern on 30.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "LanguageView.h"
#import "AppDelegate.h"

@implementation LanguageView

// BackgroundImage
@synthesize backgroundImageView;
// StatusBar
@synthesize statusBarBackground;
// LoginItemsContainer
@synthesize containerTopConstraint, containerHeightConstraint, selectEnglishWidth,selectEnglish_btn, selectDeutschWidth, selectDeutsch_btn, selectDanskWidth, selectDansk_btn, secondRowTop, chooseFeed, chooseFeedWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"LanguageView: viewDidLoad");
    [selectEnglish_btn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"LanguageView: viewWillAppear");
    [self updateViewForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"LanguageView: viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"LanguageView: viewDidDisappear");
}

#pragma mark - button methods
- (IBAction)selectEnglish:(id)sender {
    if (![LocalizationGetLanguage isEqualToString:@"en"])
        LocalizationSetLanguage(@"en");
    [selectDeutsch_btn setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
    [selectDansk_btn setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
    [selectEnglish_btn setImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
    [chooseFeed setTitle: AMLocalizedString(@"choose_feeds_button", @"Wählen Sie Ihre News-Feeds") forState: UIControlStateNormal];
}
- (IBAction)selectDeutsch:(id)sender {
    [selectEnglish_btn setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
    [selectDansk_btn setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
    [selectDeutsch_btn setImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
    if (![LocalizationGetLanguage isEqualToString:@"de"])
        LocalizationSetLanguage(@"de");
    [chooseFeed setTitle: AMLocalizedString(@"choose_feeds_button", @"Wählen Sie Ihre News-Feeds") forState: UIControlStateNormal];
}
- (IBAction)selectDansk:(id)sender {
    [selectEnglish_btn setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
    [selectDeutsch_btn setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
    [selectDansk_btn setImage:[UIImage imageNamed:@"checkMark.png"] forState:UIControlStateNormal];
    if (![LocalizationGetLanguage isEqualToString:@"da"])
        LocalizationSetLanguage(@"da");
    [chooseFeed setTitle: AMLocalizedString(@"choose_feeds_button", @"Wählen Sie Ihre News-Feeds") forState: UIControlStateNormal];
}

- (IBAction)chooseFeed:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"selectFeedView_SID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateViewForOrientation:toInterfaceOrientation];
}
- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation {
    backgroundImageView.image = [UIImage imageNamed:@"MainBackground"];
    statusBarBackground.hidden = false;
    CGFloat chooseFeedControlsWidth = SCREEN_PT_WIDTH - 2*LOGIN_HOR_GAP;
    containerTopConstraint.constant = SCALEFACTOR_Y * LOGIN_PT_TOP_GAP - LOGIN_CONTROLS_HEIGHT - LOGIN_CONTROLS_HEIGHT_SPACE;
    containerHeightConstraint.constant = 5*(LOGIN_CONTROLS_HEIGHT + LOGIN_CONTROLS_HEIGHT_SPACE) + LOGIN_CONTROLS_LASTBUTTON_SPACE;
    secondRowTop.constant = 2*LOGIN_CONTROLS_HEIGHT+3*LOGIN_CONTROLS_HEIGHT_SPACE;
    chooseFeedWidth.constant = chooseFeedControlsWidth;
    // Landscape
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        backgroundImageView.image = [UIImage imageNamed:@"MainBackground_Ls"];
        statusBarBackground.hidden = true;
        if ( IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
            containerTopConstraint.constant = LOGIN_LS_TOP_GAP - LOGIN_CONTROLS_HEIGHT - LOGIN_CONTROLS_HEIGHT_SPACE;
        else if (IS_IPHONE_6)
            containerTopConstraint.constant = LOGIN_LS_TOP_GAP - LOGIN_CONTROLS_HEIGHT - LOGIN_CONTROLS_HEIGHT_SPACE + 55;
        else if (IS_IPHONE_6P)
            containerTopConstraint.constant = LOGIN_LS_TOP_GAP - LOGIN_CONTROLS_HEIGHT - LOGIN_CONTROLS_HEIGHT_SPACE + 94;
        containerHeightConstraint.constant = 4*(LOGIN_CONTROLS_HEIGHT + LOGIN_CONTROLS_HEIGHT_SPACE) + LOGIN_CONTROLS_LASTBUTTON_SPACE;
        chooseFeedControlsWidth = (SCREEN_PT_HEIGHT-3*LOGIN_HOR_GAP)/2;
        secondRowTop.constant = LOGIN_CONTROLS_HEIGHT_SPACE;}
    selectEnglishWidth.constant = selectDeutschWidth.constant = selectDanskWidth.constant = chooseFeedControlsWidth;
    CGFloat imageInsetLeft = chooseFeedControlsWidth - LOGIN_CONTROLS_HEIGHT;
    [selectEnglish_btn setImageEdgeInsets:UIEdgeInsetsMake(0, imageInsetLeft, 0, 0)];
    [selectDeutsch_btn setImageEdgeInsets:UIEdgeInsetsMake(0, imageInsetLeft, 0, 0)];
    [selectDansk_btn setImageEdgeInsets:UIEdgeInsetsMake(0, imageInsetLeft, 0, 0)];
}
@end