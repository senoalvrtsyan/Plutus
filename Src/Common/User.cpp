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
{}
    
bool operator==(const User& o1, const User& o2)
{
    return o1._userId == o2._userId;
}

}
