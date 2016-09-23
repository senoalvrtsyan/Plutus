//
//  Service.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Service.h"

#include <sstream>

namespace ios
{

Service& Service::Instance()
{
    static Service service;
    return service;
}

Service::Service()
{}

void Service::SetUser(const User& user)
{
    _user = user;
}
    
User& Service::GetUser()
{
    return _user;
}

Accounts Service::GetAccounts()
{
    Accounts res;
    
    auto it = _accounts.find(GetUser()._userId);
    if(it != _accounts.end())
    {
        return it->second;
    }
    
    return res;
}
    
Account Service::GetAccount(Account::Type type)
{
    auto accounts = GetAccounts();
    
    for(const auto& item : accounts)
    {
        if(item._type == type)
        {
            return item;
        }
    }
    
    return Account();
}
    
bool Service::SignUp(User& user)
{
    if(user._username.empty() ||
       user._password.empty() ||
       user._name.empty() ||
       user._email.empty())
    {
        return false;
    }
    
    // Init user id.
    user._userId = _users.size() + 1;
    
    _users.push_back(user);
    
    long max = 100100101;
    for(const auto& item : _accounts)
    {
        for(const auto& item2 : item.second)
        {
            long accId = 0;
            std::stringstream ss;
            ss << item2._accountId;
            ss >> accId;
            
            if(max < accId)
            {
                max  = accId;
            }
        }
    }

    Account::Id debitId;
    Account::Id creditId;
    
    std::stringstream ss;
    ss << max;
    ss >> debitId;
    
    std::stringstream ss2;
    ss2 << max + 1;
    ss2 >> creditId;
    
    Accounts accs;
    accs.push_back(Account(debitId, user._userId, 75000));
    accs.push_back(Account(creditId, user._userId, 140000, Account::Credit, 400000));
    
    _accounts[user._userId] = accs;
    
    // TODO: implement.
    return true;
}

bool Service::SignIn(const User& user)
{
    if(user._username.empty() || user._password.empty())
    {
        return false;
    }
    
    return true;
    
    // TODO: implement.
    for(const auto& user: _users)
    {
        if(user._name == user._name && user._password == user._password)
        {
            return true;
        }
    }

    return false;
}
    
}
