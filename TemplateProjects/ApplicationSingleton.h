//
//  ApplicationSingleton.h
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 27/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationSingleton : NSObject

typedef enum
{
    iPhone          = 1 << 1,
    iPhoneRetnia    = 1 << 2,
    iPhone5         = 1 << 3,
    
} DeviceType;

@property(nonatomic) DeviceType deviceType;

+ (ApplicationSingleton*) getAppSingleton;
- (BOOL)isInternetAvailable;

@end
