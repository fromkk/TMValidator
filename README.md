# TMValidator

## Description

iOSでバリデーションをする為のクラスです。

## Usage

```Objective-C
UITextField *firstName = [[UITextField alloc] init];
firstName.text = @"名";

UITextField *lastName  = [[UITextField alloc] init];
lastName.text = @"姓";

TMValidatorField *fieldFirstName = [TMValidatorField fieldWithValue:firstName.text andLabel:@"firstName" andElement:firstName];
[[fieldFirstName addRule:[TMValidatorRuleRequired rule]] addRule:[TMValidatorRuleMaxLength ruleWithLength:@10]];

TMValidatorField *fieldLastName  = [TMValidatorField fieldWithValue:lastName.text andLabel:@"lastName" andElement:lastName];
[[fieldLastName addRule:[TMValidatorRuleRequired rule]] addRule:[TMValidatorRuleMaxLength ruleWithLength:@10]];

TMValidator *validator = [TMValidator validator];
[[validator addField:fieldFirstName] addField:fieldLastName];

[validator runWithSuccesses:^(NSArray *successes) {
    NSLog(@"success! %@", successes);
} andFailure:^(NSArray *errors) {
    NSLog(@"failure! %@", errors);
}];


```
