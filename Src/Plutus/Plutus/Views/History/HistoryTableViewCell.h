//
//  HistoryTableViewCell.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

-(void)setPayment;

@property UIImageView* side;
@property UILabel* username;
@property UILabel* userAccount;
@property UILabel* userAccountType;
@property UILabel* amount;

@end