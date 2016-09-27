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
    
void Service::populateTestData()
{
    User user1(1, "Hovhannes Grigoryan", "hov", "hovgrig@gmail.com", "pwd");
    Account acc11("100100101", user1._userId, 45000, Account::Debit);
    Account acc12("100100102", user1._userId, 230000, Account::Credit, 300000);
    Accounts accs1;
    accs1.push_back(acc11);
    accs1.push_back(acc12);
    
    User user2(2, "Koriun Aslanyan", "kor", "koriun@gmail.com", "pwd");
    Account acc21("100100103", user2._userId, 104000, Account::Debit);
    Account acc22("100100104", user2._userId, 60000, Account::Credit, 500000);
    Accounts accs2;
    accs2.push_back(acc21);
    accs2.push_back(acc22);
    
    User user3(3, "Senik Alvrtyan", "seno", "senik@gmail.com", "pwd");
    Account acc31("100100105", user3._userId, 89000, Account::Debit);
    Account acc32("100100106", user3._userId, 302000, Account::Credit, 490000);
    Accounts accs3;
    accs3.push_back(acc31);
    accs3.push_back(acc32);
    
    _users.push_back(user1);
    _users.push_back(user2);
    _users.push_back(user3);
    
    _accounts[user1._userId] = accs1;
    _accounts[user2._userId] = accs2;
    _accounts[user3._userId] = accs3;
    
    Payment pay1(1, acc11, acc21, 15000);
    Payment pay2(2, acc12, acc31, 25000);
    Payment pay3(3, acc11, acc22, 5000);
    Payment pay4(4, acc21, acc31, 15000);
    Payment pay5(5, acc32, acc11, 15000);
    
    _payments.push_back(pay1);
    _payments.push_back(pay2);
    _payments.push_back(pay3);
    _payments.push_back(pay4);
    _payments.push_back(pay5);
}

Service::Service()
{
    // TODO: remove
    populateTestData();
}

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
    
    auto userId = GetUser()._userId;
    
    auto it = _accounts.find(userId);
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
    
    long max = 0;
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
    
    // TODO: implement.
    for(const auto& item: _users)
    {
        if(item._username == user._username && item._password == user._password)
        {
            SetUser(item);
            return true;
        }
    }

    return false;
}
    
bool Service::Exists(const std::string& username)
{
    for(const auto& user : _users)
    {
        if(user._username == username)
        {
            return true;
        }
    }
    return false;
}
    
User Service::Find(const std::string& username)
{
    for(const auto& user : _users)
    {
        if(user._username == username)
        {
            return user;
        }
    }
    return User();
}
    
User Service::Find(User::Id userId)
{
    for(const auto& user : _users)
    {
        if(user._userId == userId)
        {
            return user;
        }
    }
    return User();
}
    
User Service::Find(const Account acc)
{
    for(const auto& item : _accounts)
    {
        Accounts accs = item.second;
        for(const auto& item2 : accs)
        {
            if(item2._accountId == acc._accountId)
            {
                return Find(item.first);
            }
        }
    }
    return User();
}
    
Payments Service::GetPayments()
{
    Payments res;
    
    for(const auto& pay : _payments)
    {
        for(const auto& acc : GetAccounts())
        {
            if(pay._sender == acc)
            {
                res.push_back(pay);
            }
        }
    }
    
    return res;
}
    
bool Service::MakePayment(const Account& account, const User& user, PriceType amount)
{
    // Find accounts for the users.
    auto it = _accounts.find(account._userId);
    auto it2 = _accounts.find(user._userId);
    
    if(it != _accounts.end() && it2 != _accounts.end())
    {
        Accounts& accs = it->second;
        for(Account& acc : accs)
        {
            if(acc == account)
            {
                // Deduce from balance.
                acc._balance -= amount;
    
                // Add to balance.
                Accounts& accs = it2->second;
                for(Account& acc2 : accs)
                {
                    // Always transfer tod ebit.
                    if(acc2._type == Account::Debit)
                    {
                        acc2._balance += amount;
                        
                        _payments.push_back(Payment(_payments.size(), acc, acc2, amount));
                        // Record the payment.
                        return true;
                    }
                }
                
                // Reverting the payemnt here.
                acc._balance += amount;
                return false;
            }
        }
    }
    return false;
}

}
