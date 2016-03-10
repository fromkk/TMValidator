//
//  TMValidator.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/15.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidatorCommon.h"
#import "TMValidatorField.h"
#import "TMValidatorRuleRequired.h"
#import "TMValidatorRuleIsEmpty.h"
#import "TMValidatorRuleMinLength.h"
#import "TMValidatorRuleMaxLength.h"
#import "TMValidatorRuleExactLength.h"
#import "TMValidatorRuleIsNumeric.h"
#import "TMValidatorRuleIsAlphabet.h"
#import "TMValidatorRuleIsAlnum.h"
#import "TMValidatorRuleNumericMin.h"
#import "TMValidatorRuleNumericMax.h"
#import "TMValidatorRuleNumericBetween.h"
#import "TMValidatorRuleMatchValue.h"
#import "TMValidatorRuleMatchPattern.h"
#import "TMValidatorRuleEmail.h"
#import "TMValidatorRuleURL.h"

@interface TMValidator : NSObject

@property (nonatomic, readonly) NSMutableArray * _Nonnull fields;

+ (instancetype _Nonnull)validator;

- (instancetype _Nonnull)addField:(__kindof TMValidatorField * _Nonnull)field;
- (instancetype _Nonnull)addFields:(NSArray <__kindof TMValidatorField * > * _Nonnull)fields;
- (BOOL)runWithSuccesses:(void (^ _Nullable)(NSArray <__kindof TMValidatorField *> * _Nonnull successes))success andFailure:(void (^ _Nullable)(NSArray <__kindof TMValidatorField *> * _Nullable errors))failure;
- (BOOL)runWithFailure:(void (^ _Nullable)(NSArray <__kindof TMValidatorField *> * _Nullable errors))failure;
- (BOOL)run;
- (NSArray <NSError *> * _Nonnull)errors;

@end
