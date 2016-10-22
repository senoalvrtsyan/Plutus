//
//  SearchViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "SearchViewController.h"

#import "Constants.h"
#import "Utils.h"
#import "Theme.h"

#include "Service.h"

#import "TransferViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Transfer";
    
    // Set background color of the view.
    self.view.backgroundColor = theme::whiteColor();
    
    // Create the view contorls.
    [self createControls];
        
    // Close keyboard on tap outside.
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer: tap];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    //[_textField becomeFirstResponder];
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
    static const int contentH = controlH + 5 + controlH + 20 + controlH;
    
    // Take care of info label.
    static const int labelW = viewW - 80;
    static const int labelY = (availibleH - contentH) / 2;
    static const int labelX = (viewW - labelW) / 2; // Centered
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(labelX, labelY, labelW, controlH)];
    label.textColor = theme::grayColor();
    label.text = @"Enter the username";
    
    [self.view addSubview: label];
    
    // Take care of search text field.
    static const int textFieldW = viewW - 80;
    static const int textFieldY = labelY + controlH + 5;
    static const int textFieldX = (viewW - labelW) / 2; // Centered
    _textField = [[UITextField alloc] initWithFrame: CGRectMake(textFieldX, textFieldY, textFieldW, controlH)];
    theme::applyStyle(_textField);
    _textField.placeholder = @"username";
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.returnKeyType = UIReturnKeySearch;
    [_textField addTarget: self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _textField.delegate = self;
    
    [self.view addSubview: _textField];
    
    // Take care of the action button.
    static const int btnW = textFieldW;
    static const int btnY = textFieldY + controlH + 20;
    static const int btnX = textFieldX;
    _transferBtn = [[UIButton alloc] initWithFrame: CGRectMake(btnX, btnY, btnW, controlH)];
    [_transferBtn addTarget: self action: @selector(searchAction) forControlEvents: UIControlEventTouchUpInside];
    [_transferBtn setBackgroundImage: imageWithColor(theme::brandColor4()) forState: UIControlStateNormal];
    [_transferBtn setBackgroundImage: imageWithColor(theme::brandColor5()) forState: UIControlStateHighlighted];
    [_transferBtn setBackgroundImage: imageWithColor(theme::grayColor()) forState: UIControlStateDisabled];
    [_transferBtn setTitle: @"Transfer" forState: UIControlStateNormal];
    _transferBtn.enabled = NO;
    
    [self.view addSubview: _transferBtn];
    
    // Take care of request payment button.
    _requestBtn = [[UIButton alloc] initWithFrame: CGRectMake(textFieldX, btnY + controlH + 10, btnW, controlH)];
    [_requestBtn addTarget: self action: @selector(requestAction) forControlEvents: UIControlEventTouchUpInside];
    [_requestBtn setBackgroundImage: imageWithColor(theme::brandColor4()) forState: UIControlStateNormal];
    [_requestBtn setBackgroundImage: imageWithColor(theme::brandColor5()) forState: UIControlStateHighlighted];
    [_requestBtn setBackgroundImage: imageWithColor(theme::grayColor()) forState: UIControlStateDisabled];
    [_requestBtn setTitle: @"Request" forState: UIControlStateNormal];
    _requestBtn.enabled = NO;
    
    [self.view addSubview: _requestBtn];
}

-(void)textFieldDidChange
{
    std::string username = ToStdString(_textField.text);
    [Service2::Instance() Find: username completionHandler: ^(UserWrapper* w){
        _transferBtn.enabled = _requestBtn.enabled = !w.data.empty();
        
        _currentUser = w.data;
    }];
}

-(void)searchAction
{
    if(!_currentUser.empty())
    {
        TransferViewController* vc = [[TransferViewController alloc] init];
        [vc setMode: TransferViewMode::Transfer];
        [vc setUser: _currentUser];
        [self.navigationController pushViewController: vc animated: YES];
    }
}

-(void)requestAction
{
    if(!_currentUser.empty())
    {
        TransferViewController* vc = [[TransferViewController alloc] init];
        [vc setMode: TransferViewMode::CreateRequest];
        [vc setUser: _currentUser];
        [self.navigationController pushViewController: vc animated: YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if(_transferBtn.enabled)
    {
        [self searchAction];
        return YES;
    }
    return NO;
}

-(void)dismissKeyboard
{
    [_textField resignFirstResponder];
}

@end
