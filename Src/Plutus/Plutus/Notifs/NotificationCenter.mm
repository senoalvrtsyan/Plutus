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
    const auto userId = [Service::Instance() GetUser]._userId;
    
    [Service::Instance() GetPaymentRequest: userId
        completionHandler: ^(PaymentRequestWrapper* prw) {
            if(!prw.data.empty())
            {
                [Service::Instance() FindWithId: prw.data._receiver completionHandler:^(UserWrapper* uw) {
                     TransferViewController* vc = [[TransferViewController alloc] init];
                     [vc setMode: TransferViewMode::RequestPopup];
                     [vc setUser: uw.data];
                     [vc SetAmount: prw.data._amount];
                     [vc setRequestId: prw.data._requestId];
                     [_parent presentViewController: vc animated: YES completion: nil];
                }];
            }
    }];
}

@end

