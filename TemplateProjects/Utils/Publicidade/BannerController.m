//
//  BannerController.m
//  MoveRio
//
//  Created by Eduardo Rangel on 12/19/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import "BannerController.h"
#import "BannerModel+Parse.h"

@implementation BannerController

+ (BOOL)didLoadBannerFooter:(UIWebView *)bannerFooter forEditorial:(NSString *)editorial {
    
    BOOL statusInternet = INTERNET_STATUS;
    if(!statusInternet)return NO;
    
    NSURL *url = [BannerModel formatToFooterUrlWithSitePage:editorial];
    
    url =[NSURL URLWithString:@"http://nosna.net/ipad/image.html"];
    
    if (!url)
        return NO;
    
    BannerModel *banner = [BannerModel parseWithURL:url];
    
    if ([banner isEmpty])
        return NO;
    
    [bannerFooter loadHTMLString:[banner html] baseURL:nil];
    
    return YES;
}



@end