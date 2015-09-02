//
//  main.m
//  NewsFeed
//
//  Created by AlexKern on 31.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        LocalizationSetLanguage([[NSUserDefaults standardUserDefaults] valueForKey:PREF_LANGUAGE]);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
