//
//  TransferViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonViewController.h"

#include "User.h"
#include "Account.h"

struct TransferViewMode
{
    enum Value
    {
        Undefined = 0,
        Transfer,           // User wants to transfer money for someone else.
        CreateRequest,      // User creates a request of payment for someone.
        RequestPopup,       // User got a popup request to make a payment
        Count
    };
};

@interface TransferViewController : CommonViewController
    <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

-(void)SetUser:(User)user;
-(void)SetAmount:(PriceType)amount;

@property UIImageView* arrow1;
@property UIImageView* arrow2;
@property UIImageView* arrow3;

@property UITextField* amountTextField;

@property UIPickerView* picker;

@property NSTimer* timer;

@property User user;
@property PriceType amount;

@property Accounts accounts;

// Descrives the mode of view, one of three, see the enum.
@property TransferViewMode::Value mode;

@end
