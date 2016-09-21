//
//  Utils.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "Utils.h"

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
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,."] invertedSet];
    output = [[output componentsSeparatedByCharactersInSet: setToRemove] componentsJoinedByString:@""];

    // Add AMD at the end, hardcode for now since we are in Armenia.
    output = [output stringByAppendingString: @" AMD"];
    
    return output;
}
    
std::string ToCurrencyStdString(const NSString* str)
{
    return ToStdString(ToCurrencyNSString(str));
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

}
}
