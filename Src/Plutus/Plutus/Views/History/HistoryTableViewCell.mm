//
//  HistoryTableViewCell.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HistoryTableViewCell.h"

#import "Utils.h"
#import "Theme.h"
#import "Constants.h"

#include "Account.h"
#include "Service.h"

@interface HistoryTableViewCell ()

@end

@implementation HistoryTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
    }
    return self;
}

-(void)createControls
{
    //                          datetime
    //
    // myaccount   >>   user - @username
    // account_type         user_account
    //
    //                            amount
    
    static const int viewW = [[UIScreen mainScreen] bounds].size.width;
    
    // Create datetime label.
    static const int datetimeLabelW = viewW - 20;
    static const int datetimeLabelH = 20;
    static const int datetimeLabelX = viewW - datetimeLabelW - 8;
    static const int datetimeLabelY = 8;
    UILabel* datetimeLabel = [[UILabel alloc] initWithFrame: CGRectMake(datetimeLabelX, datetimeLabelY, datetimeLabelW, datetimeLabelH)];
    datetimeLabel.textAlignment = NSTextAlignmentRight;
    datetimeLabel.text = @"18/09/2016 13:00:45"; // TODO
    datetimeLabel.font = [UIFont systemFontOfSize: datetimeLabel.font.pointSize - 6];
    datetimeLabel.textColor = theme::grayColor();
    
    [self addSubview: datetimeLabel];
    
    // Take care of my account.
    self.textLabel.textColor = theme::textColor();
    
    // Take care of my account type.
    self.detailTextLabel.textColor = theme::grayColor();
    self.detailTextLabel.font = [UIFont systemFontOfSize: datetimeLabel.font.pointSize - 1];
    
    // Take care of the side.
    _side = [[UIImageView alloc] init];
    [self addSubview: _side];
    
    // Take care of username
    _username = [[UILabel alloc] init];
    _username.textAlignment = NSTextAlignmentRight;
    _username.textColor = theme::grayColor();
    _username.font = [UIFont systemFontOfSize: _username.font.pointSize - 1];
    
    [self addSubview: _username];
    
    // Take care of user account.
    _name = [[UILabel alloc] init];
    _name.textColor = self.textLabel.textColor;
    _name.font = self.textLabel.font;
    _name.textAlignment = NSTextAlignmentRight;
    _name.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview: _name];
    
    // Take care of amount.
    _amount = [[UILabel alloc] init];
    _amount.textColor = _data._sent ? theme::grayColor() : theme::brandColor4();
    _amount.font = [UIFont boldSystemFontOfSize: _amount.font.pointSize + 2];
    _amount.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview: _amount];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    static const int viewW = [[UIScreen mainScreen] bounds].size.width;
    static const int myAccW = viewW / 2;
    static const int myAccH = 20;
    static const int myAccTypeH = 10;
    static const int myAccTypeY = historyCellH - myAccTypeH - 5;
    static const int myAccX = 10;
    static const int myAccY = myAccTypeY - myAccH - 4;
    
    // Take care of the side.
    static const int sideX = 4;
    static const int sideY = 4;
    [_side setFrame: CGRectMake(sideX, sideY, arrowS, arrowS)];
    
    // Take care of amount.
    [_amount setFrame: CGRectMake(sideX + arrowS - 12, 0, viewW / 2, controlH)];

    // Take care of my account type.
    [self.detailTextLabel setFrame: CGRectMake(myAccX, myAccTypeY, myAccW, myAccTypeH)];
    
    // Take care of my account.
    [self.textLabel setFrame: CGRectMake(myAccX, myAccY, myAccW, myAccH)];
    
    // Take care of username.
    static const int usernameX = viewW - myAccW - 10;
    static const int usernameY = myAccY - controlH + 10;
    [_username setFrame: CGRectMake(usernameX, usernameY, myAccW, controlH)];
    
    // Take care of name.
    static const int userAccountX = viewW - myAccW - 10;
    [_name setFrame: CGRectMake(userAccountX, myAccY, myAccW, myAccH)];
}

-(void)SetData:(const PaymentRecord&)data
{
    _data = data;

    // Take care of side.
    if(_data._sent)
    {
        _side.image = [UIImage imageNamed: @"arrow-right2_red"];
    }
    else
    {
        _side.image = [UIImage imageNamed: @"arrow-left"];
    }
    
    // Take care of account.
    self.textLabel.text = ToNSString(_data._accountId);
    
    // Take care of account type.
    self.detailTextLabel.text = ToNSString(ToStdString(_data._accountType));
    
    // Take care of username.
    NSString* un = @"@";
    _username.text = [un stringByAppendingString: ToNSString(_data._username)];
    
    _name.text = ToNSString(_data._name);
    
    _amount.text = ToCurrencyNSString(ToNSString(ToStdString(_data._amount)));
}

@end
