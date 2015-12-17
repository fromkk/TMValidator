//
//  TMValidatorRuleNumericMax.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleNumericMax.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleIsNumeric.h"

@implementation TMValidatorRuleNumericMax

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeNumericMax;
    }
    
    return self;
}

+ (instancetype)ruleWithNumeric:(NSNumber *)numeric
{
    return [self ruleWithNumeric:numeric andErrorMessage:nil];
}

+ (instancetype)ruleWithNumeric:(NSNumber *)numeric andErrorMessage:(NSString *)errorMessage
{
    TMValidatorRuleNumericMax *instance = [self rule];
    instance.numeric = numeric;
    instance.errorMessage = errorMessage;
    return  instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withNumeric:self.numeric];
}

+ (BOOL)run:(NSString *)string withNumeric:(NSNumber *)numeric
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == numeric)
    {
        NSLog(@"numeric is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    if ( NO == [TMValidatorRuleIsNumeric run:string] )
    {
        NSLog(@"string(%@) is not numeric. %s %d", string, __FUNCTION__, __LINE__);
        return NO;
    }
    
    NSNumber *value = [NSNumber numberWithFloat:string.floatValue];
    NSComparisonResult result = [value compare:numeric];
    return result == NSOrderedSame || result == NSOrderedAscending;
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != self.errorMessage && 0 < self.errorMessage.length)
    {
        return self.errorMessage;
    }
    
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.numericMin", @"TMValidatorError", @"numericMin");
    return [NSString stringWithFormat:format, label, self.numeric];
}

- (void)dealloc
{
    _numeric = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: numeric=%@>", NSStringFromClass(self.class), self.numeric];
}

@end
