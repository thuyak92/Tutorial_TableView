//
//  NibTableViewCell.m
//  DemoTableAndCollection
//
//  Created by thuynp on 10/24/14.
//  Copyright (c) 2014 ominext. All rights reserved.
//

#import "NibTableViewCell.h"

@implementation NibTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NibTableViewCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NibTableViewCell" owner:self options:nil] objectAtIndex:0];
}

@end
