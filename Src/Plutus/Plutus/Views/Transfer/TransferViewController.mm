//
//  TransferViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "TransferViewController.h"

#include <sstream>

#import "Constants.h"
#import "Utils.h"
#import "Theme.h"

#include "Service.h"

@interface TransferViewController ()

@end

@implementation TransferViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Transfer";
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer: tap];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    //[_amount becomeFirstResponder];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval: 0.33
                                              target: self
                                            selector: @selector(animateArrows)
                                            userInfo: nil repeats: YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    
    [_timer invalidate];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard
{
    [_amount resignFirstResponder];
}

-(void)animateArrows
{
    static int index = 0;
    
    switch(index)
    {
        case 0:
            _arrow1.hidden = YES;
            _arrow2.hidden = YES;
            _arrow3.hidden = YES;
            break;
            
        case 1:
            _arrow1.hidden = NO;
            _arrow2.hidden = YES;
            _arrow2.hidden = YES;
            break;
            
        case 2:
            _arrow1.hidden = NO;
            _arrow2.hidden = NO;
            _arrow3.hidden = YES;
            break;
            
        case 3:
            _arrow1.hidden = NO;
            _arrow2.hidden = NO;
            _arrow3.hidden = NO;
            break;
            
        default:
            break;
    }
    
    index = (index + 1) % 4;
}

-(void)createControls
{
    static const int viewW = self.view.frame.size.width;

    static const int logoY = 90;
    static const int nameW = viewW / 2 - 12;
    static const int usernameW = viewW - 80;
    static const int nameY = logoY + logoS;
    static const int usernameY = nameY + 20;
    
    // First avatar.
    {
        // Take care of full name.
        static const int nameX = 4;
        UILabel* name = [[UILabel alloc] initWithFrame: CGRectMake(nameX, nameY, nameW, controlH)];
        name.text = ToNSString(Service::Instance().GetUser()._name);
        name.textColor = theme::textColor();
        name.font = [UIFont boldSystemFontOfSize: name.font.pointSize - 3];
        name.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: name];
        
        // Take care of the logo.
        static const int logoX = nameX + nameW / 2 - logoS / 2;
        UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
        logo.image = [UIImage imageNamed: @"moneybag_256"];
        
        [self.view addSubview: logo];
        
        // Take care of username.
        static const int usernameX = nameX + nameW / 2 - usernameW / 2;
        UILabel* username = [[UILabel alloc] initWithFrame: CGRectMake(usernameX, usernameY, usernameW, controlH)];
        username.text = ToNSString(atUsername(Service::Instance().GetUser()._username));
        username.textColor = theme::lightGrayColor();
        username.font = [UIFont systemFontOfSize: name.font.pointSize - 2]; // A bit smaller font
        username.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: username];
    }
    
    // Second avatar.
    {
        // Take care of full name.
        static const int nameX = viewW - nameW - 4;
        UILabel* name = [[UILabel alloc] initWithFrame: CGRectMake(nameX, nameY, nameW, controlH)];
        name.text = ToNSString(_user._name);
        name.textColor = theme::textColor();
        name.font = [UIFont boldSystemFontOfSize: name.font.pointSize - 3];
        name.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: name];
        
        // Take care of the logo.
        static const int logoX = nameX + nameW / 2 - logoS / 2;
        UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
        logo.image = [UIImage imageNamed: @"moneybag_gray_256"];
        
        [self.view addSubview: logo];
        
        // Take care of username.
        static const int usernameX = nameX + nameW / 2 - usernameW / 2;
        UILabel* username = [[UILabel alloc] initWithFrame: CGRectMake(usernameX, usernameY, usernameW, controlH)];
        username.text = ToNSString(atUsername(_user._username));
        username.textColor = theme::lightGrayColor();
        username.font = [UIFont systemFontOfSize: name.font.pointSize - 2]; // A bit smaller font
        username.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: username];
    }
    
    // Animated arrows.
    {
        static const int arrowY = logoY + logoS / 2 - arrowS / 2;
        
        static const int arrow2X = (viewW - arrowS) / 2;
        _arrow2 = [[UIImageView alloc] initWithFrame: CGRectMake(arrow2X, arrowY, arrowS, arrowS)];
        _arrow2.image = [UIImage imageNamed: @"arrow-right2"];
        _arrow2.hidden = YES;
        
        [self.view addSubview: _arrow2];
        
        static const int arrow1X = arrow2X - arrowS;
        _arrow1 = [[UIImageView alloc] initWithFrame: CGRectMake(arrow1X, arrowY, arrowS, arrowS)];
        _arrow1.image = [UIImage imageNamed: @"arrow-right2"];
        _arrow1.hidden = YES;
        
        [self.view addSubview: _arrow1];
        
        static const int arrow3X = arrow2X + arrowS;
        _arrow3 = [[UIImageView alloc] initWithFrame: CGRectMake(arrow3X, arrowY, arrowS, arrowS)];
        _arrow3.image = [UIImage imageNamed: @"arrow-right2"];
        _arrow3.hidden = YES;
        
        [self.view addSubview: _arrow3];
    }
    
    static const int amountY = usernameY + controlH + 20;
    static const int amountW = viewW - 80;
    static const int amountX = (viewW - amountW) / 2;
    // Ammount
    {
        _amount = [[UITextField alloc] initWithFrame: CGRectMake(amountX, amountY, amountW, controlH)];
        theme::applyStyle(_amount);
        _amount.textAlignment = NSTextAlignmentCenter;
        _amount.placeholder = @"Amount to transfer";
        _amount.keyboardType = UIKeyboardTypeDecimalPad;
        _amount.font = [UIFont boldSystemFontOfSize: _amount.font.pointSize];
        _amount.delegate = self;
        
        // Add done button for the keyboard.
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, viewW, controlH)];
        UIBarButtonItem* spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]initWithTitle: @"Done" style: UIBarButtonItemStyleDone target: self action: @selector(doneWithNumberPad)];
        // Set button color.
        [doneButton setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
                                              theme::brandColor4(), NSForegroundColorAttributeName, nil]
                              forState: UIControlStateNormal];
        
        numberToolbar.items = @[spacer, doneButton];
        [numberToolbar sizeToFit];
        _amount.inputAccessoryView = numberToolbar;
        
        [self.view addSubview: _amount];
    }
    
    // Choose the account.
    {
        // Add picker.
        static const int pickerH = 3 * controlH;
        static const int pickerY = amountY + controlH - 1;
        _picker = [[UIPickerView alloc] initWithFrame: CGRectMake(amountX, pickerY, amountW, pickerH)];
        _picker.delegate = self;
        _picker.dataSource = self;
        // border
        _picker.layer.borderColor = theme::brandColor4().CGColor;
        _picker.layer.borderWidth = 1;
        
        [self.view addSubview: _picker];
    }
    
    // Approve button.
    {
        // Push transfer button to bottom.
        static const int transferY = self.tabBarController.tabBar.frame.origin.y - controlH - 15;
        UIButton* transfer = [[UIButton alloc] initWithFrame: CGRectMake(amountX, transferY, amountW, controlH)];
        [transfer addTarget: self action: @selector(transferAction) forControlEvents: UIControlEventTouchUpInside];
        transfer.backgroundColor = theme::brandColor4();
        [transfer setBackgroundImage: imageWithColor(theme::brandColor5()) forState: UIControlStateHighlighted];
        [transfer setTitle: @"Transfer" forState: UIControlStateNormal];
        
        [self.view addSubview: transfer];
    }
}

-(void)doneWithNumberPad
{
    [_amount resignFirstResponder];
    
    _amount.text = ToCurrencyNSString(_amount.text);
}

-(void)accountAction
{
    [_amount resignFirstResponder];
    
    _picker.hidden = NO;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

-(NSAttributedString*)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* title = @"";
    
    const auto& accs = Service::Instance().GetAccounts();
    title = ToNSString(ToStdString(accs[row]));
    
    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: theme::textColor()}];
    
    return attString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //const auto& accs = Service::Instance().GetAccounts();
    //accs[row]._accountId;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return controlH;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    textField.text = ToNSString(removeCurrencyFormat(ToStdString(textField.text)));
}

-(void)SetUser:(User)user
{
    _user = user;
}

-(void)transferAction
{
    if([_amount.text length] == 0)
    {
        return;
    }
    
    std::ostringstream oss;
    oss << "Transfering " << ToStdString(_amount.text) << " from ";
    // Add account type
    const int row = [_picker selectedRowInComponent: 0];
    const Account selectedAcc = Service::Instance().GetAccounts()[row];
    oss <<  ToStdString(selectedAcc._type);
    oss << ": ";
    // Add account number.
    oss << selectedAcc._accountId;
    oss << " to " << _user._name;
    
    UIAlertController* alert = [UIAlertController
                                 alertControllerWithTitle:@"Transfer confirmation"
                                 message: ToNSString(oss.str())
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle: @"Cancel"
                               style: UIAlertActionStyleDefault
                               handler: ^(UIAlertAction* action) {
                                   //Handle no, thanks button
                               }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle: self.title
                                style: UIAlertActionStyleDefault
                                handler: ^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                    // TODO: check balance on transfer.
                                    if(Service::Instance().MakePayment(selectedAcc, _user, ToPrice(removeCurrencyFormat(ToStdString(_amount.text)))))
                                    {
                                        _amount.text = @"";
                                        // msgbox::inform ok
                                        AlertOk(self, @"Success", @"Your payment was a success.");
                                    }
                                    else
                                    {
                                        AlertOk(self, @"Failure", @"Your payment was a failure.");
                                    }
                                }];

    [alert addAction:noButton];
    [alert addAction:yesButton];
    
    [self presentViewController: alert animated: YES completion: nil];
    
    // iOS bug, need to do this here.
    [alert.view setTintColor: theme::brandColor4()];
}

@end
