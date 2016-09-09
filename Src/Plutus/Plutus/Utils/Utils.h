//
//  Utils.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace ios
{

namespace utils
{
    
UIColor* CreateColor(int r, int g, int b, double a = 1.0);
    
UIImage* imageWithColor(UIColor* color);
    
}
using namespace utils;

}
