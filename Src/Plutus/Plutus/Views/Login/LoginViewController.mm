//
//  ViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "LoginViewController.h"

#import <QuartzCore/QuartzCore.h>

#include "Utils.h"
#include "Theme.h"

#include "NameViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set background color of the view.
    //self.view.backgroundColor = backgroundColor();
    
    // Create the view contorls.
    [self createControls];
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
    static const int keyboardH = 216; // Hardcode this for now.
    static const int availibleH = viewH - keyboardH;
    static const int controlH = 40;
    static const int logoS = 70;
    static const int contentH = logoS + 20 + controlH + 10 + controlH + controlH + 20 + controlH;
    
    // Take care of the logo.
    static const int logoY = (availibleH - contentH) / 2;
    static const int logoX = (viewW - logoS) / 2; // Centered
    UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
    logo.image = [UIImage imageNamed: @"moneybag_256"];
    
    [self.view addSubview: logo];
    
    // Take care of login field. Expecting email right now.
    static const int loginW = viewW - 80;
    static const int loginX = (viewW - loginW) / 2;  // Centered
    static const int loginY = logoY + logoS + 20;
    UITextField* login = [[UITextField alloc] initWithFrame: CGRectMake(loginX, loginY, loginW, controlH)];
    theme::applyStyle(login, controlH);
    login.placeholder = @"email";
    login.autocapitalizationType = UITextAutocapitalizationTypeNone;
    login.autocorrectionType = UITextAutocorrectionTypeNo;
    login.keyboardType = UIKeyboardTypeEmailAddress;
    
    [self.view addSubview: login];
    
    // Take care of passowrd field.
    static const int pwdY = loginY + controlH + 10;
    UITextField* password = [[UITextField alloc] initWithFrame: CGRectMake(loginX, pwdY, loginW, controlH)];
    // Add left padding.
    UIView* pwdPadding = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 15, controlH)];
    password.leftView = pwdPadding;
    password.leftViewMode = UITextFieldViewModeAlways;

    password.placeholder = @"password";
    password.textColor = theme::textColor();
    // password.textAlignment = NSTextAlignmentCenter;
    password.secureTextEntry = YES;
    password.backgroundColor = theme::whiteColor();
    // Border style.
    password.layer.cornerRadius = 0.0f;
    password.layer.masksToBounds = YES;
    password.layer.borderColor = [theme::brandColor4() CGColor];
    password.layer.borderWidth = 1.0f;
    
    [self.view addSubview: password];
    
    // Take care of forgot password.
    static const int forgotW = loginW;
    static const int forgotX = loginX;
    static const int forgotY = pwdY + controlH;
    UIButton* forgot = [[UIButton alloc] initWithFrame: CGRectMake(forgotX, forgotY, forgotW, controlH)];
    [forgot setTitle: @"Forgot your password?" forState: UIControlStateNormal];
    [forgot setTitleColor: theme::brandColor3() forState: UIControlStateNormal];
    [forgot setTitleColor: theme::brandColor4() forState: UIControlStateHighlighted];
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
    
    // Show the keyboard.
    [login becomeFirstResponder];
}

-(void)loginAction
{}

-(void)signupAction
{
    NameViewController* nameViewController = [[NameViewController alloc] init];
    [self presentViewController: nameViewController animated: YES completion: nil];
}

@end
