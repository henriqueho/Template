//
//  NSString+IGString.m
//  VaiRio
//
//  Created by Paulo Guilherme on 05/10/12.
//  Copyright (c) 2012 Infoglobo. All rights reserved.
//

#import "NSString+IGString.h"

@implementation NSString (IGString)


- (BOOL) isEmpty
{
  return ([self isEqualToString:@""] || self == nil);
}

+ (NSString *)trim:(NSString *)_string {
    return [_string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+ (NSString *)trimLines:(NSString *)_string {
    return [_string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (NSString *)stripHTML:(NSString *)_string {
    NSRange r;
    NSString *s = [_string copy];
    
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    
    return s;
}


+ (NSString *)buildWeekDaysString:(NSString *)_string {
    NSString *stringWeekDays = @"";
    if (!_string) {
        return nil;
    }
    
    if ([_string characterAtIndex:1] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"seg"];
    }
    if ([_string characterAtIndex:2] == '1' && [stringWeekDays isEqualToString:@""]) {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"ter"];
    } else if ([_string characterAtIndex:2] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@", ter"];
    }
    
    if ([_string characterAtIndex:3] == '1' && [stringWeekDays isEqualToString:@""]) {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"qua"];
    } else if ([_string characterAtIndex:3] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@", qua"];
    }
    
    if ([_string characterAtIndex:4] == '1' && [stringWeekDays isEqualToString:@""]) {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"qui"];
    } else if ([_string characterAtIndex:4] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@", qui"];
    }
    
    if ([_string characterAtIndex:5] == '1' && [stringWeekDays isEqualToString:@""]) {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"sex"];
    } else if ([_string characterAtIndex:5] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@", sex"];
    }
    
    if ([_string characterAtIndex:6] == '1' && [stringWeekDays isEqualToString:@""]) {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"sab"];
    } else if ([_string characterAtIndex:6] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@", sab"];
    }
    
    if ([_string characterAtIndex:7] == '1' && [stringWeekDays isEqualToString:@""]) {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@"dom"];
    } else if ([_string characterAtIndex:7] == '1') {
        stringWeekDays = [stringWeekDays stringByAppendingFormat:@", dom"];
    }
    
    return stringWeekDays;
}

-(NSString*) removePonctuationFromString {
    //remove any accents and punctuation;
    NSString *a = self;
    a=[[NSString alloc] initWithData:[a dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding];
    
    a=[a stringByReplacingOccurrencesOfString:@" " withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"'" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"`" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"-" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"_" withString:@""];
    a=[a stringByReplacingOccurrencesOfString:@"ç" withString:@"c"];
    a=[a lowercaseString];
    return a;
}

- (BOOL)containsString:(NSString *)_string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:_string options:options];
    return rng.location != NSNotFound;
}


- (BOOL)containsString:(NSString *)_string {
    return [self containsString:_string options:0];
}


+ (NSString *)buildTimeString:(NSString *)_string {
    for (int i = _string.length; i > 2; i--) {
        _string = [_string substringToIndex:[_string length] - 1];
    }
    return _string;
}


@end
