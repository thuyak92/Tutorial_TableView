//
//  TableViews.h
//  DemoTableAndCollection
//
//  Created by thuynp on 10/24/14.
//  Copyright (c) 2014 ominext. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleTableViewController.h"
#import "CustomTableViewController.h"

@interface TableViews : UITableViewController<UITextFieldDelegate>
{
    BOOL is_deleted, is_edited, automaticEditControlsDidShow;
    UITextField *txtf;
    NSString *txtTitle, *copyString;
    int numOfRow2;
}
@property (strong, nonatomic) StyleTableViewController *styleVC;
@property (strong, nonatomic) CustomTableViewController *customVC;

@end
