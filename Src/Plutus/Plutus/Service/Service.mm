//
//  Service.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Service.h"

#include <sstream>

#import "Utils.h"

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

void Service::SignIn(const User& user, LoginBaseViewController* vc)
{
    if(user._username.empty() || user._password.empty())
    {
        return;
    }
    
    NSString* grapqlBaseURL = @"http://192.168.1.4:3001/graphql?query=";
    NSString* queryString = [NSString stringWithFormat: @"{ authenticate(username: \"%@\", password: \"%@\") { id, name, username, email } }", ToNSString(user._username), ToNSString(user._password)];
    
    NSCharacterSet* expectedCharSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString* requestString = [[grapqlBaseURL stringByAppendingString: queryString] stringByAddingPercentEncodingWithAllowedCharacters: expectedCharSet];
    NSURL* url = [NSURL URLWithString: requestString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL: url];
    [request setHTTPMethod: @"GET"];
    
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
                            
                            if(vc != nil)
                            {
                                /*
                                 Example data:
                                 {
                                    "data": {
                                        "authenticate": {
                                            "id": "102",
                                            "name": "Koriun Aslanyan",
                                            "username": "kor",
                                            "email": "kor@gmail.com"
                                        }
                                    }
                                 }
                                 */
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
                                            u._userId = ToUserId(std::string([((NSString*)userId) UTF8String]));
                                            u._username = std::string([((NSString*)username) UTF8String]);
                                            u._name = std::string([((NSString*)name) UTF8String]);
                                            u._email = std::string([((NSString*)email) UTF8String]);
                                            
                                            // Awesome, set the user as a central user for the service.
                                            Service::Instance().SetUser(u);
                                            res = true;
                                        }
                                    }
                                }
                                
                                // Notify the caller.
                                [vc performSelectorOnMainThread: @selector(handleSignIn:) withObject: [NSNumber numberWithBool: res] waitUntilDone: NO];
                            }
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
    
Account Service::Find(User::Id userId, Account::Type type)
{
    auto it = _accounts.find(userId);
    
    for(const auto& account : it->second)
    {
        if(account._type == type)
        {
            return account;
        }
    }
    
    return Account();
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
    
Payments Service::GetPendingPayments()
{
    Payments res;
    
    auto r = rand() % 4 + 1;
    if(r % 3 == 0)
    {
        res.push_back(Payment(0, GetAccount(Account::Debit), Find(Find("seno")._userId, Account::Debit), 50500));
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
