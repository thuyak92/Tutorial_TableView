//
//  NibTableViewCell.h
//  DemoTableAndCollection
//
//  Created by thuynp on 10/24/14.
//  Copyright (c) 2014 ominext. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NibTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *design;
@property (weak, nonatomic) IBOutlet UILabel *cell;
@property (weak, nonatomic) IBOutlet UILabel *nib;

+ (NibTableViewCell *)createView;

@end
