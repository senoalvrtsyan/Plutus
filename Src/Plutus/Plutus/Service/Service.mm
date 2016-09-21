//
//  Service.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Service.h"

namespace ios
{

Service& Service::Instance()
{
    static Service service;
    return service;
}

Service::Service()
{}

void Service::SetUser(const User& user)
{
    _user = user;
}
    
User& Service::GetUser()
{
    return _user;
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
    
    // TODO: implement.
    return true;
}

bool Service::SignIn(const User& user)
{
    if(user._username.empty() || user._password.empty())
    {
        return false;
    }
    
    return true;
    
    // TODO: implement.
    for(const auto& user: _users)
    {
        if(user._name == user._name && user._password == user._password)
        {
            return true;
        }
    }

    return false;
}
    
}
