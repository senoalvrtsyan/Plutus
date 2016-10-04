//
//  Utils.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "Utils.h"

#include <sstream>
#include <algorithm>

#import "Theme.h"
#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "HistoryViewController.h"

namespace ios
{
namespace utils
{
    
std::string ToStdString(NSString* str)
{
    static const std::string emptyStr;
    
    const char* const c = [str cStringUsingEncoding: [NSString defaultCStringEncoding]];
    return (c == NULL) ? emptyStr : std::string(c);
}
    
NSString* ToNSString(const std::string& str)
{
    return [NSString stringWithCString: str.c_str() encoding: [NSString defaultCStringEncoding]];
}
    
NSString* ToCurrencyNSString(const NSString* str)
{
    // Foramt as currency - 50,000.00
    NSNumber* someNumber = [NSNumber numberWithFloat: [str floatValue]];
    NSNumberFormatter* nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString* output = [nf stringFromNumber: someNumber];
    
    // Remove currency sign
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,.-"] invertedSet];
    output = [[output componentsSeparatedByCharactersInSet: setToRemove] componentsJoinedByString:@""];

    // Add AMD at the end, hardcode for now since we are in Armenia.
    output = [output stringByAppendingString: @" AMD"];
    
    return output;
}
    
std::string ToCurrencyStdString(const NSString* str)
{
    return ToStdString(ToCurrencyNSString(str));
}
    
std::string removeCurrencyFormat(const std::string& str)
{
    std::string res = str;

    // Remove ','
    auto p =res.find(',');
    while(p != std::string::npos)
    {
        res.erase(p, 1);
        p = res.find(',');
    }
    
    // Remove currency mark.
    const auto pos = res.find_last_of(' ');
    if(pos != std::string::npos)
    {
        return res.substr(0, pos);
    }
    else
    {
        return res;
    }
}

std::string ToStdString(PriceType value)
{
    std::stringstream ss;
    ss << value;
    
    std::string res;
    ss >> res;
    return res;
}

PriceType ToPrice(const std::string& str)
{
    PriceType res;
    
    std::stringstream ss;
    ss << str;
    ss >> res;
    
    return res;
}
    
std::string ToStdString(const Account::Type type)
{
    if(type == Account::Debit)
    {
        return "Debit";
    }
    else if(type == Account::Credit)
    {
        return "Credit";
    }
    else
    {
        return "";
    }
}
    
Account::Id ToAccountId(const std::string& accountStr)
{
    const auto pos = accountStr.find(" ");
    if(pos != std::string::npos)
    {
        return accountStr.substr(pos + 1);
    }
    
    return Account::Id();
}
    
std::string ToStdString(const Account& account)
{
    std::string res = ToStdString(account._type);
    res += ": ";
    res += account._accountId;
    return res;
}
    
User::Id ToUserId(const std::string& str)
{
    User::Id res;
    
    std::stringstream ss;
    ss << str;
    ss >> res;
    
    return res;
}
    
std::string atUsername(const std::string& str)
{
    std::string res = "@";
    return res + str;
}
    
UIColor* createColor(int r, int g, int b, double a /*= 1.0*/)
{
    return [UIColor colorWithRed: (double)r/255.0 green: (double)g/255.0 blue: (double)b/255.0 alpha: a];
}
    
UIImage* imageWithColor(UIColor* color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
        
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
        
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        
    return image;
}
    
bool validateName(NSString* name)
{
    return [name length];
}

bool validateEmail(NSString* email)
{
    return [email rangeOfString: @"@"].location != NSNotFound;
}
    
bool validatePassword(NSString* pwd)
{
    return [pwd length];
}

void showTabBarController(UIViewController* vc)
{
    // Create tab bar controller.
    UITabBarController* tabBar = [[UITabBarController alloc] init];
    
    // Set tab bar style.
    [[UITabBar appearance] setTintColor: theme::brandColor2()];
    // [[UITabBar appearance] setBarTintColor: theme::brandColor1()];
    
    // Profile
    // {
    ProfileViewController* profileVC = [[ProfileViewController alloc] init];
    
    UINavigationController* profileNC = [[UINavigationController alloc] initWithRootViewController: profileVC];
    //SetNavBarStyle(navControllerMap.navigationBar);
    // }
    
    // Search
    // {
    SearchViewController* searchVC = [[SearchViewController alloc] init];
    
    UINavigationController* searchNC = [[UINavigationController alloc] initWithRootViewController: searchVC];
    //SetNavBarStyle(navControllerMap.navigationBar);
    // }
    
    // History
    // {
    HistoryViewController* historyVC = [[HistoryViewController alloc] init];
    
    UINavigationController* historyNC = [[UINavigationController alloc] initWithRootViewController: historyVC];
    //SetNavBarStyle(navControllerMap.navigationBar);
    // }
    
    // Add to tab bar.
    NSArray* controllers = [NSArray arrayWithObjects: profileNC, searchNC, historyNC, nil];
    tabBar.viewControllers = controllers;
    
    // Config items.
    configTabBarItem(tabBar, 0, @"Profile",  @"wallet");
    configTabBarItem(tabBar, 1, @"Profile2", @"paper-plane");
    configTabBarItem(tabBar, 2, @"Profile3", @"clipboard");
    
    // Set initial view.
    tabBar.selectedIndex = 0;
    
    // Take care of nav bar title style.
    NSDictionary* navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                                   theme::grayColor(), NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
    [vc presentViewController: tabBar animated: YES completion: nil];
}
    
void configTabBarItem(UITabBarController* tabBar, int index, NSString* name, NSString* icon)
{
    static const auto imgInsets     = UIEdgeInsetsMake(6, 0, -6, 0);
    static const auto titleOffset   = UIOffsetMake(0, 20);
    
    [[tabBar.tabBar.items objectAtIndex: index] setImage: [[UIImage imageNamed: icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[tabBar.tabBar.items objectAtIndex: index] setSelectedImage: [UIImage imageNamed: icon]];
    [[tabBar.tabBar.items objectAtIndex: index] setTitle: name];
    [[tabBar.tabBar.items objectAtIndex: index] setImageInsets: imgInsets];
    [[tabBar.tabBar.items objectAtIndex: index] setTitlePositionAdjustment: titleOffset];
}
    
void AlertOk(UIViewController* vc, NSString* title, NSString* text, SEL s)
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle: title
                                message: text
                                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle: @"Ok"
                                style: UIAlertActionStyleDefault
                                handler: ^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                    
                                    if(s)
                                    {
                                        [vc performSelector: s withObject: nil afterDelay: 0.0];
                                    }
                                }];
    
    [alert addAction: okButton];
    
    [vc presentViewController: alert animated: YES completion: nil];
    
    // iOS bug, need to do this here.
    [alert.view setTintColor: theme::brandColor4()];
}
    
}
}
