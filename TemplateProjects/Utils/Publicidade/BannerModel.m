//
//  BannerSeloModel.m
//  MoveRio
//
//  Created by Alexandre Santos on 19/12/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ (NSURL *)formatToSeloUrlWithSitePage:(NSString *)sitePage {
    return [BannerModel formatToUrlWithSitePage:sitePage code:K_BANNER_SELO_CODE];
}


+ (NSURL *)formatToFooterUrlWithSitePage:(NSString *)sitePage {
    return [BannerModel formatToUrlWithSitePage:sitePage code:K_BANNER_FOOTER_CODE];
}


+ (NSURL *)formatToUrlWithSitePage:(NSString *)sitePage code:(NSString *)code {
    NSString *url;
    
    url = [IGUtil isDeviceRetinaDisplay] ? K_BANNER_URL_RETINA : K_BANNER_URL_DEFAULT;
    
    int milisencondTime = (int)[[NSDate date] timeIntervalSince1970];
    
    NSString *urlString = [NSString stringWithFormat:url, sitePage, milisencondTime, code];

    NSLog(@"Publicidade URL: %@", urlString);

    return [NSURL URLWithString:urlString];
}


- (UIImage *)parseSeloImage {
    UIImage *seloImage = [[UIImage alloc] init];
    
    @try {
        NSString *imgCacheKey = [self.srcImage MD5Hash];
        
        if ([[EGOCache globalCache] hasCacheForKey:imgCacheKey]) {
            seloImage = [[EGOCache globalCache] imageForKey:imgCacheKey];
        } else {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.srcImage]];
            seloImage = [[UIImage alloc] initWithData:imageData];
            
            [[EGOCache globalCache] setImage:seloImage forKey:imgCacheKey];
        }
    } @catch (NSException *exception) {
        IGDEBUG(@"Problema ao carregar uma imagem do banner do cache local: %@", [exception description]);
    } @finally {
        return seloImage;
    }
}


- (BOOL)isEmpty {
    static NSString *emptyString = @"empty.gif";
    if(self.srcImage==nil) return NO;
    
    NSRange range = [self.srcImage rangeOfString:emptyString];
   
    return (range.location != NSNotFound);
}


- (BOOL)isLinkClickable {
    return (![self isEmpty] && self.href && [self.href length] > 0);
}



@end