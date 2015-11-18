//
//  ViewController.h
//  TMValidatorDemo
//
//  Created by Kazuya Ueoka on 2015/11/18.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMValidateTextField.h"
#import "TMValidateTextView.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) TMValidateTextField *firstName;
@property (nonatomic) TMValidateTextField *lastName;
@property (nonatomic) TMValidateTextField *email;
@property (nonatomic) TMValidateTextView *memo;

- (void)textFieldDidChanged:(TMValidateTextField *)textField;

@end

