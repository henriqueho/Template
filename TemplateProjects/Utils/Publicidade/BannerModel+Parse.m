//
//  BannerSeloModel+Parse.m
//  MoveRio
//
//  Created by Alexandre Santos on 19/12/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import "BannerModel+Parse.h"

@implementation BannerModel (Parse)

+ (BannerModel *)parseWithURL:(NSURL *)url {
    BannerModel *bannerSelo = [[BannerModel alloc] init];
    
    @try {
        IGDEBUG(@"Carregando banner: %@", [url absoluteString]);
        
        NSData *seloHtmlData = [NSData dataWithContentsOfURL:url];
        bannerSelo.html = [[NSString alloc] initWithData:seloHtmlData encoding:NSUTF8StringEncoding];
        
//        TFHpple *seloParser = [TFHpple hppleWithHTMLData:seloHtmlData];
//        NSString *seloXpathQueryStringForHref = @"//a";
//        NSString *seloXpathQueryStringForImg = @"//img";
//        NSArray *seloNodesHref = [seloParser searchWithXPathQuery:seloXpathQueryStringForHref];
//        NSArray *seloNodesImg = [seloParser searchWithXPathQuery:seloXpathQueryStringForImg];
        
//        if (seloNodesHref && [seloNodesHref count] > 0) {
//            bannerSelo.href = [[seloNodesHref objectAtIndex:0] objectForKey:@"href"];
//        }
//        
//        if (seloNodesImg && [seloNodesImg count] > 0) {
//            bannerSelo.srcImage = [[seloNodesImg objectAtIndex:0] objectForKey:@"src"];
//        }
    }
    @catch (NSException *exception) {
        IGDEBUG(@"Problema ao carregar o banner ou selo da url: %@", exception);
    }
    @finally {
        return bannerSelo;
    }
}

@end
