//
//  TMValidatorRuleMatchPattern.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleMatchPattern.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleMatchPattern

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeMatchPattern;
    }
    
    return self;
}

+ (instancetype)ruleWithPattern:(NSString *)pattern
{
    return [self ruleWithPattern:pattern andErrorMessage:nil];
}

+ (instancetype)ruleWithPattern:(NSString *)pattern andErrorMessage:(NSString *)errorMessage
{
    TMValidatorRuleMatchPattern *instance = [self rule];
    instance.pattern = pattern;
    instance.errorMessage = errorMessage;
    return instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withPattern:self.pattern matches:nil];
}

+ (BOOL)run:(NSString *)string withPattern:(NSString *)pattern matches:(void (^)(NSArray *))matches
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == pattern)
    {
        NSLog(@"pattern is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                                                             error:&error];
    if (error)
    {
        NSLog(@"%@ %s %d", error, __FUNCTION__, __LINE__);
        return NO;
    }
    
    BOOL valid = 0 < [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    if (nil != matches)
    {
        NSMutableArray *result = [NSMutableArray array];
        NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
        if (match)
        {
            NSRange range;
            NSString *matchedString;
            for (int i = 0; i < match.numberOfRanges; i++)
            {
                range = [match rangeAtIndex:i];
                matchedString = [string substringWithRange:range];
                [result addObject:matchedString];
            }
        }
        
        matches(result);
    }
    
    return valid;
}

+ (BOOL)run:(NSString *)string withPattern:(NSString *)pattern
{
    return [self run:string withPattern:pattern matches:nil];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != self.errorMessage && 0 < self.errorMessage.length)
    {
        return self.errorMessage;
    }
    
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.matchPattern", @"TMValidatorError", @"matchPattern");
    return [NSString stringWithFormat:format, label, self.pattern];
}

- (void)dealloc
{
    _pattern = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: pattern=%@>", NSStringFromClass(self.class), self.pattern];
}

@end
