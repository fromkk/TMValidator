//
//  TMValidator.m
//  TMValidator
//
//  Created by Kazuya Ueoka on 2015/11/15.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "TMValidator.h"

@interface TMValidator ()

@property (nonatomic, readwrite) NSMutableArray * fields;

@end

@implementation TMValidator

+ (instancetype)validator
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.fields = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)addField:(TMValidatorField *)field
{
    NSAssert([field isKindOfClass:[TMValidatorField class]], @"field is not kind of TMValidatorField");
    
    [self.fields addObject:field];
    
    return self;
}

- (instancetype)addFields:(NSArray<__kindof TMValidatorField *> *)fields
{
    for (TMValidatorField *field in fields)
    {
        [self addField:field];
    }
    
    return self;
}

- (BOOL)runWithSuccesses:(void (^)(NSArray <__kindof TMValidatorField *> *))success andFailure:(void (^)(NSArray <__kindof TMValidatorField *> *))failure
{
    NSMutableArray *successes = [NSMutableArray array];
    NSMutableArray *errors    = [NSMutableArray array];
    
    BOOL result = YES;
    TMValidatorField *field;
    for (int i = 0; i < self.fields.count; i++)
    {
        field = [self.fields objectAtIndex:i];
        
        if ( [field run] )
        {
            [successes addObject:field];
        } else
        {
            result = NO;
            [errors addObject:field];
        }
    }
    
    if (nil != success)
    {
        success(successes);
    }
    if (nil != failure)
    {
        failure(errors);
    }
    return result;
}

- (BOOL)runWithFailure:(void (^)(NSArray <__kindof TMValidatorField *> *))failure
{
    return [self runWithSuccesses:nil andFailure:failure];
}

- (BOOL)run
{
    return [self runWithSuccesses:nil andFailure:nil];
}

- (NSArray <NSError *> *)errors
{
    NSMutableArray *errors = [NSMutableArray array];
    for (TMValidatorField *field in self.fields)
    {
        if (!field.run)
        {
            [errors addObjectsFromArray:field.errors];
        }
    }
    return errors;
}

- (void)dealloc
{
    _fields = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: fields=%@>", NSStringFromClass(self.class), self.fields];
}

@end
