//
//  RootView.m
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "RootView.h"
#import "AppDelegate.h"
#import "ItemCellLayout.h"

@interface RootView ()

@end

@implementation RootView

// BackgroundImage
@synthesize backgroundImageView;
// Header
@synthesize headerView, headerHeight, statusBarBackground, statusBarLogo, statusBarLogoTopConstraint, reload_btn, StatusBarActIndi;
// FeedItemsView
@synthesize feedItemTableView, feedItems;
//Footer
@synthesize versionNumber;//, offline_btn, info_btn, settings_btn;

@synthesize refreshView, LoadingDataActIndi, refreshLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"RootView: viewDidLoad");
    StatusBarActIndi.transform = CGAffineTransformMakeScale(1.3, 1.3);//make it bigger
    refreshLabel.text = AMLocalizedString(@"refreshViewLoadingData", @"Loading data ...");
    //LoadingDataActIndi.transform = CGAffineTransformMakeScale(1.3, 1.3);
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"RootView: viewWillAppear");
    [self updateViewForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    if (SHOW_VERSIONNUMBER)
        versionNumber.text = [NSString stringWithFormat:@"Version: %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}
- (void) viewWillDisappear:(BOOL)animated {
    NSLog(@"RootView: viewWillDisappear");
    [self endRefreshing];
}
- (void) viewDidDisappear:(BOOL)animated {
    NSLog(@"RootView: viewDidDisappear");    
}

#pragma mark TableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"CellID";
    ItemCellLayout *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCellLayout" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // tapArea
    cell.tapArea.tag = indexPath.row;
    [cell.tapArea addTarget:self action:@selector(showItem:) forControlEvents:UIControlEventTouchUpInside];
    // allocate cell-contents
    cell.itemThumbnail.image = [UIImage imageNamed:@"platzhalter"];
    cell.itemDate.text = [NSString stringWithFormat:@"%ld.08.2015",(long)indexPath.row];
    cell.itemSource.text = [NSString stringWithFormat:@"itemSource-# %ld selected",(long)indexPath.row];
    cell.itemTitle.text = [NSString stringWithFormat:@"Here is the itemTitle-text of item # %ld with linebreak",(long)indexPath.row];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (IBAction)showItem:(id)sender {
    UIButton *DisButton = (UIButton *)sender;
    NSLog(@"item-# %ld tapped",(long)DisButton.tag);
}

#pragma mark - Button Methods
- (IBAction)reloadFeeds:(id)sender {
    NSLog(@"reloadFeeds-Button tapped");
    [self startRefreshing];
    //TODO Next
}
- (IBAction)showOffline:(id)sender {
    NSLog(@"showOffline-Button tapped");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"OfflineSettingsView_SID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}
- (IBAction)showImprint:(id)sender {
    NSLog(@"showImprint-Button tapped");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ImprintView_SID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}
- (IBAction)showSettings:(id)sender {
    NSLog(@"showSettings-Button tapped");
    
}

#pragma mark - ActivityIndication
- (void)startRefreshing {
    reload_btn.hidden = YES;
    StatusBarActIndi.hidden = NO;
    [StatusBarActIndi startAnimating];
    feedItemTableView.alpha = 0.3;
    feedItemTableView.userInteractionEnabled = NO;
    [LoadingDataActIndi startAnimating];
    refreshView.hidden = NO;
}
- (void)endRefreshing {
    [StatusBarActIndi stopAnimating];
    reload_btn.hidden = NO;
    feedItemTableView.alpha = 1.0;
    feedItemTableView.userInteractionEnabled = YES;
    [LoadingDataActIndi stopAnimating];
    refreshView.hidden = YES;
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateViewForOrientation: toInterfaceOrientation];
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
/*-(UIImage *) ChangeImageViewToImage : (UIImageView *) view{
 UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
 [view.layer renderInContext:UIGraphicsGetCurrentContext()];
 UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return img;
 }*/
@end