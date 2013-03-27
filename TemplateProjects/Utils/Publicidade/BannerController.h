//
//  BannerController.h
//  MoveRio
//
//  Created by Eduardo Rangel on 12/19/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerController : NSObject

+ (BOOL)didLoadBannerFooter:(UIWebView *)bannerFooter forEditorial:(NSString *)editorial;

@end