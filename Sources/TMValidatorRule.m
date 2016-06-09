//
//  TMValidatorRule.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@implementation TMValidatorRule

@synthesize errorCode = _errorCode;
@synthesize errorMessage = _errorMessage;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = 0;
    }
    
    return self;
}

+ (instancetype)rule
{
    return [self ruleWithErrorMessage:nil];
}

+ (instancetype)ruleWithErrorMessage:(NSString *)errorMessage
{
    TMValidatorRule *instance = [[self alloc] init];
    instance.errorMessage = errorMessage;
    return instance;
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != _errorMessage && 0 != _errorMessage.length)
    {
        return _errorMessage;
    } else
    {
        return @"";
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>", NSStringFromClass(self.class)];
}

@end
