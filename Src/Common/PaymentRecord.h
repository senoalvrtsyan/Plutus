//
//  PaymentRecord.h
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
    
class PaymentRecord
{
public:
    typedef IdType Id;

    PaymentRecord();
    PaymentRecord(Account::Id accountId,
                  Account::Type accountType,
                  std::string name,
                  std::string username,
                  PriceType amount,
                  bool sent);
    
    bool empty() const { return _accountId.empty(); };
    
    Account::Id _accountId;
    Account::Type _accountType;
    std::string _name;
    std::string _username;
    PriceType   _amount;
    bool _sent;
};

typedef std::vector<PaymentRecord> PaymentRecords;

}
using namespace common;