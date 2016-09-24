//
//  SearchViewController.h
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
    <UITextFieldDelegate>

@property UITextField* textField;
@property UIButton* actionBtn;

@end
