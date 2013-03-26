//
//  NSString+IGString.h
//  VaiRio
//
//  Created by Paulo Guilherme on 05/10/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IGString)

- (BOOL) isEmpty;
- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions) options;
- (NSString *) removePonctuationFromString;

+ (NSString *)trim:(NSString *)_string;
+ (NSString *)trimLines:(NSString *)_string;

+ (NSString *)stripHTML:(NSString *)_string;
+ (NSString *)buildWeekDaysString:(NSString *)_string;
+ (NSString *)buildTimeString:(NSString *)_string;

@end
