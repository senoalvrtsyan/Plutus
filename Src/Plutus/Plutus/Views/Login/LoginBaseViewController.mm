//
//  LoginBaseViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "LoginBaseViewController.h"

#import "Utils.h"

@interface LoginBaseViewController ()

@end

@implementation LoginBaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the view contorls.
    [self createControls];
}

-(void)createControls
{
    // Childs implement this.
}

-(void)handleSignIn:(BOOL)res
{
    if(res)
    {
        showTabBarController(self);
    }
    else
    {
        // TODO: show alert
    }
}

@end
