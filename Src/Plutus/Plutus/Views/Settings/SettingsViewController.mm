//
//  SettingsViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "SettingsViewController.h"

#import "Constants.h"
#import "Utils.h"
#import "Theme.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Settings";
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createControls
{

}

@end
