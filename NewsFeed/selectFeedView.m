//
//  selectFeedView.m
//  NewsFeed
//
//  Created by AlexKern on 03.08.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "selectFeedView.h"
#import "AppDelegate.h"

@implementation selectFeedView

@synthesize selectFeedViewFeedList, backgroundImageView, statusBarBackground;
// selectItemsContainer
@synthesize containerTopConstraint, containerHeightConstraint, selectFeedHeadline, selectFeed_btn, selectFeedWidth, secondRowTop, readFeed, readFeedWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"selectFeedView: viewDidLoad");
    [self setFeedsOnFirstRun];
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"selectFeedView: viewWillAppear");
    [self nameObjects];
    [self updateViewForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"selectFeedView: viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"selectFeedView: viewDidDisappear");
}

#pragma mark - button methods
- (IBAction)select:(id)sender {
    UIButton *DisButton = (UIButton *)sender;
    long tag = DisButton.tag;
    //NSLog(@"tag: %ld",tag);
    if ([selectFeedViewFeedList[tag][1] boolValue]) { //YES
        [DisButton setImage:[UIImage imageNamed:@"leer.png"] forState:UIControlStateNormal];
        selectFeedViewFeedList[tag][1] = @NO;}
    else {
        [DisButton setImage:[UIImage imageNamed:@"checkMark.png"] forState:normal];
        selectFeedViewFeedList[tag][1] = @YES;}
}
- (IBAction)readFeed:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:selectFeedViewFeedList forKey:PREF_FEEDS_SELECTS];
    NSLog(@"LocalizationGetLanguage: %@",LocalizationGetLanguage);
    [[NSUserDefaults standardUserDefaults] setValue:LocalizationGetLanguage forKey:PREF_LANGUAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RootView_SID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
}

#pragma mark - Feed Array
- (void) setFeedsOnFirstRun {
    //NSLog(@"LoginViewController: setFeedsOnFirstRun");
    selectFeedViewFeedList = [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"Group Airlines",@YES,@"http://thomascookgroupairlines-newsroom.condor.com/app/feed/gas-channel.xml", @"GAS", nil], nil];
    [selectFeedViewFeedList addObject:[[NSMutableArray alloc] initWithObjects:@"Condor",@NO,@"http://condor-newsroom.condor.com/app/feed/de-channel.xml", @"DE", nil]];
    [selectFeedViewFeedList addObject:[[NSMutableArray alloc] initWithObjects:@"TCX",@NO,@"http://thomascookairlinesuk-newsroom.condor.com/app/feed/uk-channel.xml", @"UK", nil]];
    [selectFeedViewFeedList addObject:[[NSMutableArray alloc] initWithObjects:@"TCAB",@NO, @"http://thomascookairlinesbelgium-newsroom.condor.com/app/feed/be-channel.xml", @"BE", nil]];
    [selectFeedViewFeedList addObject:[[NSMutableArray alloc] initWithObjects:@"TCAS",@NO, @"http://thomascookairlinesscandinavia-newsroom.condor.com/app/feed/sk-channel.xml", @"SK", nil]];
    [selectFeedViewFeedList addObject:[[NSMutableArray alloc] initWithObjects:@"GMO",@NO, @"http://condor-newsroom.condor.com/app/feed/gmo-channel.xml", @"GMO", nil]];
}
- (void) nameObjects {
    selectFeedHeadline.text = AMLocalizedString(@"selectFeedHeadline", @"choose one or more news feeds");
    for (UIButton *b in selectFeed_btn) {
        /*if (IS_IPHONE_4_OR_LESS && ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) && b.tag>2) {
            if (b.tag == 3)
                [b setTitle: @"Thomas Cook Airlines BG" forState: UIControlStateNormal];
            else if (b.tag == 4)
                [b setTitle: @"Thomas Cook Airlines SK" forState: UIControlStateNormal];
            else if (b.tag == 4)
                [b setTitle: @"Group Maintenance Orga" forState: UIControlStateNormal];}*/
        [b setTitle: selectFeedViewFeedList[b.tag][0] forState: UIControlStateNormal];
    }
    [readFeed setTitle: AMLocalizedString(@"readFeedButton", @"Read news now") forState: UIControlStateNormal];
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateViewForOrientation:toInterfaceOrientation];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    //[self nameObjects]; // only if text changes on orientation change
}
- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation {
    backgroundImageView.image = [UIImage imageNamed:@"MainBackground"];
    statusBarBackground.hidden = false;
    CGFloat chooseFeedControlsWidth = SCREEN_PT_WIDTH - 2*LOGIN_HOR_GAP;
    if (IS_IPHONE_4_OR_LESS)
        containerTopConstraint.constant = SCALEFACTOR_Y * LOGIN_PT_TOP_GAP - 2*(LOGIN_CONTROLS_HEIGHT+LOGIN_CONTROLS_HEIGHT_SPACE);
    else
        containerTopConstraint.constant = SCALEFACTOR_Y * LOGIN_PT_TOP_GAP - LOGIN_CONTROLS_HEIGHT - LOGIN_CONTROLS_HEIGHT_SPACE;
    
    containerHeightConstraint.constant = 8*(LOGIN_CONTROLS_HEIGHT + LOGIN_CONTROLS_HEIGHT_SPACE) + LOGIN_CONTROLS_LASTBUTTON_SPACE;
    secondRowTop.constant = 3*LOGIN_CONTROLS_HEIGHT+4*LOGIN_CONTROLS_HEIGHT_SPACE;
    readFeedWidth.constant = chooseFeedControlsWidth;
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
        containerHeightConstraint.constant = 5*(LOGIN_CONTROLS_HEIGHT + LOGIN_CONTROLS_HEIGHT_SPACE) + LOGIN_CONTROLS_LASTBUTTON_SPACE;
        chooseFeedControlsWidth = (SCREEN_PT_HEIGHT-3*LOGIN_HOR_GAP)/2;
        secondRowTop.constant = LOGIN_CONTROLS_HEIGHT_SPACE;}
    for (NSLayoutConstraint *c in selectFeedWidth)
        c.constant = chooseFeedControlsWidth;
    CGFloat imageInsetLeft = chooseFeedControlsWidth - LOGIN_CONTROLS_HEIGHT;
    for (UIButton *b in selectFeed_btn)
        [b setImageEdgeInsets:UIEdgeInsetsMake(0, imageInsetLeft, 0, 0)];
}
@end
