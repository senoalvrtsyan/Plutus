//
//  PaymentRequest.h
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
    
class PaymentRequest
{
public:
    typedef IdType Id;

    PaymentRequest();
    PaymentRequest(Id requestId,
                   User::Id receiver,
                   User::Id sender,
                   PriceType   amount);
    
    bool empty() const { return _requestId == 0; };
    
    Id _requestId;
    User::Id _receiver;  // Who will recive money eventualy.
    User::Id _sender;    // Who actualy is requested to send money.
    PriceType   _amount;
};

typedef std::vector<PaymentRequest> PaymentRequests;

}
using namespace common;