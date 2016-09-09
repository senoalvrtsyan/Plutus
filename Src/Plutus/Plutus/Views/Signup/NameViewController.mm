//
//  NameViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NameViewController.h"

#include "Theme.h"

@interface NameViewController ()

@end

@implementation NameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set background color of the view.
    self.view.backgroundColor = theme::whiteColor();
    
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
    static const int contentH = logoS + 20 + controlH + 10 + controlH;
    
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
    label.textColor = [UIColor lightGrayColor];
    label.text = @"Enter your first and last name";
    
    [self.view addSubview: label];
    
    // Take care of text field.
    static const int textFieldW = viewW - 80;
    static const int textFieldY = labelY + controlH + 10;
    static const int textFieldX = (viewW - labelW) / 2; // Centered
    UITextField* textField = [[UITextField alloc] initWithFrame: CGRectMake(textFieldX, textFieldY, textFieldW, controlH)];
    theme::applyStyle(textField, controlH);
    textField.placeholder = @"First Last";
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self.view addSubview: textField];
    
    // Take care of close view button - X
    static const int closeS = 28;
    static const int closeY = closeS;
    static const int closeX = viewW - closeS - closeS / 2;
    UIImageView* close = [[UIImageView alloc] initWithFrame: CGRectMake(closeX, closeY, closeS, closeS)];
    close.image = [UIImage imageNamed: @"close_128"];
    
    [self.view addSubview: close];
    
    [textField becomeFirstResponder];
}

@end
