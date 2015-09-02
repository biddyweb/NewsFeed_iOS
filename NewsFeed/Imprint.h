//
//  Imprint.h
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Imprint : UIViewController <UIWebViewDelegate>

// Background Image
@property (strong, nonatomic) IBOutlet UIImageView          *backgroundImageView;
// Header
@property (strong, nonatomic) IBOutlet UIView               *headerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *headerHeight;
@property (strong, nonatomic) IBOutlet UIImageView          *statusBarBackground;
@property (strong, nonatomic) IBOutlet UIImageView          *statusBarLogo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint   *statusBarLogoTopConstraint;
// Content
@property (strong, nonatomic) IBOutlet UITextView           *headline;
@property (strong, nonatomic) IBOutlet UIWebView            *htmlContent;


- (IBAction)close:(id)sender;

- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation;
@end

