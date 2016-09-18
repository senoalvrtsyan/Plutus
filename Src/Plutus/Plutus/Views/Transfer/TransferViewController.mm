//
//  TransferViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "TransferViewController.h"

#import "Utils.h"
#import "Theme.h"

@interface TransferViewController ()

@end

@implementation TransferViewController

namespace
{
    const int controlH = 40;
}

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
    static const int logoS = 70;

    static const int logoY = 90;
    static const int nameW = viewW - 80;
    static const int usernameW = viewW - 80;
    static const int nameY = logoY + logoS;
    static const int usernameY = nameY + 20;
    
    // First avatar.
    {
        // Take care of the logo.
        static const int logoX = viewW / 5 - logoS / 2;
        UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
        logo.image = [UIImage imageNamed: @"moneybag_256"];
        
        [self.view addSubview: logo];
        
        // Take care of full name.
        static const int nameX = viewW / 5 - nameW / 2;
        UILabel* name = [[UILabel alloc] initWithFrame: CGRectMake(nameX, nameY, nameW, controlH)];
        name.text = @"Ken Block";
        name.textColor = theme::textColor();
        name.font = [UIFont boldSystemFontOfSize: name.font.pointSize];
        name.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: name];
        
        // Take care of username.
        static const int usernameX = viewW / 5 - usernameW / 2;
        UILabel* username = [[UILabel alloc] initWithFrame: CGRectMake(usernameX, usernameY, usernameW, controlH)];
        username.text = @"@ken";
        username.textColor = theme::lightGrayColor();
        username.font = [UIFont systemFontOfSize: name.font.pointSize - 2]; // A bit smaller font
        username.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: username];
    }
    
    // Second avatar.
    {
        // Take care of the logo.
        static const int logoX = 4 * viewW / 5 - logoS / 2;
        UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
        logo.image = [UIImage imageNamed: @"moneybag_gray_256"];
        
        [self.view addSubview: logo];
        
        // Take care of full name.
        static const int nameX = 4 * viewW / 5 - nameW / 2;
        UILabel* name = [[UILabel alloc] initWithFrame: CGRectMake(nameX, nameY, nameW, controlH)];
        name.text = @"John Snow";
        name.textColor = theme::textColor();
        name.font = [UIFont boldSystemFontOfSize: name.font.pointSize];
        name.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: name];
        
        // Take care of username.
        static const int usernameX = 4 * viewW / 5 - usernameW / 2;
        UILabel* username = [[UILabel alloc] initWithFrame: CGRectMake(usernameX, usernameY, usernameW, controlH)];
        username.text = @"@johnny";
        username.textColor = theme::lightGrayColor();
        username.font = [UIFont systemFontOfSize: name.font.pointSize - 2]; // A bit smaller font
        username.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview: username];
    }
    
    // Animated arrows.
    {
        static const int arrowS = 30;
        static const int arrowY = nameY - 20;
        
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
    
    static const int accountY = amountY + controlH + 15;
    // Choose the account.
    {
        _account = [[UIButton alloc] initWithFrame: CGRectMake(amountX, accountY, amountW, controlH)];
        [_account addTarget: self action: @selector(accountAction) forControlEvents: UIControlEventTouchUpInside];
        [_account setTitleColor: theme::placeholderTextColor() forState: UIControlStateNormal];
        [_account setTitleColor: theme::whiteColor() forState: UIControlStateHighlighted];
        [_account setBackgroundImage: imageWithColor(theme::grayColor()) forState: UIControlStateHighlighted];
        [_account setTitle: @"Choose account" forState: UIControlStateNormal];
        // Border style.
        _account.layer.cornerRadius = 0.0f;
        _account.layer.masksToBounds = YES;
        _account.layer.borderColor = [theme::brandColor4() CGColor];
        _account.layer.borderWidth = 1.0f;
        
        // [self.view addSubview: _account];
        
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
    
    if(row == 0)
    {
        title = @"012458944033";
    }
    else if(row == 1)
    {
        title = @"243956029876";
    }
    
    NSAttributedString* attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: theme::textColor()}];
    
    return attString;
}

-(void)setAcc:(NSString*)acc
{
    if([_account.titleLabel.text isEqualToString: @"Choose account"])
    {
        [_account setTitleColor: theme::textColor() forState: UIControlStateNormal];
    }
    
    [_account setTitle: acc forState: UIControlStateNormal];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row == 0)
    {
        [self setAcc: @"012458944033"];
    }
    else if(row == 1)
    {
        [self setAcc: @"243956029876"];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return controlH;
}

-(void)transferAction
{
    
}

@end
