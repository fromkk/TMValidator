//
//  TMValidatorRuleEmail.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/17.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRuleEmail.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleMatchPattern.h"

@implementation TMValidatorRuleEmail

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _errorCode = TMValidatorErrorCodeEmail;
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
    
    // Regular Expression from http://qiita.com/mpyw/items/257eabe0b43b1e02e6f7#comment-5a229e2f39676b107552
    return [TMValidatorRuleMatchPattern run:string withPattern:@"^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$"];
}

- (NSString *)errorMessageWithLabel:(NSString *)label
{
    if (nil != self.errorMessage && 0 < self.errorMessage.length)
    {
        return self.errorMessage;
    }

    NSString *format = NSLocalizedStringFromTable(@"tm.validator.email", @"TMValidatorError", @"email");
    return [NSString stringWithFormat:format, label];
}

@end
