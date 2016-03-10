//
//  ViewController.m
//  TMValidatorDemo
//
//  Created by Kazuya Ueoka on 2015/11/18.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "ViewController.h"
#import "TMValidator.h"

@interface ViewController ()
@property (nonatomic) UIButton *registrationButton;
@property (nonatomic) TMValidator *validator;
- (void)onRegistrationButtonDidTapped:(UIButton *)button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.firstName];
    [self.view addSubview:self.lastName];
    [self.view addSubview:self.email];
    [self.view addSubview:self.memo];
    [self.view addSubview:self.registrationButton];
    
    self.validator = [TMValidator validator];
    [self.validator addFields:@[self.firstName.field, self.lastName.field, self.email.field, self.memo.field]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.firstName.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width - 20.0, 44.0);
    self.lastName.frame  = CGRectMake(10.0, CGRectGetMaxY(self.firstName.frame) + 10.0, self.view.frame.size.width - 20.0, 44.0);
    self.email.frame  = CGRectMake(10.0, CGRectGetMaxY(self.lastName.frame) + 10.0, self.view.frame.size.width - 20.0, 44.0);
    self.memo.frame = CGRectMake(10.0f, CGRectGetMaxY(self.email.frame) + 10.0, self.view.frame.size.width - 20.0, 80.0);
    self.registrationButton.frame = CGRectMake(20.0, CGRectGetMaxY(self.memo.frame) + 20.0, self.view.frame.size.width - 40.0, 44.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - element

- (TMValidateTextField *)firstName
{
    if (_firstName)
    {
        return _firstName;
    }
    
    _firstName = [[TMValidateTextField alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired ruleWithErrorMessage:@"姓は必須入力です"], [TMValidatorRuleMaxLength ruleWithLength:@10 andErrorMessage:@"10文字以内で入力して下さい"]]];
    _firstName.placeholder = @"姓（入力必須/10文字以内）";
    _firstName.borderStyle = UITextBorderStyleRoundedRect;
    _firstName.returnKeyType = UIReturnKeyDone;
    _firstName.layer.borderColor = [UIColor redColor].CGColor;
    _firstName.layer.cornerRadius = 5.0f;
    _firstName.delegate = self;
    _firstName.label = @"firstName";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:_firstName];
    return _firstName;
}

- (TMValidateTextField *)lastName
{
    if (_lastName)
    {
        return _lastName;
    }
    
    _lastName  = [[TMValidateTextField alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired ruleWithErrorMessage:@"名は必須入力です"], [TMValidatorRuleMaxLength ruleWithLength:@10 andErrorMessage:@"10文字以内で入力して下さい"]]];
    _lastName.placeholder = @"名（入力必須/10文字以内）";
    _lastName.borderStyle = UITextBorderStyleRoundedRect;
    _lastName.returnKeyType = UIReturnKeyDone;
    _lastName.layer.borderColor = [UIColor redColor].CGColor;
    _lastName.layer.cornerRadius = 5.0f;
    _lastName.delegate = self;
    _lastName.label = @"lastname";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:_lastName];
    return _lastName;
}

- (TMValidateTextField *)email
{
    if (_email)
    {
        return _email;
    }
    
    _email  = [[TMValidateTextField alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired ruleWithErrorMessage:@"メールアドレスは必須入力です"], [TMValidatorRuleEmail ruleWithErrorMessage:@"メールアドレスの形式で入力して下さい"]]];
    _email.placeholder = @"メールアドレス（入力必須）";
    _email.borderStyle = UITextBorderStyleRoundedRect;
    _email.returnKeyType = UIReturnKeyDone;
    _email.layer.borderColor = [UIColor redColor].CGColor;
    _email.layer.cornerRadius = 5.0f;
    _email.delegate = self;
    _email.label = @"email";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:_email];
    return _email;
}

- (TMValidateTextView *)memo
{
    if (_memo)
    {
        return _memo;
    }
    
    _memo = [[TMValidateTextView alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired ruleWithErrorMessage:@"メモは入力必須です"], [TMValidatorRuleMaxLength ruleWithLength:@(100) andErrorMessage:@"メモは100文字以内で入力して下さい"]]];
    _memo.label = @"memo";
    _memo.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    _memo.layer.borderWidth = 1.0;
    _memo.layer.cornerRadius = 5.0f;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChanged:) name:UITextViewTextDidChangeNotification object:_memo];
    return _memo;
}

- (UIButton *)registrationButton
{
    if (_registrationButton)
    {
        return _registrationButton;
    }
    
    _registrationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registrationButton.layer.cornerRadius = 3.0;
    _registrationButton.layer.masksToBounds = YES;
    _registrationButton.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.8 alpha:1.0];
    [_registrationButton setTitle:@"登録" forState:UIControlStateNormal];
    [_registrationButton addTarget:self action:@selector(onRegistrationButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    return _registrationButton;
}

#pragma mark - NSNotificationCenter observer

- (void)textFieldDidChanged:(NSNotification *)notif
{
    TMValidateTextField *textField = (TMValidateTextField *)[notif object];
    if (textField.valid)
    {
        textField.layer.borderWidth = 0.0;
    } else
    {
        textField.layer.borderWidth = 5.0;
    }
}

- (void)textViewDidChanged:(NSNotification *)notif
{
    TMValidateTextView *textView = (TMValidateTextView *)[notif object];
    if (textView.valid)
    {
        self.memo.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
        textView.layer.borderWidth = 1.0;
    } else
    {
        self.memo.layer.borderColor = [UIColor redColor].CGColor;
        textView.layer.borderWidth = 5.0;
    }
}

#pragma mark - event

- (void)onRegistrationButtonDidTapped:(UIButton *)button
{
    if (self.validator.run)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"👍" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else
    {
        NSArray *errors = self.validator.errors;
        NSMutableString *errorString = [NSMutableString string];
        for (NSError *error in errors)
        {
            if (0 != errorString.length) [errorString appendString:@"\n"];
            [errorString appendString:[error localizedDescription]];
        }
        errors = nil;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"エラー" message:errorString preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_firstName removeFromSuperview];
    _firstName = nil;
    
    [_lastName removeFromSuperview];
    _lastName = nil;
    
    [_email removeFromSuperview];
    _email = nil;
    
    [_memo removeFromSuperview];
    _memo = nil;
    
    _validator = nil;
}

@end
