//
//  WebViewController.h
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 27/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webviewLink;

@end
