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
#include "PaymentRecord.h"

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

@interface PaymentRecordsWrapper : NSObject
@property PaymentRecords data;
@end

/* Objective-C service implementation */

typedef void(^parseCompletion)(NSDictionary*);
typedef void(^getAccountsCompletion)(AccountsWrapper*);
typedef void(^getAccountCompletion)(AccountWrapper*);
typedef void(^signInCompletion)(BOOL);
typedef void(^signUpCompletion)(BOOL);
typedef void(^findUserCompletion)(UserWrapper*);
typedef void(^paymentCompletion)(BOOL);
typedef void(^PaymentHistoryCompletion)(PaymentRecordsWrapper*);

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
-(void)SignUp:(User&)user completionHandler:(signUpCompletion)compblock;

-(void)Find:(const std::string&)username completionHandler:(findUserCompletion)compblock;

-(void)MakePaymentFromAccount:(const Account&)account toUser:(const User&)user withAmount:(PriceType)amount completionHandler:(paymentCompletion)compblock;

-(void)GetPaymentHistory:(bool)sent completionHandler:(PaymentHistoryCompletion)compblock;

// Autentificated user.
@property User user;

@end

namespace ios
{

namespace Service
{
    ServiceImpl* Instance();
}

}
using namespace ios;
