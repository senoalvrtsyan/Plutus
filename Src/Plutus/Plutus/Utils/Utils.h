//
//  Utils.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <string>

namespace ios
{
namespace utils
{

std::string ToStdString(NSString* str);
NSString* ToNSString(const std::string& str);
NSString* ToCurrencyNSString(const NSString* str);
std::string ToCurrencyStdString(const NSString* str);

UIColor* createColor(int r, int g, int b, double a = 1.0);
    
UIImage* imageWithColor(UIColor* color);

bool validateName(NSString* name);
bool validateEmail(NSString* email);
bool validatePassword(NSString* pwd);
    
}
using namespace utils;

}
