//
//  CommonViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "CommonViewController.h"

#import "Utils.h"
#import "Theme.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBackButton];
    
    // Set background color of the view.
    self.view.backgroundColor = theme::whiteColor();
    
    // Create the view contorls.
    [self createControls];
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

-(void)backAction
{
    [self.navigationController popViewControllerAnimated: YES];
}

-(void)setupBackButton
{
    if(self != [self.navigationController.viewControllers objectAtIndex: 0])
    {
        UIImage* btnImg = [UIImage imageNamed:@"arrow_256"];
        CGRect frameimg = CGRectMake(0, 0, 24, 24);
        UIButton* btn = [[UIButton alloc] initWithFrame: frameimg];
        [btn setBackgroundImage: btnImg forState: UIControlStateNormal];
        [btn addTarget: self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
        [btn setShowsTouchWhenHighlighted: YES];
        UIBarButtonItem* btnItem = [[UIBarButtonItem alloc] initWithCustomView: btn];
        self.navigationItem.leftBarButtonItem = btnItem;
    }
}

-(void)createControls
{
    
}

@end
