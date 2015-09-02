//
//  LocalizationSystem.m
//  NewsFeed
//
//  Created by AlexKern on 30.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "LocalizationSystem.h"

@implementation LocalizationSystem

// Singleton instance
static LocalizationSystem *_sharedLocalSystem = nil;

// Current application bungle to get the languages.
static NSBundle *bundle = nil;

+ (LocalizationSystem *)sharedLocalSystem {
	@synchronized([LocalizationSystem class]) {
		if (!_sharedLocalSystem)
			_sharedLocalSystem = [[self alloc] init];
		return _sharedLocalSystem;
	}
	// to avoid compiler warning
	return nil;
}

+(id)alloc {
	@synchronized([LocalizationSystem class]) {
		NSAssert(_sharedLocalSystem == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedLocalSystem = [super alloc];
		return _sharedLocalSystem;
	}
	// to avoid compiler warning
	return nil;
}


- (id)init {
    if ((self = [super init]))
		bundle = [NSBundle mainBundle];
    return self;
}

// returns the text for the selected language
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment {
	return [bundle localizedStringForKey:key value:comment table:nil];
}

- (void) setLanguage:(NSString*) l {
	NSString *path = [[ NSBundle mainBundle ] pathForResource:l ofType:@"lproj" ];
	if (path == nil)
        bundle = [NSBundle bundleWithPath:[[ NSBundle mainBundle ] pathForResource:@"Base" ofType:@"lproj" ]];
	else
		bundle = [NSBundle bundleWithPath:path];
}

- (NSString*) getLanguage {
    NSString *bundlestring =  [bundle resourcePath];
    // NSLog(@"bundlepath: %@",bundlestring);
    NSString *preferredLang = [[NSLocale preferredLanguages] objectAtIndex:0];
    // NSLog(@"preferredLang: %@",preferredLang);
    if (!([bundlestring rangeOfString:@".lproj"].location == NSNotFound)) {
        NSRange nameRange = [bundlestring rangeOfString:@".lproj"];
        nameRange = NSMakeRange(nameRange.location-2, 2);
        preferredLang = [bundlestring substringWithRange:nameRange];
    }
	return preferredLang;
}

// Resets the localization system, so it uses the OS default language.
- (void) resetLocalization {
	bundle = [NSBundle mainBundle];
}
@end