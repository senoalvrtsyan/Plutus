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


bool Service::SignUp(const User& user)
{
    if(user._username.empty() ||
       user._password.empty() ||
       user._name.empty() ||
       user._email.empty())
    {
        return false;
    }
    
    // TODO: implement.
    return true;
}

bool Service::SignIn(const User& user)
{
    if(user._username.empty() || user._password.empty())
    {
        return false;
    }

    // TODO: implement.
    return true;
}
    
}
