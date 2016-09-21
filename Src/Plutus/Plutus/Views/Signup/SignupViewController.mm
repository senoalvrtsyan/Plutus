//
//  SignupViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "SignupViewController.h"

#import "Constants.h"
#import "Theme.h"
#import "Utils.h"

#include "Service.h"

@interface SignupViewControllerBase ()

@end

@implementation SignupViewControllerBase

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set background color of the view.
    self.view.backgroundColor = theme::whiteColor();
    
    // Create the view contorls.
    [self createControls];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [_textField becomeFirstResponder];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createControls
{
    static const int viewW = self.view.frame.size.width;
    static const int viewH = self.view.frame.size.height;
    static const int availibleH = viewH - keyboardH;
    static const int contentH = logoS + 20 + controlH + 5 + controlH;
    
    // Take care of close view button - "X"
    static const int closeS = 30;
    static const int closeY = closeS;
    static const int closeX = viewW - closeS - closeS / 3;
    UIButton* close = [[UIButton alloc] initWithFrame: CGRectMake(closeX, closeY, closeS, closeS)];
    [close setImage: [UIImage imageNamed: @"close_128"] forState: UIControlStateNormal];
    [close addTarget: self action: @selector(closeAction) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview: close];
    
    // Take care of back view button - "<-"
    static const int backX = closeS / 3;
    UIButton* back = [[UIButton alloc] initWithFrame: CGRectMake(backX, closeY, closeS, closeS)];
    [back setImage: [UIImage imageNamed: @"arrow_256"] forState: UIControlStateNormal];
    [back addTarget: self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview: back];
    
    // Take care of the logo.
    static const int logoY = (availibleH - contentH) / 2;
    static const int logoX = (viewW - logoS) / 2; // Centered
    UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
    logo.image = [UIImage imageNamed: @"moneybag_256"];
    
    [self.view addSubview: logo];
    
    // Take care of the label.
    static const int labelW = viewW - 80;
    static const int labelY = logoY + logoS + 20;
    static const int labelX = (viewW - labelW) / 2; // Centered
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(labelX, labelY, labelW, controlH)];
    label.textColor = theme::lightGrayColor();
    label.text = [self labelText];
    
    [self.view addSubview: label];
    
    // Take care of text field.
    static const int textFieldW = viewW - 80;
    static const int textFieldY = labelY + controlH + 5;
    static const int textFieldX = (viewW - labelW) / 2; // Centered
    _textField = [[UITextField alloc] initWithFrame: CGRectMake(textFieldX, textFieldY, textFieldW, controlH)];
    theme::applyStyle(_textField);
    _textField.placeholder = [self textFieldPlaceholder];
    _textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.returnKeyType = [self returnKeyType];
    _textField.delegate = self;
    
    [self.view addSubview: _textField];
}

-(NSString*)labelText
{
    return @"";
}

-(NSString*)textFieldPlaceholder
{
    return @"";
}

-(UIReturnKeyType)returnKeyType
{
    return UIReturnKeyNext;
}

-(void)nextAction
{
    // Empty;
}

-(BOOL)validateInput
{
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if([self validateInput])
    {
        [self nextAction];
        return YES;
    }
    else
    {
        // TODO: show message box.
        return NO;
    }
}

-(void)backAction
{
    [_textField resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated: YES];
}

-(void)closeAction
{
    [_textField resignFirstResponder];
    
    [self.navigationController popToRootViewControllerAnimated: YES];
}

@end

@interface NameViewController ()
@end

@implementation NameViewController

-(NSString*)labelText
{
    return @"Enter your first and last names";
}

-(NSString*)textFieldPlaceholder
{
    return @"First Last";
}

-(void)nextAction
{
    super.user._name = ToStdString(super.textField.text);
    
    UsernameViewController* vc = [[UsernameViewController alloc] init];
    [self.navigationController pushViewController: vc animated: YES];
}

-(BOOL)validateInput
{
    return validateName(super.textField.text);
}

@end

@interface UsernameViewController ()
@end

@implementation UsernameViewController

-(NSString*)labelText
{
    return @"Choose a unique username";
}

-(NSString*)textFieldPlaceholder
{
    return @"username";
}

-(void)nextAction
{
    super.user._username = ToStdString(super.textField.text);
    
    EmailViewController* vc = [[EmailViewController alloc] init];
    [self.navigationController pushViewController: vc animated: YES];
}

-(BOOL)validateInput
{
    return validateName(super.textField.text);
}

@end

@interface EmailViewController ()
@end

@implementation EmailViewController

-(NSString*)labelText
{
    return @"Enter your email address";
}

-(NSString*)textFieldPlaceholder
{
    return @"email";
}

-(void)nextAction
{
    super.user._email = ToStdString(super.textField.text);
    
    PasswordViewController* vc = [[PasswordViewController alloc] init];
    [self.navigationController pushViewController: vc animated: YES];
}

-(BOOL)validateInput
{
    return validateEmail(super.textField.text);
}

@end

@interface PasswordViewController ()
@end

@implementation PasswordViewController

-(NSString*)labelText
{
    return @"Create a password";
}

-(NSString*)textFieldPlaceholder
{
    return @"password";
}

-(UIReturnKeyType)returnKeyType
{
    return UIReturnKeyJoin;
}

-(void)nextAction
{
    super.user._password = ToStdString(super.textField.text);
    
    // Cool now we have user object constucted, try to sign-up with service.
    if(Service::Instance().SignUp(super.user))
    {
        // Awesome, set the user and show the maintab controller itself.
        Service::Instance().SetUser(super.user);
        showTabBarController(self);
    }
    else
    {
        
    }
}

-(BOOL)validateInput
{
    return validatePassword(super.textField.text);
}

@end

