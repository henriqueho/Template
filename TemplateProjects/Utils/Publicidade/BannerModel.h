//
//  BannerSeloModel.h
//  MoveRio
//
//  Created by Alexandre Santos on 19/12/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGOCache.h"
#import "NSString+MD5.h"
#import "IGUtil.h"

@interface BannerModel : NSObject

@property (nonatomic, copy) NSString *href;
@property (nonatomic, copy) NSString *srcImage;

@property (nonatomic, copy) NSString *html;

+ (NSURL *)formatToUrlWithSitePage:(NSString *)sitePage code:(NSString *)code;
+ (NSURL *)formatToSeloUrlWithSitePage:(NSString *)sitePage;
+ (NSURL *)formatToFooterUrlWithSitePage:(NSString *)sitePage;

- (UIImage *)parseSeloImage;

- (BOOL)isEmpty;
- (BOOL)isLinkClickable;

@end
