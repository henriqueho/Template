//
//  ViewController.m
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 26/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([ApplicationSingleton getAppSingleton].deviceType == iPhone) {
        IGDEBUG(@">>>>>>>>>- %@",@"iphone");
    } else if ([ApplicationSingleton getAppSingleton].deviceType == iPhoneRetnia) {
        IGDEBUG(@">>>>>>>>>- %@",@"iphoneretina");
    } else if ([ApplicationSingleton getAppSingleton].deviceType == iPhone5) {
        IGDEBUG(@">>>>>>>>>- %@",@"iphone5");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
