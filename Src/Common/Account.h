//
//  Account.h
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

namespace common
{

class Account
{
public:
    typedef std::string Id;
    
    enum Type
    {
        Undefined = 0,
        Debit = 1,
        Credit = 2
    };

    Account();
    
    Account(Id accountId,
            User::Id userId,
            PriceType balance = 0,
            Type type = Debit,
            PriceType limit = 0);
    
    bool empty() const { return _accountId.empty(); };
    
    Id _accountId;
    User::Id _userId;
    Type _type;
    PriceType _balance;
    PriceType _limit;
};

bool operator==(const Account& o1, const Account& o2);
    
typedef std::vector<Account> Accounts;
typedef std::map<User::Id, Accounts> AccountsMap;

}
using namespace common;