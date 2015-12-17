//
//  TMValidateTextField.h
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/17.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidator.h"

@interface TMValidateTextField : UITextField
{
    TMValidatorField *_field;
}

@property (nonatomic) NSString *label;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithRules:(NSArray<__kindof TMValidatorRule *> *)rules;
- (instancetype)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder andRules:(NSArray<__kindof TMValidatorRule *> *)rules;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame andRules:(NSArray<__kindof TMValidatorRule *> *)rules;
- (instancetype)addRule:(__kindof TMValidatorRule *)rule;
- (instancetype)addRules:(NSArray<__kindof TMValidatorRule *> *)rules;
- (BOOL)valid;
- (NSArray <NSError *> *)errors;

@end
