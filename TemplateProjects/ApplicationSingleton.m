//
//  ApplicationSingleton.m
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 27/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import "ApplicationSingleton.h"
#import "IGUtil.h"
#import "Reachability.h"

@implementation ApplicationSingleton

+ (ApplicationSingleton*) getAppSingleton {
    static ApplicationSingleton* sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ApplicationSingleton alloc] init];
        // Do any other initialisation stuff here
        int type = 0;
        if ([IGUtil isDeviceRetinaDisplay]) {
            if ([IGUtil isDeviceWidescreen]) {
                IGDEBUG(@">>>>>>>>> %@",@"iphone5");
                type |= iPhone5;
            } else {
                IGDEBUG(@">>>>>>>>> %@",@"iphone Retina");
                type |= iPhoneRetnia;
            }
        } else {
            IGDEBUG(@">>>>>>>>> %@",@"iphone");
            type |= iPhone;
        }
        sharedInstance.deviceType = type;
    });
    
    return sharedInstance;
}

- (BOOL)isInternetAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        IGDEBUG(@"internet: %@", @"ON");
        return YES;
    } else {
        IGDEBUG(@"internet: %@", @"OFF");
        return NO;
    }
}

@end
