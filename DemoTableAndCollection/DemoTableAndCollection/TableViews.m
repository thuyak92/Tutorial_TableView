//
//  TableViews.m
//  DemoTableAndCollection
//
//  Created by thuynp on 10/24/14.
//  Copyright (c) 2014 ominext. All rights reserved.
//

#import "TableViews.h"

@interface TableViews ()

@end

@implementation TableViews

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.title = @"Table Views";
    numOfRow2 = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 2;
        case 2:
            return numOfRow2;
    }
    return 0;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSArray *arr = [NSArray arrayWithObjects:@"Table View Cells", @"Table View Data", @"Table View Selection", @"Table View Scrolling and Layout", @"Table View State Restoration", @"Table View Searching", @"Table View Editing", @"Table View Menu", nil];
//    return arr;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Table View Cells";
        case 1:
            return @"Table View Scrolling";
        case 2:
            return @"Table View Editing";
        default:
            break;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0://Table View Cell
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Built-In Cell Style"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Custom Cell"];
                    break;
                default:
                    break;
            }
            break;
        case 1://Table View Scrolling
            switch (indexPath.row) {
                case 0:
                    [cell.textLabel setText:@"Scroll To Row At IndexPath"];
                    break;
                case 1:
                    [cell.textLabel setText:@"Scroll To Nearest Selected Row"];
                    break;
                default:
                    break;
            }
            break;
            
        case 2://Table View Editing
            switch (indexPath.row) {
                case 0:
                    if (!is_edited) {
                        txtf = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, cell.frame.size.width-40, cell.frame.size.height-10)];
                        [txtf setEnabled:NO];
                        [txtf setDelegate:self];
                        [cell addSubview:txtf];
                        [cell.textLabel setText:@"Editable Content in Table Items"];
                    }
                    else
                    {
                        [cell.textLabel setText:txtTitle];
                    }
                    break;
                case 1:
                    [cell.textLabel setText:@"Delete Table Items"];
                    break;
                case 2:
                    [cell.textLabel setText:@"Inserting Table Items"];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    // Configure the cell...
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0://Table View Cell
            switch (indexPath.row) {
                case 0:
                    _styleVC = [[StyleTableViewController alloc] init];
                    [self.navigationController pushViewController:_styleVC animated:YES];
                    break;
                case 1:
                    _customVC = [[CustomTableViewController alloc] init];
                    [self.navigationController pushViewController:_customVC animated:YES];
                    break;
                default:
                    break;
            }
            break;
#warning T Table View Scrolling
        case 1://Table View Scrolling
            switch (indexPath.row) {
                case 0:
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                    
                    break;
                case 1:
                    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
                    break;
                default:
                    break;
            }
            break;
#warning T Table View Editing
        case 2://Table View Editing
            if (indexPath.row == 0) {
                [[tableView cellForRowAtIndexPath:indexPath].textLabel setText:@""];
                [txtf setEnabled:YES];
                [[tableView cellForRowAtIndexPath:indexPath] setHighlighted:NO];
            }
            else if ((is_deleted && indexPath.row >= 1) || (!is_deleted && indexPath.row >= 2)) {
                numOfRow2++;
                NSInteger ct = numOfRow2;
                [tableView beginUpdates];
                [tableView insertRowsAtIndexPaths:
                 @[[NSIndexPath indexPathForRow: ct-1 inSection:2]]
                                 withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView endUpdates];
                UITableViewCell* cell =
                [self.tableView cellForRowAtIndexPath:
                 [NSIndexPath indexPathForRow:ct-1 inSection:2]];
                [cell.textLabel setText:@"Inserting Table Items"];
            }
            
        default:
            break;
    }
}

//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 2)
//        return YES;
//    return NO;
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 1)
            return UITableViewCellEditingStyleDelete;
        if (indexPath.row == 2) {
            return UITableViewCellEditingStyleInsert;
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)ip {
    [tableView endEditing:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        is_deleted = TRUE;
        numOfRow2--;
        [self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadSectionIndexTitles];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        [self.numbers addObject: @""];
        numOfRow2++;
        NSInteger ct = numOfRow2;
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:
         @[[NSIndexPath indexPathForRow: ct-1 inSection:2]]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadRowsAtIndexPaths:
         @[[NSIndexPath indexPathForRow:ct-2 inSection:2]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        // crucial that this next bit be *outside* the update block
        UITableViewCell* cell =
        [self.tableView cellForRowAtIndexPath:
         [NSIndexPath indexPathForRow:ct-1 inSection:2]];
        [cell.textLabel setText:@"has been inserted"];
    }
    
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return [textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    txtTitle = txtf.text;
    [txtf setEnabled:NO];
    txtf.text = @"";
    is_edited = YES;
    [self.tableView reloadData];
}

#warning T Table View Menu
- (BOOL)tableView:(UITableView *)tableView
shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action
forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return (action == @selector(copy:) || action == @selector(paste:));
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action
forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    NSString* s = self.sectionData[indexPath.section][indexPath.row];
    if (action == @selector(copy:)) {
        // ... do whatever copying consists of ...
        copyString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    } else if (action == @selector(paste:)) {
        if (!copyString) {
            copyString = @"Default String";
        }
        [[tableView cellForRowAtIndexPath:indexPath].textLabel setText:copyString];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
