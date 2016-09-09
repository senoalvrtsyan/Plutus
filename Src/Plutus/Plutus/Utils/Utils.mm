//
//  Utils.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#include "Utils.h"

namespace ios
{
namespace utils
{

UIColor* CreateColor(int r, int g, int b, double a /*= 1.0*/)
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
        
}
}
