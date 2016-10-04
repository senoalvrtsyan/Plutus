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

#import "LoginBaseViewController.h"

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
    void SignIn(const User& user, LoginBaseViewController* vc);
    
    bool Exists(const std::string& username);
    User Find(const std::string& username);
    User Find(User::Id userId);
    User Find(const Account accId);
    
    // Find account by user id and type
    Account Find(User::Id, Account::Type type);
    
    Payments GetPayments();
    Payments GetPendingPayments();
    
    bool MakePayment(const Account& account, const User& user, PriceType amount);
    
    
private:
    // Autentificated user.
    User _user;
    
    // TODO: TMP data storages.
    Users _users;
    AccountsMap _accounts;
    Payments _payments;
};

}
using namespace ios;
