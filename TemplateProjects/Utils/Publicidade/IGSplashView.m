//
//  IGSplashView.m
//  IGUtilProject
//
//  Created by Pedro Valentini on 09/06/11.
//  Copyright 2011 Infoglobo. All rights reserved.
//

#import "IGSplashView.h"
#import "IGUtil.h"


@implementation IGSplashView


- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) 
    {
        self.isAnimation = NO;
        self.timer = nil;
        self.fadeTimer = nil;        
        fadeSeconds = 1.0;
        showSeconds = K_SPLASH_TIME_IN_SECONDS_APP + fadeSeconds;
        if (_isAnimation) {
            IGDEBUG(@"Splash animado: %@", @"Sim");
            showSeconds =showSeconds+ 8;
        }
        self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:self.imageView];

    }
    return self;
}

- (id)initSecondSplash
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self)
    {
        self.isAnimation = NO;
        self.timer = nil;
        self.fadeTimer = nil;        
        fadeSeconds = 0.6;
        showSeconds = K_SPLASH_TIME_IN_SECONDS_APP+K_SPLASH_TIME_IN_SECONDS_PATROCINIO + (2*fadeSeconds);
        self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect fixedRect = [[UIScreen mainScreen] bounds];
    fixedRect.origin.y = -20;
    [self setFrame:fixedRect];
//    [self setFrame:[[UIScreen mainScreen] applicationFrame]];
//    [self setFrame:[[UIScreen mainScreen] bounds]];

    if (self.imageView) {
        if (_isAnimation) {
           // IGDEBUG(@"Splash animado: %@", @"Sim");
        } else {
            [self.imageView setFrame:[[UIScreen mainScreen] bounds]];
            
        }
        [self.imageView setImage:[UIImage imageWithContentsOfFile:self.imagePath]];
    }
}

- (void)showForSeconds:(NSTimeInterval)seconds fadeForSeconds:(NSTimeInterval)_fadeSeconds
{
    [self setNeedsDisplay];
    
//    showSeconds = seconds;
//    fadeSeconds = _fadeSeconds;
 
    if (self.timer) {
        [self.timer invalidate];
        [self.fadeTimer invalidate];
    }
    
    self.fadeTimer = [NSTimer scheduledTimerWithTimeInterval:seconds - _fadeSeconds - 0.1
                                              target:self 
                                            selector:@selector(fadeOut) 
                                            userInfo:nil 
                                             repeats:NO];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                              target:self 
                                            selector:@selector(removeFromSuperview) 
                                            userInfo:nil 
                                             repeats:NO];
}

- (void)show 
{
    if (_isAnimation) {

        [UIView animateWithDuration:K_SPLASH_TIME_IN_SECONDS_APP+8 animations:^{
//            CGRect imageFixedRect = [[UIScreen mainScreen] bounds];
//            imageFixedRect.size.width = imageFixedRect.size.width * 1.1;
//            imageFixedRect.size.height = imageFixedRect.size.height * 1.1;
//            [self.imageView setFrame:imageFixedRect];
            self.imageView.frame = CGRectMake(-self.imageView.bounds.size.width * 1.5/2, -self.imageView.bounds.size.height * 1.5/2, self.imageView.bounds.size.width * 2, self.imageView.bounds.size.height* 2);
        }];

    }
    [self showForSeconds:showSeconds fadeForSeconds:fadeSeconds];
}

- (void)fadeOut
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:fadeSeconds];
    [self setAlpha:0.0];
    [UIView commitAnimations];
}

@end
