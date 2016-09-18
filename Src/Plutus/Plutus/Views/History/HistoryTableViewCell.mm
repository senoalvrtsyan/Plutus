//
//  HistoryTableViewCell.mm
//  Plutus
//
//  Created by Hovhannes Grigoryan on 9/1/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HistoryTableViewCell.h"

#import "Utils.h"
#import "Theme.h"

@interface HistoryTableViewCell ()

@end

@implementation HistoryTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
    }
    return self;
}

-(void)createControls
{
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setPayment
{
    self.textLabel.text = @"Payment";
    self.detailTextLabel.text = @"detail";
}

@end
