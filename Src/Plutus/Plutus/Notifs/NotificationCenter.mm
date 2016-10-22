//
//  NotificationCenter.m
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/29/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NotificationCenter.h"

#include <iostream>

#include "Service.h"

#import "TransferViewController.h"

@implementation NotificationCenter

-(id)init
{
    self = [super init];
    if (self)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                         target: self
                                       selector: @selector(timeout)
                                       userInfo: nil
                                        repeats: YES];
    }
    return self;
}

-(void)timeout
{
    auto payments = Service::Instance().GetPendingPayments();
    if(!payments.empty())
    {
        const auto payment = payments.front();
        
        TransferViewController* vc = [[TransferViewController alloc] init];
        [vc setMode: TransferViewMode::RequestPopup];
        [vc setUser: Service::Instance().Find(payment._receiver)];
        [vc SetAmount: payment._amount];
        [_parent presentViewController: vc animated: YES completion: nil];
    }
}

@end
