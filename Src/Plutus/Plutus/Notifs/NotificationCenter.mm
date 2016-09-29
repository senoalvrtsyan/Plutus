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
    auto r = rand() % 4 + 1;
    
    if(r % 4 == 0)
    {
        TransferViewController* vc = [[TransferViewController alloc] init];
        [vc setUser: Service::Instance().Find("seno")];
        [vc SetAmount: 145000];
        // [_parent presentViewController: vc animated: YES completion: nil];
    }
}

@end
