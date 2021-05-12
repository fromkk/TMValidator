//
//  TMValidatorRuleMatchPattern.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleMatchPattern : TMValidatorRule

@property (nonatomic) NSString * _Nonnull pattern;

+ (instancetype _Nonnull)ruleWithErrorMessage:(NSString * _Nullable)errorMessage UNAVAILABLE_ATTRIBUTE;
+ (instancetype _Nonnull)ruleWithPattern:(NSString * _Nonnull)pattern;
+ (instancetype _Nonnull)ruleWithPattern:(NSString * _Nonnull)pattern andErrorMessage:(NSString * _Nullable)errorMessage;
+ (BOOL)run:(NSString * _Nullable)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString * _Nullable)string withPattern:(NSString * _Nonnull)pattern;
+ (BOOL)run:(NSString * _Nullable)string withPattern:(NSString * _Nonnull)pattern matches:(void (^ _Nullable)(NSArray * _Nonnull matches))matches;

@end
