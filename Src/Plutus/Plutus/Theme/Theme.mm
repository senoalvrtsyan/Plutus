//
//  Theme.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "Theme.h"

#import "Utils.h"

namespace ios
{
namespace theme
{
UIColor* brandColor1()
{
    return createColor(242, 173, 151);
}
    
UIColor* brandColor2()
{
    return createColor(242, 105, 104);
}
    
UIColor* brandColor3()
{
    return createColor(223, 226, 210);
}
    
UIColor* brandColor4()
{
    return createColor(108, 191, 132);
}
    
UIColor* brandColor5()
{
    return createColor(50, 51, 57);
}
    
UIColor* backgroundColor()
{
    return brandColor3();
}
    
UIColor* textColor()
{
    return brandColor5();
}
    
UIColor* whiteColor()
{
    return [UIColor whiteColor];
}
    
UIColor* lightGrayColor()
{
    return [UIColor lightGrayColor];
}

UIColor* grayColor()
{
    return [UIColor grayColor];
}
    
UIColor* placeholderTextColor()
{
    return createColor(199, 199, 205);
}
    
void applyStyle(UITextField* textField)
{
    // Add left padding.
    UIView* padding = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 15, textField.frame.size.height)];
    textField.leftView = padding;
    textField.leftViewMode = UITextFieldViewModeAlways;
    // Set text color
    textField.textColor = theme::textColor();
    textField.backgroundColor = theme::whiteColor();
    // Border style.
    textField.layer.cornerRadius = 0.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [theme::brandColor4() CGColor];
    textField.layer.borderWidth = 1.0f;
}
    
}
}
