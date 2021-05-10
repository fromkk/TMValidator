//
//  TMValidatorRuleNumericMax.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleNumericMax : TMValidatorRule

@property (nonatomic) NSNumber * _Nonnull numeric;

+ (instancetype _Nonnull)ruleWithErrorMessage:(NSString * _Nullable)errorMessage UNAVAILABLE_ATTRIBUTE;
+ (instancetype _Nonnull)ruleWithNumeric:(NSNumber * _Nonnull)numeric;
+ (instancetype _Nonnull)ruleWithNumeric:(NSNumber * _Nonnull)numeric andErrorMessage:(NSString * _Nullable)errorMessage;
+ (BOOL)run:(NSString * _Nullable)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString * _Nullable)string withNumeric:(NSNumber * _Nonnull)numeric;

@end
