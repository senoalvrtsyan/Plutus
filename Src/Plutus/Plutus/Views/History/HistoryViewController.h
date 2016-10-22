//
//  HistoryViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "PaymentRecord.h"

#import "CommonViewController.h"

@interface HistoryViewController : CommonViewController
    <UITableViewDataSource, UITableViewDelegate>

@property UITableView* tableView;

@property bool sentMode;
@property PaymentRecords sentPayments;
@property PaymentRecords receivedPayments;

@end
