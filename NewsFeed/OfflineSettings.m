//
//  OfflineSettings.m
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "OfflineSettings.h"
#import "AppDelegate.h"

@interface OfflineSettings ()
@end

@implementation OfflineSettings
NSUserDefaults *userDefaults;
bool isCancelButton;
// BackgroundImage
@synthesize backgroundImageView;
// Header
@synthesize headerView, headerHeight, statusBarBackground, statusBarLogo, statusBarLogoTopConstraint, offlineSettingsHeaderLabel, offlineSettingsExplanationLabel, offlineSettingsSyncVideoLabel, syncVideo_switch, offlineSettingsSyncPDFLabel, syncPDF_switch, connectionHintLabel, DownloadActIndi, Download_btn;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"OfflineSettings: viewDidLoad");
    userDefaults = [NSUserDefaults standardUserDefaults];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"OfflineSettings: viewWillAppear");
    syncVideo_switch.on = [userDefaults boolForKey:PREF_SYNC_VIDEOS];
    syncPDF_switch.on = [userDefaults boolForKey:PREF_SYNC_PDFS];
    [self updateViewForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    [self nameObjects];
    if (APP_DELEGATE.internetReachableViaWlan) {
        connectionHintLabel.hidden = true;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [userDefaults setBool:syncVideo_switch.on forKey:PREF_SYNC_VIDEOS];
    [userDefaults setBool:syncPDF_switch.on forKey:PREF_SYNC_PDFS];
    [userDefaults synchronize];
}

#pragma mark - Button Methods
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)downloadButton:(id)sender {
    if (!isCancelButton) {
        offlineSettingsHeaderLabel.text         = AMLocalizedString(@"offlineSettingsHeaderLabel_Download", @"wait until");
        offlineSettingsExplanationLabel.text    = AMLocalizedString(@"offlineSettingsExplanationLabel_Download", @"Please be patient");
        offlineSettingsSyncVideoLabel.hidden = YES;
        syncVideo_switch.hidden = YES;
        offlineSettingsSyncPDFLabel.hidden = YES;
        syncPDF_switch.hidden = YES;
        DownloadActIndi.transform = CGAffineTransformMakeScale(1.3, 1.3);//make it bigger
        [DownloadActIndi startAnimating];
        [Download_btn setTitle:AMLocalizedString(@"offlineSettingsDownloadButton", @"Cancel") forState:UIControlStateNormal];}
    else {
        offlineSettingsHeaderLabel.text         = AMLocalizedString(@"offlineSettingsHeaderLabel", @"download all news");
        offlineSettingsExplanationLabel.text    = AMLocalizedString(@"offlineSettingsExplanationLabel", @"explain download");
        offlineSettingsSyncVideoLabel.hidden = NO;
        syncVideo_switch.hidden = NO;
        offlineSettingsSyncPDFLabel.hidden = NO;
        syncPDF_switch.hidden = NO;
        [DownloadActIndi stopAnimating];
        [Download_btn setTitle:@"Download" forState:UIControlStateNormal];}
    isCancelButton = (isCancelButton) ? (isCancelButton = NO) : (isCancelButton = YES);
    //NSLog(@"isCancelButton: %d",isCancelButton);
}

#pragma mark - name Objects
- (void) nameObjects {
    offlineSettingsHeaderLabel.text         = AMLocalizedString(@"offlineSettingsHeaderLabel", @"download all news");
    offlineSettingsExplanationLabel.text    = AMLocalizedString(@"offlineSettingsExplanationLabel", @"explain download");
    offlineSettingsSyncVideoLabel.text      = AMLocalizedString(@"offlineSettingsVideoSyncLabel", @"save Video");
    offlineSettingsSyncPDFLabel.text        = AMLocalizedString(@"offlineSettingsSyncPDFLabel", @"save PDF");
    //[readFeed setTitle: AMLocalizedString(@"readFeedButton", @"Read news now") forState: UIControlStateNormal];
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateViewForOrientation: toInterfaceOrientation];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
}
- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation {
    backgroundImageView.image = [UIImage imageNamed:@"MainBackground"];
    headerHeight.constant = ROOT_HEADER_HEIGHT + ROOT_STATUSBAR_LOGO_TOP;
    statusBarBackground.hidden = false;
    statusBarLogoTopConstraint.constant = ROOT_STATUSBAR_LOGO_TOP;
    statusBarLogo.image = [UIImage imageNamed:@"StatusBarLogo"];
    // Landscape
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        backgroundImageView.image = [UIImage imageNamed:@"MainBackground_Ls"];
        headerHeight.constant = ROOT_HEADER_HEIGHT;
        statusBarBackground.hidden = true;
        statusBarLogoTopConstraint.constant = 0.0;
        statusBarLogo.image = [UIImage imageNamed:@"StatusBarLogo_Ls"];}
}
@end