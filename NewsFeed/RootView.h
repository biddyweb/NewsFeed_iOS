//
//  RootView.h
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIViewController<UITableViewDelegate,UITableViewDataSource>

// Background Image
@property (strong, nonatomic) IBOutlet UIImageView              *backgroundImageView;
// Header
@property (strong, nonatomic) IBOutlet UIView                   *headerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint       *headerHeight;
@property (strong, nonatomic) IBOutlet UIImageView              *statusBarBackground;
@property (strong, nonatomic) IBOutlet UIImageView              *statusBarLogo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint       *statusBarLogoTopConstraint;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView  *StatusBarActIndi;
@property (strong, nonatomic) IBOutlet UIButton                 *reload_btn;
// FeedItemView
@property (weak, nonatomic) IBOutlet UITableView                *feedItemTableView;
@property (nonatomic, retain) NSMutableArray                    *feedItems;
// Footer
/*@property (strong, nonatomic) IBOutlet UIButton *offline_btn;
@property (strong, nonatomic) IBOutlet UIButton *info_btn;
@property (strong, nonatomic) IBOutlet UIButton *settings_btn;*/
@property (strong, nonatomic) IBOutlet UILabel                  *versionNumber;
// Loading Data View
@property (strong, nonatomic) IBOutlet UIView                   *refreshView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView  *LoadingDataActIndi;
@property (strong, nonatomic) IBOutlet UILabel                  *refreshLabel;

- (IBAction) reloadFeeds:(id)sender;
- (IBAction) showOffline:(id)sender;
- (IBAction) showImprint:(id)sender;
- (IBAction) showSettings:(id)sender;

- (void) startRefreshing;
- (void) endRefreshing;
- (void) updateViewForOrientation:(UIInterfaceOrientation)orientation;
@end

