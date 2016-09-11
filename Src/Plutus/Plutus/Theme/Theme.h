//
//  Theme.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace ios
{
namespace theme
{
    // Colors
    
    UIColor* brandColor1();
    UIColor* brandColor2();
    UIColor* brandColor3();
    UIColor* brandColor4();
    UIColor* brandColor5();
    
    UIColor* backgroundColor();
    UIColor* textColor();
    UIColor* whiteColor();
    
    // Utils
    
    void applyStyle(UITextField* textField);
}
}
using namespace ios;
