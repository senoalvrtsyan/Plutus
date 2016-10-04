//
//  SignupViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginBaseViewController.h"

#include "User.h"

@interface SignupViewControllerBase : LoginBaseViewController
    <UITextFieldDelegate>

-(NSString*)labelText;
-(NSString*)textFieldPlaceholder;
-(UIReturnKeyType)returnKeyType;
-(UITextAutocapitalizationType)textFieldAutocapitalizationType;

-(void)nextAction;
-(BOOL)validateInput;

-(void)SetUser:(User)user;
-(User)GetUser;

@property UITextField* textField;

@property User user;

@end

@interface NameViewController : SignupViewControllerBase
@end

@interface UsernameViewController : SignupViewControllerBase
@end

@interface EmailViewController : SignupViewControllerBase
@end

@interface PasswordViewController : SignupViewControllerBase
@end