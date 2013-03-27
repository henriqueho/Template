//
//  WebViewController.m
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 27/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *strWebsiteUlr = [NSString stringWithFormat:@"http://www.itau.com.br/"];
    
    // Load URL
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:strWebsiteUlr];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    _webviewLink.scalesPageToFit = YES;
    _webviewLink.autoresizesSubviews = YES;
    [_webviewLink loadRequest:requestObj];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    swipeLeft.delegate = self;
    [_webviewLink addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRight.delegate = self;
    [_webviewLink addGestureRecognizer:swipeRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setActivityIndicator:nil];
    [self setWebviewLink:nil];
    [super viewDidUnload];
}

#pragma ###################################################################################################################
#pragma mark - Custom Methods

-(void)swipeLeftAction:(id)ignored{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma ###################################################################################################################
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma ###################################################################################################################
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        //[[UIApplication sharedApplication] openURL:[request URL]];
        
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [_activityIndicator startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [_activityIndicator stopAnimating];
    _activityIndicator.hidden = YES;
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
