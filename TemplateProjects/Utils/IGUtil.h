//
//  IGUtil.h
//  IGUtilARC
//
//  Created by Pedro Valentini on 11/02/11.
//  Copyright 2011 Infoglobo. All rights reserved.
//
//
//  Classe utilitaria.
//  
//  Deve conter metodos simples e genericos aos projetos, tem como base um singleton.
//


#import <Foundation/Foundation.h>
#import "NSString+IGString.h"
#import <sys/utsname.h>
#import "JSONKit.h"


// iPad Detection
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


@interface IGUtil : NSObject {
	NSInteger orientacao;
}

- (void)setOrientacao:(NSInteger)_orientacao;
- (NSInteger)orientacao;

+ (IGUtil*)utilCompartilhado;
+ (void) showAlertView:(NSString*) message withLabelButtom :(NSString*) labelBt withWindowTitle:(NSString*) title;
+ (int)randomWithMin:(int)min max:(int)max;
+ (int)random:(int)max;
+ (NSInteger)viewAutoresizingMaskAll;
+ (NSInteger)viewAutoresizingMaskMargin;
+ (NSInteger)viewAutoresizingMaskSize;
+ (NSInteger)orientation;
+ (NSURL*)rootURLPath;
+ (NSString*)documentPath;
+ (NSString *)deviceModel;
+ (BOOL)isPortrait;
+ (BOOL)isLandscape;
+ (BOOL)integerToBool:(NSInteger)_integerToParse;
+ (BOOL)isDeviceModelGoodCamera;
+ (BOOL)isJsonKitDictionaryWithObject:(id)_object;
+ (BOOL)isDeviceRetinaDisplay;
+ (BOOL)isDeviceWidescreen;



@end