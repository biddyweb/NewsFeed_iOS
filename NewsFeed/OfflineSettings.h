//
//  OfflineSettings.h
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfflineSettings : UIViewController

// Background Image
@property (strong, nonatomic) IBOutlet UIImageView              *backgroundImageView;
// Header
@property (strong, nonatomic) IBOutlet UIView                   *headerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint       *headerHeight;
@property (strong, nonatomic) IBOutlet UIImageView              *statusBarBackground;
@property (strong, nonatomic) IBOutlet UIImageView              *statusBarLogo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint       *statusBarLogoTopConstraint;

- (IBAction)close:(id)sender;
// Content
@property (strong, nonatomic) IBOutlet UILabel                  *offlineSettingsHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel                  *offlineSettingsExplanationLabel;
@property (strong, nonatomic) IBOutlet UILabel                  *offlineSettingsSyncVideoLabel;
@property (strong, nonatomic) IBOutlet UISwitch                 *syncVideo_switch;
@property (strong, nonatomic) IBOutlet UILabel                  *offlineSettingsSyncPDFLabel;
@property (strong, nonatomic) IBOutlet UISwitch                 *syncPDF_switch;
@property (strong, nonatomic) IBOutlet UILabel                  *connectionHintLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView  *DownloadActIndi;
@property (strong, nonatomic) IBOutlet UIButton                 *Download_btn;


- (IBAction)downloadButton:(id)sender;

- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation;
@end

