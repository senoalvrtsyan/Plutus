//
//  SignupViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewControllerBase : UIViewController
    <UITextFieldDelegate>

-(NSString*)labelText;
-(NSString*)textFieldPlaceholder;
-(UIReturnKeyType)returnKeyType;

-(void)nextAction;
-(BOOL)validateInput;

@property UITextField* textField;

@end

@interface NameViewController : SignupViewControllerBase
@end

@interface UsernameViewController : SignupViewControllerBase
@end

@interface EmailViewController : SignupViewControllerBase
@end

@interface PasswordViewController : SignupViewControllerBase
@end