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
    _sentMode = true;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [Service2::Instance() GetPaymentHistory: true completionHandler: ^(PaymentRecordsWrapper* w){
        _sentPayments = w.data;
    
        [Service2::Instance() GetPaymentHistory: false completionHandler: ^(PaymentRecordsWrapper* w){
            _receivedPayments = w.data;
        
            [_tableView reloadData];
        }];
    }];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createControls
{
    // Take care of segmented control.
    static const int viewW = self.view.frame.size.width;
    static const int topBarH = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    static const int bottomBarH = self.tabBarController.tabBar.frame.size.height;
    static const int segW = viewW - 20;
    static const int segH = controlH - 10;
    static const int segX = (viewW - segW) / 2; // center
    static const int segY = topBarH + 6;
    
    NSArray* segments = [NSArray arrayWithObjects: @"Sent", @"Received", nil];
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems: segments];
    segmentedControl.frame = CGRectMake(segX, segY, segW, segH);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = theme::brandColor4();
    [segmentedControl addTarget: self action: @selector(segmentChanged:) forControlEvents: UIControlEventValueChanged];
    
    [self.view addSubview: segmentedControl];
    
    // Take care of table view.
    static const int tableX = 0;
    static const int tableY = segY + segH + 6;
    static const int tableH = self.view.frame.size.height - bottomBarH - tableY;
    _tableView = [[UITableView alloc] initWithFrame: CGRectMake(tableX, tableY, viewW, tableH)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = NO;
    
    [self.view addSubview: _tableView];
}

-(void)segmentChanged:(id)sender
{
    // Get the segment control.
    UISegmentedControl* segment = sender;
    _sentMode = !(bool)(segment.selectedSegmentIndex);
    
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sentMode ? _sentPayments.size() : _receivedPayments.size();
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
    
    [cell SetData: _sentMode ? _sentPayments[indexPath.row] : _receivedPayments[indexPath.row]];
    return cell;
}

@end
