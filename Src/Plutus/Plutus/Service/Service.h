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
#include "PaymentRequest.h"


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

@interface PaymentRequestWrapper : NSObject
@property PaymentRequest data;
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
typedef void(^GetPaymentRequestCompletion)(PaymentRequestWrapper*);
typedef void(^booleanCompletion)(BOOL);

@interface ServiceImpl : NSObject

-(void)QueryImpl:(NSString*)query isGet:(BOOL)bGet completionHandler:(parseCompletion)compblock;
-(void)Query:(NSString*)query completionHandler:(parseCompletion)compblock;
-(void)Mutate:(NSString*)query completionHandler:(parseCompletion)compblock;

// Call after login/signup.
-(void)SetUser:(const User&)user;
// Tell us who is the user.
-(User&)GetUser;

/* Queries */
-(void)GetAccounts:(getAccountsCompletion)compblock;
-(void)GetAccount:(Account::Type)type completionHandler:(getAccountCompletion)compblock;

-(void)SignIn:(const User&)user completionHandler:(signInCompletion)compblock;

-(void)Find:(const std::string&)username completionHandler:(findUserCompletion)compblock;
-(void)FindWithId:(User::Id)userId completionHandler:(findUserCompletion)compblock;

-(void)GetPaymentHistory:(bool)sent completionHandler:(PaymentHistoryCompletion)compblock;

-(void)GetPaymentRequest:(User::Id)userId completionHandler:(GetPaymentRequestCompletion)compblock;

/* Mutations */
-(void)SignUp:(User&)user completionHandler:(signUpCompletion)compblock;

-(void)MakePaymentFromAccount:(const Account&)account toUser:(const User&)user withAmount:(PriceType)amount completionHandler:(paymentCompletion)compblock;

-(void)AddPaymentRequest:(User::Id)reciver forUser:(User::Id)sender withAmount:(PriceType)amount completionHandler:(booleanCompletion)compblock;
-(void)RemovePaymentRequest:(PaymentRequest::Id)requestId completionHandler:(booleanCompletion)compblock;

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
