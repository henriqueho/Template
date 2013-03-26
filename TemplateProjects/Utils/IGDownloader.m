//
//  IGDownloader.m
//  IGUtilARC
//
//  Created by Eduardo Rangel on 18/09/12.
//  Copyright 2012 Infoglobo. All rights reserved.
//

#import "IGDownloader.h"

static IGDownloader *sharedDownloader = nil;


#pragma ###################################################################################################################
#pragma mark @implementation/@synthesize

@implementation IGDownloader

@synthesize delegate, 
            isDownloaded,
            requestTimeout,
            requestCachePolicy;



#pragma ###################################################################################################################
#pragma mark - View Lifecycle

- (id)initWithDelegate:(id)_delegate {
    self = [super init];
	if (self) {
        delegate = _delegate;
        isDownloaded = NO;
		urlConnection = nil;
        receivedData = nil;
	}
	return self;
}


- (void)dealloc {
    delegate = nil;
    if (urlConnection) {
        [urlConnection cancel];
        urlConnection = nil;
    }
    if (receivedData) {
        receivedData = nil;
    }
}



#pragma ###################################################################################################################
#pragma mark - Class Methods

+ (IGDownloader *)sharedDownloader {
    @synchronized(self) {
        if (sharedDownloader == nil) {
            sharedDownloader = [[self alloc] init];
            [sharedDownloader setRequestCachePolicy:NSURLRequestReturnCacheDataElseLoad];
            [sharedDownloader setRequestTimeout:4.0];
        }
    }
    return sharedDownloader;
}


+ (NSInteger)statusCode:(NSURLRequest *)_request {
    NSError *error;
    NSURLResponse *response;
    NSHTTPURLResponse *httpResponse;    
    [NSURLConnection sendSynchronousRequest:_request returningResponse:&response error:&error];    
    httpResponse = (NSHTTPURLResponse *)response;
    return [httpResponse statusCode];      
}



#pragma ###################################################################################################################
#pragma mark - Instance Methods

// Retorna a NSURL local ou web baseado na string
- (NSURL *)urlFromUrlString:(NSString *)_urlString {
    NSURL *url = [NSURL URLWithString:[_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([url scheme] || [url scheme]) {
        IGDEBUG(@"WebURL: %@", _urlString);
        return url;
    }
    IGDEBUG(@"LocalFile: %@", _urlString);
    NSString *path = [[NSBundle mainBundle] resourcePath];
    return [NSURL fileURLWithPath:[path stringByAppendingPathComponent:_urlString]];
}


- (void)downloadFromURLString:(NSString *)_urlString {
    if (urlConnection || isDownloaded) {
        return;
    }
    
    NSURL *url = [self urlFromUrlString:_urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:[[IGDownloader sharedDownloader] requestCachePolicy]
                                         timeoutInterval:[[IGDownloader sharedDownloader] requestTimeout]];
    
    urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (urlConnection) {
        receivedData = [NSMutableData data];
    }
}


#pragma ###################################################################################################################
#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    
    if (responseStatusCode >= 400) {
        IGWARN(@"NSURLResponse statusCode %d", responseStatusCode);
        [connection cancel];
        
        NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:NSLocalizedString(@"Servidor retornou codigo %d",@""), responseStatusCode]
                                                              forKey:NSLocalizedDescriptionKey];
        
        NSError *statusError = [NSError errorWithDomain:@"ConnectionError"
                                                   code:responseStatusCode
                                               userInfo:errorInfo];
        
        [self performSelector:@selector(connection:didFailWithError:) 
                   withObject:connection 
                   withObject:statusError];
        
        return;
    }
    
    [receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incrementalData {
    [receivedData appendData:incrementalData];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {    
    IGINFO(@"Download completed! %d bytes", [receivedData length]);
    
    if (delegate && [delegate respondsToSelector:@selector(downloadDidFinishWithData:)]) {
        NSData *data = [NSData dataWithData:receivedData];
        [delegate performSelector:@selector(downloadDidFinishWithData:) withObject:data];
    }
    
    connection = nil;
    isDownloaded = YES;
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    IGINFO(@"Download failed! %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    if (delegate && [delegate respondsToSelector:@selector(downloadDidFinishWithError:)]) {
        [delegate performSelector:@selector(downloadDidFinishWithError:) withObject:error];
    }
    
    connection = nil;
}



@end