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

namespace ios
{

// Class provides access to Plutus backend.
class Service
{
public:
    static Service& Instance();
    
    Service();
    
    // Call after login/signup.
    void SetUser(const User& user);
    
    // Tell us who is the user.
    User& GetUser();
    
    Accounts GetAccounts();
    Account GetAccount(Account::Type type);
    
    bool SignUp(User& user);
    bool SignIn(const User& user);
    
private:
    // Autentificated user.
    User _user;
    
    // TODO: TMP data storages.
    Users _users;
    AccountsMap _accounts;
};

}
