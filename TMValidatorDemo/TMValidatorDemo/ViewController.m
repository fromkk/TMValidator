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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstName = [[TMValidateTextField alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired rule], [TMValidatorRuleMaxLength ruleWithLength:@10]]];
    self.firstName.placeholder = @"姓";
    self.firstName.borderStyle = UITextBorderStyleRoundedRect;
    self.firstName.returnKeyType = UIReturnKeyDone;
    self.firstName.layer.borderColor = [UIColor redColor].CGColor;
    self.firstName.layer.cornerRadius = 5.0f;
    self.firstName.delegate = self;
    self.firstName.label = @"firstName";
    [self.view addSubview:self.firstName];
    
    self.lastName  = [[TMValidateTextField alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired rule], [TMValidatorRuleMaxLength ruleWithLength:@10]]];
    self.lastName.placeholder = @"名";
    self.lastName.borderStyle = UITextBorderStyleRoundedRect;
    self.lastName.returnKeyType = UIReturnKeyDone;
    self.lastName.layer.borderColor = [UIColor redColor].CGColor;
    self.lastName.layer.cornerRadius = 5.0f;
    self.lastName.delegate = self;
    self.lastName.label = @"lastname";
    [self.view addSubview:self.lastName];
    
    self.email  = [[TMValidateTextField alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired rule], [TMValidatorRuleEmail rule]]];
    self.email.placeholder = @"メールアドレス";
    self.email.borderStyle = UITextBorderStyleRoundedRect;
    self.email.returnKeyType = UIReturnKeyDone;
    self.email.layer.borderColor = [UIColor redColor].CGColor;
    self.email.layer.cornerRadius = 5.0f;
    self.email.delegate = self;
    self.email.label = @"email";
    [self.view addSubview:self.email];
    
    self.memo = [[TMValidateTextView alloc] initWithFrame:CGRectZero andRules:@[[TMValidatorRuleRequired rule], [TMValidatorRuleMaxLength ruleWithLength:@(100)]]];
    self.memo.label = @"memo";
    self.memo.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    self.memo.layer.borderWidth = 1.0;
    self.memo.layer.cornerRadius = 5.0f;
    [self.view addSubview:self.memo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.firstName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.lastName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.email];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChanged:) name:UITextViewTextDidChangeNotification object:self.memo];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.firstName.frame = CGRectMake(10.0, 30.0, self.view.frame.size.width - 20.0, 44.0);
    self.lastName.frame  = CGRectMake(10.0, CGRectGetMaxY(self.firstName.frame) + 10.0, self.view.frame.size.width - 20.0, 44.0);
    self.email.frame  = CGRectMake(10.0, CGRectGetMaxY(self.lastName.frame) + 10.0, self.view.frame.size.width - 20.0, 44.0);
    self.memo.frame = CGRectMake(10.0f, CGRectGetMaxY(self.email.frame) + 10.0, self.view.frame.size.width - 20.0, 80.0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.firstName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.lastName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.email];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self.memo];
    
    [self.firstName removeFromSuperview];
    self.firstName = nil;
    
    [self.lastName removeFromSuperview];
    self.lastName = nil;
    
    [self.email removeFromSuperview];
    self.email = nil;
    
    [self.memo removeFromSuperview];
    self.memo = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSLog(@"%@", textField.errors);
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
        NSLog(@"%@", textView.errors);
        self.memo.layer.borderColor = [UIColor redColor].CGColor;
        textView.layer.borderWidth = 5.0;
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
