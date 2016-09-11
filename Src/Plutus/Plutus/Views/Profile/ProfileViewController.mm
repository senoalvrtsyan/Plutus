//
//  ProfileViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "ProfileViewController.h"

#include "Utils.h"
#include "Theme.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createControls
{
    static const int viewW = self.view.frame.size.width;
    static const int controlH = 40;
    static const int logoS = 70;
    
    // Take care of the logo.
    static const int logoY = 70;
    static const int logoX = (viewW - logoS) / 2; // Centered
    UIImageView* logo = [[UIImageView alloc] initWithFrame: CGRectMake(logoX, logoY, logoS, logoS)];
    logo.image = [UIImage imageNamed: @"moneybag_256"];
    
    [self.view addSubview: logo];
    
    // Take care of ful name.
    static const int nameW = viewW - 80;
    static const int nameX = (viewW - nameW) / 2; // Centered;;
    static const int nameY = logoY + logoS + 10;
    UILabel* name = [[UILabel alloc] initWithFrame: CGRectMake(nameX, nameY, nameW, controlH)];
    name.text = @"Ken Block";
    name.textColor = theme::textColor();
    name.font = [UIFont boldSystemFontOfSize: name.font.pointSize];
    name.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: name];
    
    // Take care of username.
    static const int usernameW = viewW - 80;
    static const int usernameX = (viewW - nameW) / 2; // Centered;
    static const int usernameY = nameY + 20;
    UILabel* username = [[UILabel alloc] initWithFrame: CGRectMake(usernameX, usernameY, usernameW, controlH)];
    username.text = @"@ken";
    username.textColor = theme::lightGrayColor();
    username.font = [UIFont systemFontOfSize: name.font.pointSize - 2]; // A bit smaller font
    username.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: username];

    // Take care of debit account.
    static const int debitLabelW = viewW - 80;
    static const int debitLabelX = 20;
    static const int debitLabelY = usernameY + 90;
    UILabel* debitLabel = [[UILabel alloc] initWithFrame: CGRectMake(debitLabelX, debitLabelY, debitLabelW, controlH)];
    debitLabel.text = @"Debit";
    debitLabel.textColor = theme::grayColor();
    debitLabel.font = [UIFont systemFontOfSize: name.font.pointSize]; // A bit big.
    
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
    UILabel* debitBalance = [[UILabel alloc] initWithFrame: CGRectMake(debitBalanceX, debitBalanceY, debitBalanceW, controlH)];
    debitBalance.text = @"78,500.00 AMD";
    debitBalance.textColor = theme::brandColor4();
    debitBalance.font = [UIFont boldSystemFontOfSize: name.font.pointSize + 12];
    debitBalance.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: debitBalance];
    
    // Take care of credit account.
    static const int creditLabelY = debitBalanceY + 80;
    UILabel* creditLabel = [[UILabel alloc] initWithFrame: CGRectMake(debitLabelX, creditLabelY, debitLabelW, controlH)];
    creditLabel.text = @"Credit";
    creditLabel.textColor = theme::grayColor();
    creditLabel.font = [UIFont systemFontOfSize: name.font.pointSize]; // A bit big.
    
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
    UILabel* creditLimit = [[UILabel alloc] initWithFrame: CGRectMake(debitNumberX, creditLimitY, debitBalanceW, controlH)];
    creditLimit.text = @"Limit: 400,000.00 AMD";
    creditLimit.textColor = theme::grayColor();
    creditLimit.font = [UIFont systemFontOfSize: name.font.pointSize - 7];
    creditLimit.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview: creditLimit];
    
    // Take care of credit balance.
    static const int creditBalanceY = creditLabelY + 55;
    UILabel* creditBalance = [[UILabel alloc] initWithFrame: CGRectMake(debitBalanceX, creditBalanceY, debitBalanceW, controlH)];
    creditBalance.text = @"250,400.00 AMD";
    creditBalance.textColor = theme::brandColor4();
    creditBalance.font = [UIFont boldSystemFontOfSize: name.font.pointSize + 12];
    creditBalance.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: creditBalance];
}

@end
