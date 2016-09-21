//
//  ProfileViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "ProfileViewController.h"

#import "Constants.h"
#import "Utils.h"
#import "Theme.h"

#include "Service.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Balance";
    
    // Set background color of the view.
    self.view.backgroundColor = theme::whiteColor();
    
    // Create the view contorls.
    [self createControls];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    /*
    [self initBalanceAnimated: _debitBalance withValue: 64000.00];
    [self initBalanceAnimated: _creditBalance withValue: 256000.00];
    [self initBalanceAnimated: _creditLimit withValue: 400000.00];
     */
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createControls
{
    static const int viewW = self.view.frame.size.width;
    
    // Take care of the logo.
    static const int logoY = 100;
    static const int logoX = (viewW - logoS) / 2; // Centered
    UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
    logo.image = [UIImage imageNamed: @"moneybag_256"];
    
    [self.view addSubview: logo];
    
    // Take care of ful name.
    static const int nameW = viewW - 80;
    static const int nameX = (viewW - nameW) / 2; // Centered;;
    static const int nameY = logoY + logoS - 10;
    UILabel* name = [[UILabel alloc] initWithFrame: CGRectMake(nameX, nameY, nameW, controlH)];
    name.text = ToNSString(Service::Instance().GetUser()._name);
    name.textColor = theme::textColor();
    name.font = [UIFont boldSystemFontOfSize: name.font.pointSize];
    name.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: name];
    
    // Take care of username.
    static const int usernameW = viewW - 80;
    static const int usernameX = (viewW - nameW) / 2; // Centered;
    static const int usernameY = nameY + 20;
    UILabel* username = [[UILabel alloc] initWithFrame: CGRectMake(usernameX, usernameY, usernameW, controlH)];
    username.text = @"@";
    username.text = [username.text stringByAppendingString: ToNSString(Service::Instance().GetUser()._username)];
    username.textColor = theme::lightGrayColor();
    username.font = [UIFont systemFontOfSize: name.font.pointSize - 2]; // A bit smaller font
    username.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: username];

    // Take care of debit account.
    static const int debitLabelW = viewW - 80;
    static const int debitLabelX = 20;
    static const int debitLabelY = usernameY + 90;
    static const int separatorDist = 10;
    
    // Add a separator line.
    [self addSeparatorLine: debitLabelY - separatorDist];
    
    UILabel* debitLabel = [[UILabel alloc] initWithFrame: CGRectMake(debitLabelX, debitLabelY, debitLabelW, controlH)];
    debitLabel.text = @"Debit";
    debitLabel.textColor = theme::grayColor();
    debitLabel.font = [UIFont systemFontOfSize: name.font.pointSize - 3]; // A bit big.
    
    [self.view addSubview: debitLabel];
    
    // Take care of debit account number.
    static const int debitNumberW = viewW - 80;
    static const int debitNumberX = viewW - debitNumberW - 20;
    static const int debitNumberY = debitLabelY;
    UILabel* debitNumber = [[UILabel alloc] initWithFrame: CGRectMake(debitNumberX, debitNumberY, debitNumberW, controlH)];
    debitNumber.text = @"777100547001";
    debitNumber.textColor = theme::textColor();
    debitNumber.font = [UIFont systemFontOfSize: name.font.pointSize]; // A bit big.
    debitNumber.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview: debitNumber];
    
    // Take care of debit balance.
    static const int debitBalanceW = viewW - 80;
    static const int debitBalanceX = (viewW - debitBalanceW) / 2; // Centered
    static const int debitBalanceY = debitNumberY + 50;
    _debitBalance = [[UILabel alloc] initWithFrame: CGRectMake(debitBalanceX, debitBalanceY, debitBalanceW, controlH)];
    _debitBalance.text = @"54,320.00 AMD";
    _debitBalance.textColor = theme::brandColor4();
    _debitBalance.font = [UIFont boldSystemFontOfSize: name.font.pointSize + 12];
    _debitBalance.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: _debitBalance];
    
    
    // Take care of credit account.
    static const int creditLabelY = debitBalanceY + 80;
    
    // Add a separator line.
    [self addSeparatorLine: creditLabelY - separatorDist];
    
    UILabel* creditLabel = [[UILabel alloc] initWithFrame: CGRectMake(debitLabelX, creditLabelY, debitLabelW, controlH)];
    creditLabel.text = @"Credit";
    creditLabel.textColor = theme::grayColor();
    creditLabel.font = debitLabel.font;
    
    [self.view addSubview: creditLabel];
    
    // Take care of debit account number.
    UILabel* creditNumber = [[UILabel alloc] initWithFrame: CGRectMake(debitNumberX, creditLabelY, debitNumberW, controlH)];
    creditNumber.text = @"555200547001";
    creditNumber.textColor = theme::textColor();
    creditNumber.font = [UIFont systemFontOfSize: name.font.pointSize];
    creditNumber.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview: creditNumber];
    
    // Take care of credit limit.
    static const int creditLimitY = creditLabelY + 18;
    _creditLimit = [[UILabel alloc] initWithFrame: CGRectMake(debitNumberX, creditLimitY, debitBalanceW, controlH)];
    _creditLimit.text = @"Limit: 400,000.00 AMD";
    _creditLimit.textColor = theme::grayColor();
    _creditLimit.font = [UIFont systemFontOfSize: name.font.pointSize - 7];
    _creditLimit.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview: _creditLimit];
    
    // Take care of credit balance.
    static const int creditBalanceY = creditLabelY + 55;
    _creditBalance = [[UILabel alloc] initWithFrame: CGRectMake(debitBalanceX, creditBalanceY, debitBalanceW, controlH)];
    _creditBalance.text = @"276,000.00 AMD";
    _creditBalance.textColor = theme::brandColor4();
    _creditBalance.font = [UIFont boldSystemFontOfSize: name.font.pointSize + 12];
    _creditBalance.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: _creditBalance];
    
    // Add settings button to navigation bar
    {
        UIImage* gear = [UIImage imageNamed:@"cogs"];
        CGRect frameimg = CGRectMake(0, 0, 22, 22);
        UIButton* settingsButton = [[UIButton alloc] initWithFrame: frameimg];
        [settingsButton setBackgroundImage: gear forState: UIControlStateNormal];
        [settingsButton addTarget: self action: @selector(settingsAction)
                 forControlEvents: UIControlEventTouchUpInside];
        
        UIBarButtonItem* settingsButtonItem = [[UIBarButtonItem alloc] initWithCustomView: settingsButton];
        self.navigationItem.leftBarButtonItem = settingsButtonItem;
    }
}

-(void)settingsAction
{
    
}

-(void)addSeparatorLine:(int)y
{
    static const int viewW = self.view.frame.size.width;
    
    const int w = viewW - 20;
    const int x = (viewW - w) / 2;
    UIView* separatorLine = [[UIView alloc] initWithFrame: CGRectMake(x, y, w, 1)];

    // Border style.
    separatorLine.layer.cornerRadius = 0.0f;
    separatorLine.layer.masksToBounds = YES;
    separatorLine.layer.borderColor = [theme::lightGrayColor() CGColor];
    separatorLine.layer.borderWidth = 1.0f;
    
    [self.view addSubview: separatorLine];
}

-(void)initBalanceAnimated:(UILabel*)textField withValue:(double)value
{
    double val = [textField.text doubleValue];
    
    const int step = value / 200;
    
    if(val < value)
    {
        NSNumber* dblNum = [NSNumber numberWithDouble: val + step];
        val = [dblNum doubleValue];

        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.locale = [NSLocale currentLocale];// this ensures the right separator behavior
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.usesGroupingSeparator = YES;
        [numberFormatter setMaximumFractionDigits: 2];
        [numberFormatter setMinimumFractionDigits: 2];
        
        textField.text = [dblNum stringValue];// [numberFormatter stringFromNumber: dblNum];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initBalanceAnimated: textField withValue: value];
        });
    }
    else
    {
        textField.text = [[NSNumber numberWithDouble: value] stringValue];
    }
}

@end
