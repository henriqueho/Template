//
//  ViewController.h
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 26/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *bannerWebView;

@end
