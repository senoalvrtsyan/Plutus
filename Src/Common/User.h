//
//  User.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#pragma once

#include <string>

typedef unsigned long IdType;

namespace common
{
    
class Coordinate
{
public:
    Coordinate(long latitude = 0, long longitude = 0);
    
    long _latitude;
    long _longitude;
};

class User
{
public:
    User();
    
    IdType      _userId;
    std::string _name;
    std::string _username;
    std::string _email;
    std::string _password;
    std::string _phone;
    std::string _address;
    std::string _passport;
    Coordinate  _coordinate;
};

}
using namespace common;