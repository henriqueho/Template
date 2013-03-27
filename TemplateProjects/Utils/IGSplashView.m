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
        self.timer = nil;
        self.fadeTimer = nil;
        
        fadeSeconds = 0.6;
        showSeconds = K_SPLASH_TIME_IN_SECONDS+fadeSeconds;
        
        
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
        self.timer = nil;
        self.fadeTimer = nil;
        
        fadeSeconds = 0.6;
        showSeconds = (2*K_SPLASH_TIME_IN_SECONDS)+fadeSeconds;
        
        
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
        [self.imageView setFrame:[[UIScreen mainScreen] bounds]];
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
