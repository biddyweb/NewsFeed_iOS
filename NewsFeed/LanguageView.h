//
//  LanguageView.h
//  NewsFeed
//
//  Created by AlexKern on 30.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageView : UIViewController

// Background Image
@property (strong, nonatomic) IBOutlet UIImageView          *backgroundImageView;
// StatusBar
@property (strong, nonatomic) IBOutlet UIImageView          *statusBarBackground;
// LoginItemsContainer
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *containerTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *containerHeightConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *selectEnglishWidth;
@property (strong, nonatomic) IBOutlet UIButton             *selectEnglish_btn;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *selectDeutschWidth;
@property (strong, nonatomic) IBOutlet UIButton             *selectDeutsch_btn;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *selectDanskWidth;
@property (strong, nonatomic) IBOutlet UIButton             *selectDansk_btn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *secondRowTop;

@property (strong, nonatomic) IBOutlet UIButton             *chooseFeed;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *chooseFeedWidth;

- (IBAction) selectEnglish:(id)sender;
- (IBAction) selectDeutsch:(id)sender;
- (IBAction) selectDansk:(id)sender;
- (IBAction) chooseFeed:(id)sender;

- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation;
@end