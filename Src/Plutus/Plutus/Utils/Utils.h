//
//  Utils.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <string>

#include "Account.h"
#include "User.h"

namespace ios
{
namespace utils
{

std::string ToStdString(NSString* str);
NSString* ToNSString(const std::string& str);
NSString* ToCurrencyNSString(const NSString* str);
std::string ToCurrencyStdString(const NSString* str);
std::string removeCurrencyFormat(const std::string& str);
    
std::string ToStdString(PriceType value);
PriceType ToPrice(const std::string& str);

std::string ToStdString(const Account::Type type);
// 100100100 -> Debit: 100100100
std::string ToStdString(const Account& account);
// Debit: 100100101 -> 100100101
Account::Id ToAccountId(const std::string& accountStr);

User::Id ToUserId(const std::string& str);
    
std::string atUsername(const std::string& str);
    
UIColor* createColor(int r, int g, int b, double a = 1.0);

UIImage* imageWithColor(UIColor* color);

bool validateName(NSString* name);
bool validateEmail(NSString* email);
bool validatePassword(NSString* pwd);

// Shows main tab controller after login, or signup.
void showTabBarController(UIViewController* vc);
void configTabBarItem(UITabBarController* tabBar, int index, NSString* name, NSString* icon);
 
void AlertOk(UIViewController* vc, NSString* title, NSString* text, SEL s);
    
}
using namespace utils;
}
using namespace ios;
