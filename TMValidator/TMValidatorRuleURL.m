//
//  TMValidatorRuleURL.m
//  TMValidatorDemo
//
//  Created by Kazuya Ueoka on 2015/11/18.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleURL.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleMatchPattern.h"

@implementation TMValidatorRuleURL

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeURL;
    }
    
    return self;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string];
}

+ (BOOL)run:(NSString *)string
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    // Regular Expression from https://mathiasbynens.be/demo/url-regex @diegoperini
    return [TMValidatorRuleMatchPattern run:string withPattern:@"^(?:(?:https?|ftp)://)(?:\\S+(?::\\S*)?@)?(?:(?!10(?:\\.\\d{1,3}){3})(?!127(?:\\.\\d{1,3}){3})(?!169\\.254(?:\\.\\d{1,3}){2})(?!192\\.168(?:\\.\\d{1,3}){2})(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\x{00a1}-\\x{ffff}0-9]+-?)*[a-z\\x{00a1}-\\x{ffff}0-9]+)(?:\\.(?:[a-z\\x{00a1}-\\x{ffff}0-9]+-?)*[a-z\\x{00a1}-\\x{ffff}0-9]+)*(?:\\.(?:[a-z\\x{00a1}-\\x{ffff}]{2,})))(?::\\d{2,5})?(?:/[^\\s]*)?$"];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.url", @"TMValidatorError", @"url");
    return [NSString stringWithFormat:format, label];
}

@end
