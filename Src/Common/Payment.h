//
//  Payment.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#pragma once

#include <string>
#include <vector>
#include <map>

#include "Types.h"
#include "User.h"
#include "Account.h"

namespace common
{
    
class Payment
{
public:
    typedef IdType Id;

    Payment();
    Payment(Id paymentId,
            Account sender,
            Account receiver,
            PriceType amount);
    
    bool empty() const { return _paymentId == 0; };
    
    Id _paymentId;
    Account _sender;
    Account _receiver;
    PriceType _amount;
    //datetime _datetime;
};

typedef std::vector<Payment> Payments;

}
using namespace common;