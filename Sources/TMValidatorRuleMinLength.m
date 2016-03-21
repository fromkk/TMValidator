//
//  TMValidatorRuleMinLength.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleMinLength.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleMinLength

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeMinLength;
    }
    
    return self;
}

+ (instancetype)ruleWithLength:(NSNumber *)length
{
    return [self ruleWithLength:length andErrorMessage:nil];
}

+ (instancetype)ruleWithLength:(NSNumber *)length andErrorMessage:(NSString *)errorMessage
{
    TMValidatorRuleMinLength *instance = [self rule];
    instance.length = length;
    instance.errorMessage = errorMessage;
    return instance;
}

+ (BOOL)run:(NSString *)string withLength:(NSNumber *)length
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    if (nil == length)
    {
        NSLog(@"length is nil %s %d", __FUNCTION__, __LINE__);
        return NO;
    }
    
    return string.length >= length.integerValue;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withLength:self.length];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != self.errorMessage && 0 < self.errorMessage.length)
    {
        return self.errorMessage;
    }
    
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.minLength", @"TMValidatorError", @"minLength");
    return [NSString stringWithFormat:format, label, self.length];
}

- (void)dealloc
{
    _length = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: length=%@>", NSStringFromClass(self.class), self.length];
}

@end
