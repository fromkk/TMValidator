//
//  TMValidatorRule.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMValidatorCommon.h"

@protocol TMValidatorRuleProtocol <NSObject>

- (NSString * _Nonnull)errorMessageWithLabel:(NSString * _Nullable)label;

@optional
- (BOOL)run:(NSString * _Nullable)string;
+ (BOOL)run:(NSString * _Nullable)string;

@end

@interface TMValidatorRule : NSObject <TMValidatorRuleProtocol>
{
    TMValidatorErrorCode _errorCode;
    NSString *_errorMessage;
}

+ (instancetype _Nonnull)rule;
+ (instancetype _Nonnull)ruleWithErrorMessage:(NSString * _Nullable)errorMessage;

@property (nonatomic, readonly) TMValidatorErrorCode errorCode;
@property (nonatomic) NSString * _Nullable errorMessage;

@end
