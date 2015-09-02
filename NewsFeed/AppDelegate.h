//
//  AppDelegate.h
//  NewsFeed
//
//  Created by AlexKern on 31.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LocalizationSystem.h"

// Versionnumber
#define SHOW_VERSIONNUMBER YES // NO or YES

#define APP_DELEGATE ((AppDelegate*)[UIApplication sharedApplication].delegate)
#define IS_IPAD ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
// Width/Height depends on orientation at app-start!
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_PT_HEIGHT (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_PT_WIDTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_PT_HEIGHT < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_PT_HEIGHT == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_PT_HEIGHT == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_PT_HEIGHT == 736.0)
#define SCALEFACTOR_Y (IS_IPHONE_6P ? (736.0/568.0) : (IS_IPHONE_6 ? (667.0/568.0) : (IS_IPHONE_5 ? 1.0 : (480.0/568.0))))
/*****CONSTRAINTS*****/
// Login
#define LOGIN_HOR_GAP 10.0
#define LOGIN_PT_TOP_GAP 185.0 //Top of first interaction-label
#define LOGIN_LS_TOP_GAP 74.0
#define LOGIN_CONTROLS_HEIGHT 40.0
#define LOGIN_CONTROLS_HEIGHT_SPACE 2.0
#define LOGIN_CONTROLS_LASTBUTTON_SPACE 18.0
// RootView
#define ROOT_HEADER_HEIGHT 44.0
#define ROOT_STATUSBAR_LOGO_TOP 20.0

//userDefault-keys
#define PREF_LANGUAGE @"language"
#define PREF_FEEDS_SELECTS @"feeds_selects"
#define PREF_SYNC_VIDEOS @"sync_videos"
#define PREF_SYNC_PDFS @"sync_pdfs"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property BOOL internetReachable;
@property BOOL internetReachableViaWlan;
//@property BOOL needsRefresh;
//@property BOOL wantsRefresh;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

