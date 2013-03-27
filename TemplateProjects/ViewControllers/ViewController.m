//
//  ViewController.m
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 26/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import "ViewController.h"
#import "BannerController.h"

@interface ViewController ()
    @property (nonatomic) BOOL expandBanner;
    @property (nonatomic) CGRect bannerRect;
@end

@implementation ViewController

dispatch_queue_t queueBanner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    queueBanner = dispatch_queue_create("com.HomeBanner.queue",nil);
    
    dispatch_async(queueBanner, ^{
        __block BOOL banner = [BannerController didLoadBannerFooter:[self bannerWebView] forEditorial:K_BANNER_EDITORIA_HOME];
		dispatch_async(dispatch_get_main_queue(), ^{
            if (banner) {
//                [self resizeViewItens];
//                [[self webViewBanner] setHidden:NO];
                _bannerWebView.scrollView.scrollEnabled = NO;
                _bannerWebView.scrollView.bounces = NO;
                
                UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownAction:)];
                swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
                swipeDown.delegate = self;
                [_bannerWebView addGestureRecognizer:swipeDown];
                
                UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpAction:)];
                swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
                swipeUp.delegate = self;
                [_bannerWebView addGestureRecognizer:swipeUp];
            }
		});
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBannerWebView:nil];
    [super viewDidUnload];
}

#pragma ###################################################################################################################
#pragma mark - Custom Methods

-(void)swipeDownAction:(id)ignored{
    if(self.expandBanner){
        [UIView animateWithDuration:0.3 animations:^{
            _bannerWebView.frame = CGRectMake(0,self.bannerRect.origin.y,self.bannerRect.size.width,self.bannerRect.size.height);
        }];
        self.expandBanner = NO;
    }
    
}

-(void)swipeUpAction:(id)ignored{
    CGRect rectExpand = [[UIScreen mainScreen] bounds];
    if(!self.expandBanner){
        _bannerRect = _bannerWebView.frame;
        
        [UIView animateWithDuration:0.3 animations:^{
           _bannerWebView.frame = CGRectMake(0, 0, rectExpand.size.width, rectExpand.size.height);
        }];
        self.expandBanner = YES;
        
    }
    
}

- (void) expandWebView:(NSURLRequest *)request {
    
    
    CGRect rectExpand = [[UIScreen mainScreen] bounds];
    if(!self.expandBanner){
        _bannerRect = _bannerWebView.frame;
        
        [UIView animateWithDuration:0.5 animations:^{
            _bannerWebView.frame = CGRectMake(0, 0, rectExpand.size.width, rectExpand.size.height);
        }];
        self.expandBanner = YES;
    }
//    else{
//        
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//        TermsSeviceViewController *tutorialViewController = [storyboard instantiateViewControllerWithIdentifier:@"webViewTerms"];
//        tutorialViewController.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
//        tutorialViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
//        [self presentViewController:tutorialViewController animated:YES completion:^{
//            [UIView animateWithDuration:1.5 animations:^{
//                self.webViewBanner.alpha = 0;
//            }];
//            self.webViewBanner.alpha = 1;
//            
//            self.webViewBanner.frame = CGRectMake(0,self.bannerRect.origin.y,self.bannerRect.size.width,self.bannerRect.size.height);
//        }];
//        
//        self.expandBanner = NO;
//    }
    
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
        [self expandWebView: request];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [_bannerWebView setHidden:NO];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
