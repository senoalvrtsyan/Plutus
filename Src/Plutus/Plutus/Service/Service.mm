//
//  Service.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Service.h"

#include <iostream>
#include <sstream>

#import "Utils.h"

// Silent undefined selector warnings since we work with NSObject interface.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

/* NSObject interface wrappers */

@implementation AccountsWrapper
@end

@implementation AccountWrapper
@end

@implementation UserWrapper
@end

@implementation PaymentRecordsWrapper
@end

/* Objective-C service implementation */

@implementation ServiceImpl

-(NSString*)GraphQlBaseURL
{
    static NSString* url = @"http://192.168.1.4:3000/graphql?query=";
    return url;
}

-(void)QueryImpl:(NSString*)query isGet:(BOOL)bGet completionHandler:(parseCompletion)compblock
{
    NSCharacterSet* expectedCharSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString* requestString = [[[self GraphQlBaseURL] stringByAppendingString: query] stringByAddingPercentEncodingWithAllowedCharacters: expectedCharSet];
    NSURL* url = [NSURL URLWithString: requestString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL: url];
    [request setHTTPMethod: bGet ? @"GET" : @"POST"];
    
    // Send request
    NSURLSession* session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest: request
                completionHandler:^(NSData* data,
                                    NSURLResponse* response,
                                    NSError* error)
      {
          if(!error)
          {
              // Success
              if ([response isKindOfClass:[NSHTTPURLResponse class]])
              {
                  NSError* jsonError;
                  NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options: 0 error: &jsonError];
                  
                  if(!jsonError)
                  {
                      // Success Parsing JSON
                      // Log NSDictionary response:
                      NSLog(@"%@", jsonResponse);
                      
                      compblock(jsonResponse);
                  }
                  else
                  {
                      // Error Parsing JSON
                      NSLog(@"error : %@", @"Error Parsing JSON");
                      NSLog(@"RESPONSE: %@", response);
                      NSLog(@"DATA: %@", data);
                  }
              }
              else
              {
                  // Web server is returning an error
                  // Error Parsing JSON
                  NSLog(@"error : %@", @"Web server is returning an error");
                  NSLog(@"RESPONSE: %@", response);
                  NSLog(@"DATA: %@", data);
              }
          }
          else
          {
              // Fail
              NSLog(@"error : %@", error.description);
          }
      }] resume];
}

-(void)Query:(NSString*)query completionHandler:(parseCompletion)compblock
{
    [self QueryImpl: query isGet: YES completionHandler: compblock];
}

-(void)Mutate:(NSString*)query completionHandler:(parseCompletion)compblock
{
    [self QueryImpl: query isGet: NO completionHandler: compblock];
}

-(void)SetUser:(const User&)user
{
    _user = user;
}

-(User&)GetUser
{
    return _user;
}

-(void)GetAccounts:(getAccountsCompletion)compblock;
{
    // Construct query string.
    NSString* queryString =
    [NSString stringWithFormat: @"{ accounts( userid: %lu ) { id, userid, type, balance, limit } }", [self GetUser]._userId];
    
    // Make the actual query.
    [self Query: queryString completionHandler:^(NSDictionary* jsonResponse) {
        
        /* Example responce:
         {
         "data":
         {
         "accounts": [
         {
         "id": "100100101",
         "userid": "2",
         "type": 1,
         "balance": 75000,
         "limit": null
         },
         {
         "id": "200100101",
         "userid": "2",
         "type": 2,
         "balance": 240000,
         "limit": 400000
         }]
         }
         }
         */
        id data = [jsonResponse objectForKey: @"data"];
        if(data != [NSNull null])
        {
            id accs = [data objectForKey: @"accounts"];
            if(accs != [NSNull null])
            {
                Accounts res;
                for(NSDictionary* acc in accs)
                {
                    // Get fields.
                    id accId = [acc objectForKey: @"id"];
                    id userId = [acc objectForKey: @"userid"];
                    id accType = [acc objectForKey: @"type"];
                    id balance = [acc objectForKey: @"balance"];
                    id limit = [acc objectForKey: @"limit"];
                    
                    if(userId != [NSNull null] &&
                       accId != [NSNull null] &&
                       accType != [NSNull null] &&
                       balance != [NSNull null]) // Limit can be null
                    {
                        Account acc;
                        acc._accountId = std::string([((NSString*)accId) UTF8String]);
                        acc._userId = ToId(std::string([((NSString*)userId) UTF8String]));
                        acc._type = static_cast<Account::Type>([(NSNumber*)accType integerValue]);
                        acc._balance = poost::lexical_cast<PriceType>([(NSNumber*)balance floatValue]);
                        if(limit != [NSNull null])
                        {
                            acc._limit = poost::lexical_cast<PriceType>([(NSNumber*)limit floatValue]);
                        }
                        
                        res.push_back(acc);
                    }
                }
                
                // We just love main thread :)
                dispatch_async(dispatch_get_main_queue(), ^{
                    AccountsWrapper* w = [[AccountsWrapper alloc] init];
                    w.data = res;
                    compblock(w);
                });
            }
        }
    }];
}

-(void)GetAccount:(Account::Type)type completionHandler:(getAccountCompletion)compblock
{
    [self GetAccounts: ^(AccountsWrapper* w){
        
        Account res;
        
        for(const auto& item : w.data)
        {
            if(item._type == type)
            {
                res = item;
                break;
            }
        }
        
        AccountWrapper* a = [[AccountWrapper alloc] init];
        a.data = res;
        compblock(a);
    }];
}

-(void)SignIn:(const User&)user completionHandler:(signInCompletion)compblock
{
    if(user._username.empty() || user._password.empty())
    {
        compblock(NO);
    }
    
    // Construct the query string.
    NSString* queryString = [NSString stringWithFormat: @"{ authenticate(username: \"%@\", password: \"%@\") { id, name, username, email } }", ToNSString(user._username), ToNSString(user._password)];
    
    // Do the actual query here.
    [self Query: queryString completionHandler:^(NSDictionary* jsonResponse) {
        
        /* Example responce:
         {
         "data":
         {
         "authenticate":
         {
         "id": "102",
         "name": "Koriun Aslanyan",
         "username": "kor",
         "email": "kor@gmail.com"
         }
         }
         } */
        bool res = false;
        id data = [jsonResponse objectForKey: @"data"];
        if(data != [NSNull null])
        {
            id usr = [data objectForKey: @"authenticate"];
            if(usr != [NSNull null])
            {
                // Get fields.
                id userId = [usr objectForKey: @"id"];
                id username = [usr objectForKey: @"username"];
                id name = [usr objectForKey: @"name"];
                id email = [usr objectForKey: @"email"];
                
                if(userId != [NSNull null] &&
                   username != [NSNull null] &&
                   name != [NSNull null] &&
                   email != [NSNull null]
                   )
                {
                    // Construct the user.
                    User u;
                    u._userId = ToId(std::string([((NSString*)userId) UTF8String]));
                    u._username = std::string([((NSString*)username) UTF8String]);
                    u._name = std::string([((NSString*)name) UTF8String]);
                    u._email = std::string([((NSString*)email) UTF8String]);
                    
                    // Awesome, set the user as a central user for the service.
                    [self SetUser: u];
                    res = true;
                }
            }
        }
        
        // We just love main thread :)
        dispatch_async(dispatch_get_main_queue(), ^{
            compblock(res);
        });
    }];
}

-(void)SignUp:(User&)user completionHandler:(signUpCompletion)compblock
{
    if(user._username.empty() ||
       user._password.empty() ||
       user._name. empty() ||
       user._email.empty())
    {
        compblock(NO);
    }
    
    // Construct the query string.
    NSString* queryString = [NSString stringWithFormat:
                             @"mutation { signUp(name: \"%@\", username: \"%@\", email: \"%@\", password: \"%@\") { id name username email } }",
                             ToNSString(user._name), ToNSString(user._username), ToNSString(user._email), ToNSString(user._password)];
    
    // Do the actual query here.
    [self Mutate: queryString completionHandler:^(NSDictionary* jsonResponse) {
        
        /* Example responce:
         {
         "data": {
            "signUp": {
                "id": "27",
                "name": "Super men",
                "username": "sm",
                "email": "sm@gmail.com"
                }
            }
         } */
        bool res = false;
        id data = [jsonResponse objectForKey: @"data"];
        if(data != [NSNull null])
        {
            id usr = [data objectForKey: @"signUp"];
            if(usr != [NSNull null])
            {
                // Get fields.
                id userId = [usr objectForKey: @"id"];
                id username = [usr objectForKey: @"username"];
                id name = [usr objectForKey: @"name"];
                id email = [usr objectForKey: @"email"];
                
                if(userId != [NSNull null] &&
                   username != [NSNull null] &&
                   name != [NSNull null] &&
                   email != [NSNull null]
                   )
                {
                    // Construct the user.
                    User u;
                    u._userId = ToId(std::string([((NSString*)userId) UTF8String]));
                    u._username = std::string([((NSString*)username) UTF8String]);
                    u._name = std::string([((NSString*)name) UTF8String]);
                    u._email = std::string([((NSString*)email) UTF8String]);
                    
                    // No need to do anything with user here, after signup we will be sending login normally.
                    // User info is not used herr is iOS client for now.
                    
                    res = true;
                }
            }
        }
        
        // We just love main thread :)
        dispatch_async(dispatch_get_main_queue(), ^{
            compblock(res);
        });
    }];
}

-(void)Find:(const std::string&)username completionHandler:(findUserCompletion)compblock
{
    // Construct the query string.
    NSString* queryString = [NSString stringWithFormat: @"{ finduser(username: \"%@\") { id name username email } }",
                             ToNSString(username)];
    
    // Do the actual query here.
    
    [self Query: queryString completionHandler: ^(NSDictionary* jsonResponse) {
        
        /* Example responce:
         {
         "data":
         {
         "finduser":
         {
         "id": "102",
         "name": "Koriun Aslanyan",
         "username": "kor",
         "email": "kor@gmail.com"
         }
         }
         } */
        User u;
        id data = [jsonResponse objectForKey: @"data"];
        if(data != [NSNull null])
        {
            id usr = [data objectForKey: @"finduser"];
            if(usr != [NSNull null])
            {
                // Get fields.
                id userId = [usr objectForKey: @"id"];
                id username = [usr objectForKey: @"username"];
                id name = [usr objectForKey: @"name"];
                id email = [usr objectForKey: @"email"];
                
                if(userId != [NSNull null] &&
                   username != [NSNull null] &&
                   name != [NSNull null] &&
                   email != [NSNull null]
                   )
                {
                    // Construct the user.
                    u._userId = ToId(std::string([((NSString*)userId) UTF8String]));
                    u._username = std::string([((NSString*)username) UTF8String]);
                    u._name = std::string([((NSString*)name) UTF8String]);
                    u._email = std::string([((NSString*)email) UTF8String]);
                }
            }
        }
        
        // We just love main thread :)
        dispatch_async(dispatch_get_main_queue(), ^{
            UserWrapper* uw = [[UserWrapper alloc] init];
            uw.data = u;
            compblock(uw);
        });
    }];
}

-(void)MakePaymentFromAccount:(const Account&)account toUser:(const User&)user withAmount:(PriceType)amount completionHandler:(paymentCompletion)compblock
{
    // Construct the query string.
    NSString* queryString = [NSString stringWithFormat: @"mutation { makePayment( account: \"%@\" userId: %lu amount: %f ) }",
                             ToNSString(account._accountId), user._userId, amount];
    
    // Do the actual query here.
    [self Mutate: queryString completionHandler: ^(NSDictionary* jsonResponse) {
        
        /* Example responce:
         {
         "data": {
            "makePayment": true
         }
         } */
        bool res = false;
        id data = [jsonResponse objectForKey: @"data"];
        if(data != [NSNull null])
        {
            id status = [data objectForKey: @"makePayment"];
            if(status != [NSNull null])
            {
                res = [(NSNumber*)status boolValue];
            }
        }
        
        // We just love main thread :)
        dispatch_async(dispatch_get_main_queue(), ^{
            compblock(res);
        });
    }];
}

-(void)GetPaymentHistory:(bool)sent completionHandler:(PaymentHistoryCompletion)compblock
{
    // Construct query string.
    NSString* queryString =
    [NSString stringWithFormat: @"{ paymentHistory(userid: %lu, sent: %u) { account type name username amount sent} }",
        [self GetUser]._userId, (unsigned)sent];
    
    // Make the actual query.
    [self Query: queryString completionHandler:^(NSDictionary* jsonResponse) {
        
        /* Example responce:
         {
            "data": {
                "paymentHistory": [
                {
                    "account": "200100102",
                    "name": "Hovhannes Grigoryan",
                    "username": "hov",
                    "amount": 778
                }
                ]
            }
         }
         */
        id data = [jsonResponse objectForKey: @"data"];
        if(data != [NSNull null])
        {
            id accs = [data objectForKey: @"paymentHistory"];
            if(accs != [NSNull null])
            {
                PaymentRecords res;
                for(NSDictionary* acc in accs)
                {
                    // Get fields.
                    id accId = [acc objectForKey: @"account"];
                    id type = [acc objectForKey: @"type"];
                    id name = [acc objectForKey: @"name"];
                    id username = [acc objectForKey: @"username"];
                    id amount = [acc objectForKey: @"amount"];
                    id sent = [acc objectForKey: @"sent"];
                    
                    if(accId != [NSNull null] &&
                       type != [NSNull null] &&
                       name != [NSNull null] &&
                       username != [NSNull null] &&
                       amount != [NSNull null] &&
                       sent != [NSNull null])
                    {
                        bool bSent = [(NSNumber*)sent integerValue];
                        
                        PaymentRecord r(ToStdString((NSString*)accId),
                                        static_cast<Account::Type>([(NSNumber*)type integerValue]),
                                        ToStdString((NSString*)name),
                                        ToStdString((NSString*)username),
                                        poost::lexical_cast<PriceType>([(NSNumber*)amount floatValue]),
                                        bSent);
                        res.push_back(r);
                    }
                }
                
                // We just love main thread :)
                dispatch_async(dispatch_get_main_queue(), ^{
                    PaymentRecordsWrapper* w = [[PaymentRecordsWrapper alloc] init];
                    w.data = res;
                    compblock(w);
                });
            }
        }
    }];
}

@end

namespace ios
{

namespace Service
{

ServiceImpl* Instance()
{
    static ServiceImpl* s = [[ServiceImpl alloc] init];
    return s;
}

}
    
}

#pragma clang diagnostic pop
