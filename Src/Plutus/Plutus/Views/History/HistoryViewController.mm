//
//  HistoryViewController.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HistoryViewController.h"

#import "HistoryTableViewCell.h"

#import "Constants.h"
#import "Utils.h"
#import "Theme.h"

#include "Service.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"History";
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
    static const int viewW = self.view.frame.size.width;
    static const int tableX = 0;
    static const int tabley = 0;
    static const int tableH = self.view.frame.size.height;
    _tableView = [[UITableView alloc] initWithFrame: CGRectMake(tableX, tabley, viewW, tableH)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = NO;
    
    [self.view addSubview: _tableView];
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return Service::Instance().GetPayments().size();
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return historyCellH;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ucid = @"histCellUId";
    
    // Try to get the cell.
    HistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: ucid];
    
    // If there is no ready one, create it.
    if(cell == nil)
    {
        cell = [[HistoryTableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: ucid];
    }
    
    Payment pay = Service::Instance().GetPayments()[indexPath.row];
    [cell setPayment: pay];

    return cell;
}

@end
