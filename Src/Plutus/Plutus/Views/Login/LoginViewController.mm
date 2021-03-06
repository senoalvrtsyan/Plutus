//
//  LoginViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "LoginViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "Constants.h"
#import "Utils.h"
#import "Theme.h"

#include "Service.h"

#import "SignupViewController.h"
#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "HistoryViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    // Show the keyboard.
    [_login becomeFirstResponder];
}

-(void)createControls
{
    static const int viewW = self.view.frame.size.width;
    static const int viewH = self.view.frame.size.height;
    static const int availibleH = viewH - keyboardH;
    static const int contentH = logoS + 20 + controlH + 10 + controlH + controlH + 20 + controlH;
    
    // Take care of the logo.
    static const int logoY = (availibleH - contentH) / 2;
    static const int logoX = (viewW - logoS) / 2; // Centered
    UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
    logo.image = [UIImage imageNamed: @"moneybag_256"];
    
    [self.view addSubview: logo];
    
    // Take care of login field. Expecting username right now.
    static const int loginW = viewW - 80;
    static const int loginX = (viewW - loginW) / 2;  // Centered
    static const int loginY = logoY + logoS + 20;
    _login = [[UITextField alloc] initWithFrame: CGRectMake(loginX, loginY, loginW, controlH)];
    theme::applyStyle(_login);
    _login.placeholder = @"username";
    _login.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _login.autocorrectionType = UITextAutocorrectionTypeNo;
    _login.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview: _login];
    
    // Take care of passowrd field.
    static const int pwdY = loginY + controlH + 10;
    _password = [[UITextField alloc] initWithFrame: CGRectMake(loginX, pwdY, loginW, controlH)];
    theme::applyStyle(_password);
    _password.placeholder = @"password";
    _password.secureTextEntry = YES;
    
    [self.view addSubview: _password];
    
    // Take care of forgot password.
    static const int forgotW = loginW;
    static const int forgotX = loginX;
    static const int forgotY = pwdY + controlH;
    UIButton* forgot = [[UIButton alloc] initWithFrame: CGRectMake(forgotX, forgotY, forgotW, controlH)];
    [forgot setTitle: @"Forgot your password?" forState: UIControlStateNormal];
    [forgot setTitleColor: theme::lightGrayColor() forState: UIControlStateNormal];
    [forgot setTitleColor: theme::grayColor() forState: UIControlStateHighlighted];
    forgot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgot.titleLabel.font = [UIFont systemFontOfSize: forgot.titleLabel.font.pointSize - 5];
    
    [self.view addSubview: forgot];
    
    // Take care of login button.
    static const int loginBtnW = loginW / 2 - 5;
    static const int loginBtnX = loginX + loginBtnW + 10;
    static const int loginBtnY = forgotY + controlH + 20;
    UIButton* loginBtn = [[UIButton alloc] initWithFrame: CGRectMake(loginBtnX, loginBtnY, loginBtnW, controlH)];
    [loginBtn addTarget: self action: @selector(loginAction) forControlEvents: UIControlEventTouchUpInside];
    loginBtn.backgroundColor = theme::brandColor4();
    [loginBtn setBackgroundImage: imageWithColor(theme::brandColor5()) forState: UIControlStateHighlighted];
    [loginBtn setTitle: @"Log In" forState: UIControlStateNormal];
    
    [self.view addSubview: loginBtn];
    
    // Take care of signup button.
    UIButton* signupBtn = [[UIButton alloc] initWithFrame: CGRectMake(loginX, loginBtnY, loginBtnW, controlH)];
    [signupBtn addTarget: self action: @selector(signupAction) forControlEvents: UIControlEventTouchUpInside];
    signupBtn.backgroundColor = theme::brandColor2();
    [signupBtn setBackgroundImage: imageWithColor(theme::brandColor5()) forState: UIControlStateHighlighted];
    [signupBtn setTitle: @"Sign Up" forState: UIControlStateNormal];
    
    [self.view addSubview: signupBtn];
}

-(void)loginAction
{
    // Try to login with credentials.
    User user;
    user._username = ToStdString(_login.text);
    user._password = ToStdString(_password.text);
    
    [Service::Instance() SignIn:user completionHandler: ^(BOOL res){
        [self handleSignIn: res];
    }];
}

-(void)signupAction
{
    [_login resignFirstResponder];
    
    NameViewController* vc = [[NameViewController alloc] init];
    [self.navigationController pushViewController: vc animated: YES];
}

@end
