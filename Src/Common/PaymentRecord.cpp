//
//  PaymentRecord.cpp
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "PaymentRecord.h"

namespace common
{

PaymentRecord::PaymentRecord()
{}

PaymentRecord::PaymentRecord(Account::Id accountId,
                             Account::Type accountType,
                  std::string name,
                  std::string username,
                  PriceType amount,
                  bool sent)
    : _accountId(accountId)
    , _accountType(accountType)
    , _name(name)
    , _username(username)
    , _amount(amount)
    , _sent(sent)
{}

}
