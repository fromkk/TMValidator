//
//  TMValidatorRuleNumericBetween.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleNumericBetween : TMValidatorRule

@property (nonatomic) NSNumber * _Nonnull numericMin;
@property (nonatomic) NSNumber * _Nonnull numericMax;

+ (instancetype _Nonnull)ruleWithErrorMessage:(NSString * _Nullable)errorMessage UNAVAILABLE_ATTRIBUTE;
+ (instancetype _Nonnull)ruleWithNumericMin:(NSNumber * _Nonnull)numericMin andNumericMax:(NSNumber * _Nonnull)numericMax;
+ (instancetype _Nonnull)ruleWithNumericMin:(NSNumber * _Nonnull)numericMin andNumericMax:(NSNumber * _Nonnull)numericMax andErrorMessagae:(NSString * _Nullable)errorMessage;
+ (BOOL)run:(NSString * _Nullable)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString * _Nullable)string withNumericMin:(NSNumber * _Nonnull)numericMin andNumericMax:(NSNumber * _Nonnull)numericMax;

@end
