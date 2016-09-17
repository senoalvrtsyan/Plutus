//
//  TransferViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonViewController.h"

@interface TransferViewController : CommonViewController
    <UIPickerViewDelegate, UIPickerViewDataSource>

@property UIImageView* arrow1;
@property UIImageView* arrow2;
@property UIImageView* arrow3;

@property UITextField* amount;

@property UIButton* account;
@property UIPickerView* picker;

@property NSTimer* timer;

@end
