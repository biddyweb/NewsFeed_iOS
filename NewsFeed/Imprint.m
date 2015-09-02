//
//  Imprint.m
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import "Imprint.h"
#import "AppDelegate.h"

@interface Imprint ()

@end

@implementation Imprint

// BackgroundImage
@synthesize backgroundImageView;
// Header
@synthesize headerView, headerHeight, statusBarBackground, statusBarLogo, statusBarLogoTopConstraint;
// Content
@synthesize headline, htmlContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Imprint: viewDidLoad");
    headline.text = AMLocalizedString(@"ImprintHeadline", @"ImprintHeadline");
    headline.textContainerInset = UIEdgeInsetsMake(0, -6, 0, 0);
/*
    content.text = AMLocalizedString(@"ImprintContent", @"ImprintContent");
    content.textContainerInset = UIEdgeInsetsMake(0, -6, 0, 0);
    // url-link-color
    content.tintColor = [UIColor colorWithRed: 248.0/255.0 green: 172.0/255.0 blue: 0.0/255.0 alpha:1];
*/
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Imprint: viewWillAppear");
    [self updateViewForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    [self renderWithInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

#pragma mark - WebViewContent
- (void)renderWithInterfaceOrientation:(UIInterfaceOrientation) orientation {
    NSString *basePathCss = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"Imprint, renderWithInterfaceOrientation: basePathCss: %@",basePathCss);
    NSURL *baseURLcss = [NSURL fileURLWithPath:basePathCss];
    //NSLog(@"Imprint, renderWithInterfaceOrientation: baseURLcss: %@",baseURLcss);
    /* Stylesheet */
    NSString *filePathCSS = [[NSBundle mainBundle] pathForResource:@"StyleSheetImprint" ofType:@"css"];
    //NSLog(@"Imprint, renderWithInterfaceOrientation: filePathCSS: %@",filePathCSS);
    /* up to body */
    NSMutableString *html = [[NSMutableString alloc] initWithString:@"<html style=\"-webkit-text-size-adjust: none\"><head>"];
    [html appendFormat:@"<link href=\"%@\" rel=\"stylesheet\" type=\"text/css\" />", filePathCSS];
    [html appendString:@"<meta name='viewport' content='initial-scale=1.0,maximum-scale=10.0'/>"];
    [html appendString:@"</head>"];
    if (IS_IPAD) [html appendString:@"<body class=\"iPad\">"];
    else [html appendString:@"<body class=\"iPhone\"><div>"];
    //NSLog(@"Imprint, renderWithInterfaceOrientation: up to Body: %@",html);
    /* content from textfile: */
    NSString *path = [NSString stringWithFormat:@"Imprint_%@",LocalizationGetLanguage];
    //TODO check if textfile available
    NSString *textFile = [[NSBundle mainBundle] pathForResource:path ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:textFile encoding:NSUTF8StringEncoding error:nil];
    /* End content */
    [html appendString:content];
    [html appendString:@"</div></body></html>"];
    //NSLog(@"HTML %@",html);
    [htmlContent loadHTMLString:html baseURL:baseURLcss];
}
//WebView Delegate: open links in external browser
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    //NSLog(@"Imprint: shouldStartLoadWithRequest");
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        //NSLog(@"Imprint, shouldStartLoadWithRequest: UIWebViewNavigationTypeLinkClicked");
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;}
    return YES;
}

#pragma mark - Button Methods
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateViewForOrientation: toInterfaceOrientation];
    [self renderWithInterfaceOrientation:toInterfaceOrientation];
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