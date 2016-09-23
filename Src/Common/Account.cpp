//
//  Account.cpp
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Account.h"

namespace common
{

Account::Account()
{}
    
Account::Account(Id accountId,
                     User::Id userId,
                     PriceType balance,
                     Type type,
                     PriceType limit)
    : _accountId(accountId)
    , _userId(userId)
    , _balance(balance)
    , _type(type)
    , _limit(limit)
{}

bool operator==(const Account& o1, const Account& o2)
{
    return o1._accountId == o2._accountId;
}

}
