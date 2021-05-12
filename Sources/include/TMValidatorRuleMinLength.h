//
//  TMValidatorRuleMinLength.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidatorRule.h"

@interface TMValidatorRuleMinLength : TMValidatorRule

@property (nonatomic) NSNumber * _Nonnull length;

+ (instancetype _Nonnull)ruleWithErrorMessage:(NSString * _Nullable)errorMessage UNAVAILABLE_ATTRIBUTE;
+ (instancetype _Nonnull)ruleWithLength:(NSNumber * _Nonnull)length;
+ (instancetype _Nonnull)ruleWithLength:(NSNumber * _Nonnull)length andErrorMessage:(NSString * _Nullable)errorMessage;
+ (BOOL)run:(NSString * _Nullable)string UNAVAILABLE_ATTRIBUTE;
+ (BOOL)run:(NSString * _Nullable)string withLength:(NSNumber * _Nonnull)length;

@end
