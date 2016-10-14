//
//  ProfileViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NotificationCenter.h"

@interface ProfileViewController : UIViewController

@property UILabel* debitBalance;
@property UILabel* debitNumber;

@property UILabel* creditBalance;
@property UILabel* creditLimit;

@property NotificationCenter* notificationCenter;

@end
