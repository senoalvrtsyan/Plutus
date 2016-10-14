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

/* NSObject interface wrappers */

@interface AccountsWrapper : NSObject
@property Accounts data;
@end

@interface AccountWrapper : NSObject
@property Account data;
@end

/* Objective-C service implementation */

typedef void(^parseCompletion)(NSDictionary*);

typedef void(^getAccountsCompletion)(AccountsWrapper*);
typedef void(^getAccountCompletion)(AccountWrapper*);

@interface ServiceImpl : NSObject

-(void)Query:(NSString*)query withCompletion:(parseCompletion)compblock;

// Call after login/signup.
-(void)SetUser:(const User&)user;
// Tell us who is the user.
-(User&)GetUser;

-(void)GetAccounts:(getAccountsCompletion)compblock;

-(void)GetAccount:(Account::Type)type withCompletion:(getAccountCompletion)compblock;

// Autentificated user.
@property User user;

@end

namespace ios
{

namespace Service2
{
    ServiceImpl* Instance();
}

// Class provides access to Plutus backend.
class Service
{
public:
    static Service& Instance();
    
    Service();
    
    void populateTestData();
    
    bool SignUp(User& user);
    void SignIn(const User& user, NSObject* obj);
    
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
    NSString* GraphQlBaseURL() const;
    
    // void Query(NSString* query, NSObject* obj, parseSelector, );
    
private:
    // TODO: TMP data storages.
    Users _users;
    AccountsMap _accounts;
    Payments _payments;
};

}
using namespace ios;
