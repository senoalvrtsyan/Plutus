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

@interface UserWrapper : NSObject
@property User data;
@end

/* Objective-C service implementation */

typedef void(^parseCompletion)(NSDictionary*);
typedef void(^getAccountsCompletion)(AccountsWrapper*);
typedef void(^getAccountCompletion)(AccountWrapper*);
typedef void(^signInCompletion)(BOOL);
typedef void(^findUserCompletion)(UserWrapper*);
typedef void(^paymentCompletion)(BOOL);

@interface ServiceImpl : NSObject

-(void)QueryImpl:(NSString*)query isGet:(BOOL)bGet completionHandler:(parseCompletion)compblock;

-(void)Query:(NSString*)query completionHandler:(parseCompletion)compblock;
-(void)Mutate:(NSString*)query completionHandler:(parseCompletion)compblock;

// Call after login/signup.
-(void)SetUser:(const User&)user;
// Tell us who is the user.
-(User&)GetUser;

-(void)GetAccounts:(getAccountsCompletion)compblock;
-(void)GetAccount:(Account::Type)type completionHandler:(getAccountCompletion)compblock;

-(void)SignIn:(const User&)user completionHandler:(signInCompletion)compblock;

-(void)Find:(const std::string&)username completionHandler:(findUserCompletion)compblock;

-(void)MakePaymentFromAccount:(const Account&)account toUser:(const User&)user withAmount:(PriceType)amount completionHandler:(paymentCompletion)compblock;

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

    User Find(User::Id userId);
    User Find(const Account accId);
    
    Payments GetPayments();
    Payments GetPendingPayments();

private:
    // TODO: TMP data storages.
    Users _users;
    AccountsMap _accounts;
    Payments _payments;
};

}
using namespace ios;
