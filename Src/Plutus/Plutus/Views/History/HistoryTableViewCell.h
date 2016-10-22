//
//  HistoryTableViewCell.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "PaymentRecord.h"

@interface HistoryTableViewCell : UITableViewCell

@property UIImageView* side;
@property UILabel* name;
@property UILabel* username;
@property UILabel* amount;

-(void)SetData:(const PaymentRecord&)data;

@property PaymentRecord data;

@end
