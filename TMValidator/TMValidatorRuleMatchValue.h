//
//  TMValidatorRuleMatchValue.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleMatchValue : TMValidatorRule

@property (nonatomic) NSString * _Nonnull value;

+ (instancetype _Nonnull)ruleWithErrorMessage:(NSString * _Nullable)errorMessage UNAVAILABLE_ATTRIBUTE;
+ (instancetype _Nonnull)ruleWithValue:(NSString * _Nonnull)value;
+ (instancetype _Nonnull)ruleWithValue:(NSString * _Nonnull)value andErrorMessage:(NSString * _Nullable)errorMessage;
+ (BOOL)run:(NSString * _Nullable)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString * _Nullable)string withValue:(NSString * _Nullable)value;

@end
