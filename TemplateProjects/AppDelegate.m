//
//  AppDelegate.m
//  TemplateProjects
//
//  Created by Henrique Ho Wong on 26/03/13.
//  Copyright (c) 2013 Henrique Ho Wong. All rights reserved.
//

#import "AppDelegate.h"
#import "IGUtil.h"
#import "IGSplashView.h"
#import "ViewController.h"

@implementation AppDelegate

dispatch_queue_t queueSplash;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:window];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"RootView"];

    [self setViewController:homeViewController];
    
    // EXIBE SPLASH SE ARQUIVO EXISTIR
    NSString *path1 = [[IGUtil documentPath] stringByAppendingString:K_SPLASH_IMAGE_NAME1];
    NSString *path2 = [[IGUtil documentPath] stringByAppendingString:K_SPLASH_IMAGE_NAME2];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path2]) {
        IGSplashView *splash2 = [[IGSplashView alloc] initSecondSplash];
        [splash2 setImagePath:path2];
        [splash2 setTag:999];
        [[[self viewController] view] insertSubview:splash2 atIndex:99];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:path1]) {
        IGSplashView *splash1 = [[IGSplashView alloc] init];
        [splash1 setImagePath:path1];
        [splash1 setTag:555];
        [[[self viewController] view] insertSubview:splash1 atIndex:100];
    }
    

    
    [[self window] setRootViewController:homeViewController];
    [[self window] makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if(K_SPLASH_SHOWING_WHEN_BECOME_ACTIVE){
        NSString *path = [[IGUtil documentPath] stringByAppendingString:K_SPLASH_IMAGE_NAME1];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            IGSplashView *splash = [[IGSplashView alloc] init];
            [splash setImagePath:path];
            [splash setTag:555];
            [[[self viewController] view] insertSubview:splash atIndex:100];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    IGSplashView *splash1 = (IGSplashView*)[[self.viewController view] viewWithTag:555];
    if (splash1) [splash1 show];
    IGSplashView *splash2 = (IGSplashView*)[[self.viewController view] viewWithTag:999];
    if (splash2) [splash2 show];
    
    NSString *urlString;
    
    // Faz a verificação da tela e do aparelho, para entregar o Splash de acordo.
    if ([IGUtil isDeviceRetinaDisplay]) {
        if ([IGUtil isDeviceWidescreen]) {
            urlString = K_SPLASH_URL_WIDESCREEN;
        } else {
            urlString = K_SPLASH_URL_RETINA;
        }
    } else {
        urlString = K_SPLASH_URL_DEFAULT;
    }
    
    NSString *url1 = [NSString stringWithFormat:urlString, (int)[[NSDate date] timeIntervalSince1970]];
    NSString *url2 = [NSString stringWithFormat:K_SPLASH_URL_PATROCINIO, (int)[[NSDate date] timeIntervalSince1970]];
    queueSplash = dispatch_queue_create("AppDelegateQueue",nil);
    
    dispatch_async(queueSplash, ^{
        [self downloadSplashLinkAndImage:url1 file:K_SPLASH_IMAGE_NAME1];
        [self downloadSplashLinkAndImage:url2 file:K_SPLASH_IMAGE_NAME2];
    });

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma ###################################################################################################################
#pragma mark - Custom Methods

- (void)downloadSplashLinkAndImage:(NSString *)_urlString file:(NSString *)fileName{
    NSURL *url = [NSURL URLWithString:[_urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:K_SPLASH_TIME_OUT];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSString *path = [[IGUtil documentPath] stringByAppendingString:fileName];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([stringData rangeOfString:@"empty.gif"].location != NSNotFound) { // ACHOU EMPTY, PARA E APAGA ARQUIVO
                IGDEBUG(@"Splash patrocinado: %@", @"desligado");
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            } else { // ACHOU URL, BAIXA IMAGEM
                IGDEBUG(@"Splash Url: %@", stringData);
                NSURL *urlImage = [NSURL URLWithString:[stringData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *urlRequestImage = [NSURLRequest requestWithURL:urlImage cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:K_SPLASH_TIME_OUT];
                [NSURLConnection sendAsynchronousRequest:urlRequestImage queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if ([data length] > 0 && error == nil) {
                        UIImage *image = [UIImage imageWithData:data];
                        if (image) {
                            [data writeToFile:path atomically:YES]; // SALVA
                            IGDEBUG(@"Splash Salvo: %@", path);
                        } else {
                            [[NSFileManager defaultManager] removeItemAtPath:path error:nil]; // APAGA
                        }
                    } else if (error != nil && error.code == NSURLErrorTimedOut) {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:nil]; // APAGA
                    } else if ([data length] == 0 && error == nil) {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:nil]; // APAGA
                    } else if (error != nil) {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:nil]; // APAGA
                    }
                }];
            }
        }
    }];
}

@end
