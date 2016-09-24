//
//  Service.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#pragma once

#include "User.h"
#include "Account.h"
#include "Payment.h"

namespace ios
{

// Class provides access to Plutus backend.
class Service
{
public:
    static Service& Instance();
    
    Service();
    
    void populateTestData();
    
    // Call after login/signup.
    void SetUser(const User& user);
    
    // Tell us who is the user.
    User& GetUser();
    
    Accounts GetAccounts();
    Account GetAccount(Account::Type type);
    
    bool SignUp(User& user);
    bool SignIn(const User& user);
    
    bool Exists(const std::string& username);
    User Find(const std::string& username);
    User Find(User::Id userId);
    User Find(const Account accId);
    
    Payments GetPayments();
    
private:
    // Autentificated user.
    User _user;
    
    // TODO: TMP data storages.
    Users _users;
    AccountsMap _accounts;
    Payments _payments;
};

}
