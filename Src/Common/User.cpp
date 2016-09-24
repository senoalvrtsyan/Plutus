//
//  User.cpp
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "User.h"

namespace common
{
    
Coordinate::Coordinate(long latitude, long longitude)
    : _latitude(latitude)
    , _longitude(longitude)
{}

User::User()
    : _userId(0)
{}

User::User(Id userId,
     std::string name,
     std::string username,
     std::string email,
     std::string password)
    : _userId(userId)
    , _name(name)
    , _username(username)
    , _email(email)
    , _password(password)
{}
    
bool operator==(const User& o1, const User& o2)
{
    return o1._userId == o2._userId;
}

}
