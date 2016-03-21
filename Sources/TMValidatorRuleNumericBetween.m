//
//  TMValidatorRuleNumericBetween.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleNumericBetween.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleIsNumeric.h"

@implementation TMValidatorRuleNumericBetween

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeNumericBetween;
    }
    
    return self;
}

+ (instancetype)ruleWithNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax
{
    return [self ruleWithNumericMin:numericMin andNumericMax:numericMax andErrorMessagae:nil];
}

+ (instancetype)ruleWithNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax andErrorMessagae:(NSString *)errorMessage
{
    TMValidatorRuleNumericBetween *instance = [self rule];
    instance.numericMin = numericMin;
    instance.numericMax = numericMax;
    instance.errorMessage = errorMessage;
    return  instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withNumericMin:self.numericMin andNumericMax:self.numericMax];
}

+ (BOOL)run:(NSString *)string withNumericMin:(NSNumber *)numericMin andNumericMax:(NSNumber *)numericMax
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == numericMin || nil == numericMax)
    {
        NSLog(@"numericMin ow numericMax is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    if ( NO == [TMValidatorRuleIsNumeric run:string] )
    {
        NSLog(@"string(%@) is not numeric. %s %d", string, __FUNCTION__, __LINE__);
        return NO;
    }
    
    NSNumber *value = [NSNumber numberWithFloat:string.floatValue];
    NSComparisonResult resultMin = [value compare:numericMin];
    NSComparisonResult resultMax = [value compare:numericMax];
    
    return (resultMin == NSOrderedSame || resultMin == NSOrderedDescending) && (resultMax == NSOrderedSame || resultMax == NSOrderedAscending);
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != self.errorMessage && 0 < self.errorMessage.length)
    {
        return self.errorMessage;
    }
    
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.numericBetween", @"TMValidatorError", @"numericBetween");
    return [NSString stringWithFormat:format, label, self.numericMin, self.numericMax];
}

- (void)dealloc
{
    _numericMin = nil;
    _numericMax = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: numericMin=%@ numericMax=%@>", NSStringFromClass(self.class), self.numericMin, self.numericMax];
}

@end
