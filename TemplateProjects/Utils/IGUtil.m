//
//  IGUtil.m
//  IGUtilARC
//
//  Created by Pedro Valentini on 11/02/11.
//  Copyright 2011 Infoglobo. All rights reserved.
//

#import "IGUtil.h"


@implementation IGUtil

static IGUtil *utilCompartilhado = nil;


- (id)init {
    self = [super init];
	if (self) {
		
	}
	return self;
}


- (void)setOrientacao:(NSInteger)_orientacao {
//	IGDEBUG(@"setOrientacao: %d", _orientacao);
	if (_orientacao==orientacao) return;
	orientacao = _orientacao;
	[[NSNotificationCenter defaultCenter] postNotificationName:@"observadorDeOrientacao" object:nil];
}


- (NSInteger)orientacao {
	return orientacao;
}


+ (IGUtil*)utilCompartilhado {
	if (!utilCompartilhado) {
		utilCompartilhado = [[IGUtil alloc] init];
	}
	return utilCompartilhado;
}


+ (NSInteger)viewAutoresizingMaskAll {
    return (UIViewAutoresizingFlexibleWidth|
            UIViewAutoresizingFlexibleHeight|
            UIViewAutoresizingFlexibleLeftMargin|
            UIViewAutoresizingFlexibleRightMargin|
            UIViewAutoresizingFlexibleTopMargin|
            UIViewAutoresizingFlexibleBottomMargin);
}


+ (NSInteger)viewAutoresizingMaskSize {
    return (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
}


+ (NSInteger)viewAutoresizingMaskMargin {
    return (UIViewAutoresizingFlexibleLeftMargin|
            UIViewAutoresizingFlexibleRightMargin|
            UIViewAutoresizingFlexibleTopMargin|
            UIViewAutoresizingFlexibleBottomMargin);
}


+ (NSURL*)rootURLPath {
    return [[NSBundle mainBundle] bundleURL];
}


+ (NSString*)documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


+ (void) showAlertView:(NSString*) message withLabelButtom :(NSString*) labelBt withWindowTitle:(NSString*) title{
    if(title == nil || [[NSString trimLines:title] isEqualToString:@""]){
        title = nil;
    }
    if(labelBt == nil || [[NSString trimLines:labelBt] isEqualToString:@""]){
       labelBt = @"ok";
    }
    
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:labelBt otherButtonTitles:nil];
	[alert show];
}


+ (NSInteger)orientation {
    return [[UIApplication sharedApplication] statusBarOrientation];
}


+ (BOOL)isPortrait {
    return ([IGUtil orientation] == UIInterfaceOrientationPortrait ||
            [IGUtil orientation] == UIInterfaceOrientationPortraitUpsideDown);
}


+ (BOOL)isLandscape {
    return ([IGUtil orientation] == UIInterfaceOrientationLandscapeLeft ||
            [IGUtil orientation] == UIInterfaceOrientationLandscapeRight);    
}


+ (int)randomWithMin:(int)min max:(int)max {
    if (max < 1) return 0;
    return (arc4random() % max) + min;
}


+ (int)random:(int)max {
    return [IGUtil randomWithMin:0 max:max];
}


+ (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}


+ (BOOL)isDeviceModelGoodCamera {
    NSError *error = nil;
    NSString *deviceModelIdentifier = [self deviceModel];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(iPod|iPad|iPhone)([0-9]+),([0-9]+)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSString *deviceName = [regex stringByReplacingMatchesInString:deviceModelIdentifier
                                                            options:0
                                                            range:NSMakeRange(0, [deviceModelIdentifier length])
                                                            withTemplate:@"$1"];
    
    NSString *deviceVersion = [regex stringByReplacingMatchesInString:deviceModelIdentifier
                                                                options:0
                                                                range:NSMakeRange(0, [deviceModelIdentifier length])
                                                                withTemplate:@"$2"];

    //iPhone2,1 - ok
    //iPod4,1 - ok
    //iPad2,1 - ok
    
    return ((([@"iPhone" isEqualToString:deviceName] || [@"iPad" isEqualToString:deviceName]) && [deviceVersion intValue] > 1) || 
            ([@"iPod" isEqualToString:deviceName] && [deviceVersion intValue] > 3));
}


+ (BOOL)integerToBool:(NSInteger)_integerToParse {
    NSLog(@"parametro: %i", _integerToParse);
    NSLog(@"retorno: %i", (_integerToParse == 1));
    BOOL retorno = (_integerToParse == 0);
    return retorno;
}


+ (BOOL)isJsonKitDictionaryWithObject:(id)_object {
    NSDictionary *dic = [@"{\"example\":{}}" objectFromJSONString];
    return ([_object isKindOfClass:[[dic objectForKey:@"example"] class]]);
}


+ (BOOL)isDeviceRetinaDisplay {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([[UIScreen mainScreen] scale] == 2.0)) ? YES : NO;
}


+ (BOOL)isDeviceWidescreen {
    return (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double) 568) < DBL_EPSILON);
}



@end