//
//  PaymentRequest.cpp
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "PaymentRequest.h"

namespace common
{

PaymentRequest::PaymentRequest()
    : _requestId(0)
    , _receiver(0)
    , _sender(0)
    , _amount(0)
{}

PaymentRequest::PaymentRequest(Id requestId,
                                   User::Id receiver,
                                   User::Id sender,
                                   PriceType   amount)
    : _requestId(requestId)
    , _receiver(receiver)
    , _sender(sender)
    , _amount(amount)
{}

}
