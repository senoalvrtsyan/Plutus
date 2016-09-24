//
//  Payment.cpp
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Payment.h"

namespace common
{

Payment::Payment()
{}
    
Payment::Payment(Id paymentId,
            Account sender,
            Account receiver,
            PriceType amount)
    : _paymentId(paymentId)
    , _sender(sender)
    , _receiver(receiver)
    , _amount(amount)
{}

}
