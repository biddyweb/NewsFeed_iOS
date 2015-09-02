//
//  selectFeedView.h
//  NewsFeed
//
//  Created by AlexKern on 03.08.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectFeedView : UIViewController

@property (retain, nonatomic) NSMutableArray                                    *selectFeedViewFeedList;
// Background Image
@property (strong, nonatomic) IBOutlet UIImageView                              *backgroundImageView;
// StatusBar
@property (strong, nonatomic) IBOutlet UIImageView                              *statusBarBackground;
// LoginItemsContainer
@property (strong, nonatomic) IBOutlet NSLayoutConstraint                       *containerTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint                       *containerHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel                                  *selectFeedHeadline;
// Feed-buttons
@property (strong, nonatomic) IBOutletCollection(UIButton)NSArray               *selectFeed_btn;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray    *selectFeedWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint                       *secondRowTop;
// readFeed-button
@property (strong, nonatomic) IBOutlet UIButton                                 *readFeed;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint                       *readFeedWidth;

- (IBAction) select:(id)sender;
- (IBAction) readFeed:(id)sender;

- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation;
@end
