//
//  TMValidatorField.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/16.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidatorRule.h"

@interface TMValidatorField : NSObject

@property (nonatomic) NSString *label;
@property (nonatomic) NSString *value;
@property (nonatomic, weak) UIView *element;
@property (nonatomic) NSMutableArray <__kindof TMValidatorRule *> *rules;
@property (nonatomic) NSMutableArray <NSError *> *errors;

+ (instancetype)fieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(__kindof UIView *)element;
+ (instancetype)fieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(__kindof UIView *)element andRules:(NSArray <TMValidatorRule *> *)rules;
+ (instancetype)requiredFieldWithValue:(NSString *)value andLabel:(NSString *)label andElement:(__kindof UIView *)element;
- (instancetype)addRule:(__kindof TMValidatorRule *)rule;
- (instancetype)addRules:(NSArray <__kindof TMValidatorRule *> *)rules;
- (BOOL)run;

@end
