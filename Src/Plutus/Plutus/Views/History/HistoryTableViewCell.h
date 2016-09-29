//
//  HistoryTableViewCell.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "Payment.h"

@interface HistoryTableViewCell : UITableViewCell

@property UIImageView* side;
@property UILabel* username;
@property UILabel* userAccount;
@property UILabel* userAccountType;
@property UILabel* amount;

@property Payment payment;

-(void)SetPayment:(const Payment&)payment;

@end
