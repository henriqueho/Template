//
//  IGDownloader.m
//  IGUtilARC
//
//  Created by Eduardo Rangel on 18/09/12.
//  Copyright 2012 Infoglobo. All rights reserved.
//


// Para sobrescrever os padrões, defina no global dos projetos as variaveis abaixo:
//    [[IGDownloader sharedDownloader] setRequestCachePolicy:NSURLRequestReturnCacheDataElseLoad];
//    [[IGDownloader sharedDownloader] setRequestTimeout:10.0];
// 
// Referência sobre politicas de cache:
//    https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSURLRequest_Class/Reference/Reference.html



#import <Foundation/Foundation.h>

@protocol IGDownloaderDelegate <NSObject>

@required
- (void)downloadDidFinishWithData:(NSData *)_receivedData;
- (void)downloadDidFinishWithError:(NSError *)_error;
@end



@interface IGDownloader : NSObject <NSURLConnectionDelegate> {
    NSURLConnection *urlConnection;
    NSMutableData *receivedData;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic) BOOL isDownloaded;
@property (nonatomic) NSURLRequestCachePolicy requestCachePolicy;
@property (nonatomic) float requestTimeout;

+ (IGDownloader *)sharedDownloader;
+ (NSInteger)statusCode:(NSURLRequest *)_request;

- (id)initWithDelegate:(id)_delegate;
- (NSURL *)urlFromUrlString:(NSString *)_urlString;
- (void)downloadFromURLString:(NSString *)_urlString;

@end