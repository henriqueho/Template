//
//  ApplicationSingleton.m
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 27/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import "ApplicationSingleton.h"
#import "IGUtil.h"

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

@end
