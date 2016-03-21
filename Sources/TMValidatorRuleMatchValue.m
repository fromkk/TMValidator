//
//  TMValidatorRuleMatchValue.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleMatchValue.h"
#import "TMValidatorRuleIsEmpty.h"

@implementation TMValidatorRuleMatchValue

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeMatchValue;
    }
    
    return self;
}

+ (instancetype)ruleWithValue:(NSString *)value
{
    return [self ruleWithValue:value andErrorMessage:nil];
}

+ (instancetype)ruleWithValue:(NSString *)value andErrorMessage:(NSString *)errorMessage
{
    TMValidatorRuleMatchValue *instance = [self rule];
    instance.value = value;
    instance.errorMessage = errorMessage;
    return instance;
}

- (BOOL)run:(NSString *)string
{
    return [[self class] run:string withValue:self.value];
}

+ (BOOL)run:(NSString *)string withValue:(NSString *)value
{
    if ([TMValidatorRuleIsEmpty run:string])
    {
        return YES;
    }
    
    return [string isEqualToString:value];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != self.errorMessage && 0 < self.errorMessage.length)
    {
        return self.errorMessage;
    }
    
    NSString *format = NSLocalizedStringFromTable(@"tm.validator.matchValue", @"TMValidatorError", @"matchValue");
    return [NSString stringWithFormat:format, label, self.value];
}

- (void)dealloc
{
    _value = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: value=%@>", NSStringFromClass(self.class), self.value];
}

@end
