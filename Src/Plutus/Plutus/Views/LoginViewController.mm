//
//  ViewController.m
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "LoginViewController.h"

#import <QuartzCore/QuartzCore.h>

// Utils

UIColor* CreateColor(int r, int g, int b, double a = 1.0)
{
    return [UIColor colorWithRed: (double)r/255.0 green: (double)g/255.0 blue: (double)b/255.0 alpha: a];
}

UIImage* imageWithColor(UIColor* color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// Theme

UIColor* brandColor1()
{
    return CreateColor(242, 173, 151);
}

UIColor* brandColor2()
{
    return CreateColor(242, 105, 104);
}

UIColor* brandColor3()
{
    return CreateColor(223, 226, 210);
}

UIColor* brandColor4()
{
    return CreateColor(108, 191, 132);
}

UIColor* brandColor5()
{
    return CreateColor(50, 51, 57);
}

UIColor* backgroundColor()
{
    return brandColor3();
}

UIColor* textColor()
{
    return brandColor5();
}

UIColor* whiteColor()
{
    return CreateColor(255, 255, 255);
}

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
    // Add left padding.
    UIView* loginPadding = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 15, controlH)];
    login.leftView = loginPadding;
    login.leftViewMode = UITextFieldViewModeAlways;
    
    login.placeholder = @"email";
    login.textColor = textColor();
    login.autocapitalizationType = UITextAutocapitalizationTypeNone;
    login.autocorrectionType = UITextAutocorrectionTypeNo;
    // login.textAlignment = NSTextAlignmentCenter;
    login.backgroundColor = whiteColor();
    login.keyboardType = UIKeyboardTypeEmailAddress;
    // Border style.
    login.layer.cornerRadius = 0.0f;
    login.layer.masksToBounds = YES;
    login.layer.borderColor = [brandColor4() CGColor];
    login.layer.borderWidth = 1.0f;
    
    [self.view addSubview: login];
    
    // Take care of passowrd field.
    static const int pwdY = loginY + controlH + 10;
    UITextField* password = [[UITextField alloc] initWithFrame: CGRectMake(loginX, pwdY, loginW, controlH)];
    // Add left padding.
    UIView* pwdPadding = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 15, controlH)];
    password.leftView = pwdPadding;
    password.leftViewMode = UITextFieldViewModeAlways;

    password.placeholder = @"password";
    password.textColor = textColor();
    // password.textAlignment = NSTextAlignmentCenter;
    password.secureTextEntry = YES;
    password.backgroundColor = whiteColor();
    // Border style.
    password.layer.cornerRadius = 0.0f;
    password.layer.masksToBounds = YES;
    password.layer.borderColor = [brandColor4() CGColor];
    password.layer.borderWidth = 1.0f;
    
    [self.view addSubview: password];
    
    // Take care of forgot password.
    static const int forgotW = loginW;
    static const int forgotX = loginX;
    static const int forgotY = pwdY + controlH;
    UIButton* forgot = [[UIButton alloc] initWithFrame: CGRectMake(forgotX, forgotY, forgotW, controlH)];
    [forgot setTitle: @"Forgot your password?" forState: UIControlStateNormal];
    [forgot setTitleColor: brandColor3() forState: UIControlStateNormal];
    [forgot setTitleColor: brandColor4() forState: UIControlStateHighlighted];
    forgot.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgot.titleLabel.font = [UIFont systemFontOfSize: forgot.titleLabel.font.pointSize - 5];
    
    [self.view addSubview: forgot];
    
    // Take care of loing button.
    static const int loginBtnW = loginW / 2 - 5;
    static const int loginBtnX = loginX + loginBtnW + 10;
    static const int loginBtnY = forgotY + controlH + 20;
    UIButton* loginBtn = [[UIButton alloc] initWithFrame: CGRectMake(loginBtnX, loginBtnY, loginBtnW, controlH)];
    loginBtn.backgroundColor = brandColor4();
    [loginBtn setBackgroundImage: imageWithColor(brandColor5()) forState: UIControlStateHighlighted];
    [loginBtn setTitle: @"Log In" forState: UIControlStateNormal];
    
    [self.view addSubview: loginBtn];
    
    // Take care of signup button.
    UIButton* signupBtn = [[UIButton alloc] initWithFrame: CGRectMake(loginX, loginBtnY, loginBtnW, controlH)];
    signupBtn.backgroundColor = brandColor2();
    [signupBtn setBackgroundImage: imageWithColor(brandColor5()) forState: UIControlStateHighlighted];
    [signupBtn setTitle: @"Sign Up" forState: UIControlStateNormal];
    
    [self.view addSubview: signupBtn];
    
    // Show the keyboard.
    [login becomeFirstResponder];
}

@end
