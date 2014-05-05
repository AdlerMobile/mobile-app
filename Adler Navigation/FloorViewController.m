//
//  FloorViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/11/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "FloorViewController.h"
#import "EachFloorViewController.h"
#import "NavigationInputViewController.h"

@interface FloorViewController ()

@end

@implementation FloorViewController

/**
 *  <#Description#>
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([_sourceORDestination isEqualToString:@"1"])
    {
        [_navBarItem setTitle:@"My Location Level"];
    }
    
    if ([_sourceORDestination isEqualToString:@"2"])
    {
        [_navBarItem setTitle:@"Destionation Level"];
    }
}

/**
 *  <#Description#>
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_sourceORDestination isEqualToString:@"1"])
    {
        return 5;
    }
    
    else return 6;
}

/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //Retrieve information form each dictionary in array and display them in labels.
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Upper Level";
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Mid Level";
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = @"Lower Level";
    }
    
    if (indexPath.row == 3) {
        cell.textLabel.text = @"Star Level";
    }
    
    if (indexPath.row == 4) {
        cell.textLabel.text = @"Observatory";
    }
    
    if (indexPath.row == 5) {
        cell.textLabel.text = @"Facilities";
    }
    
    return cell;
}

/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        if ([_sourceORDestination isEqualToString:@"1"]) {
             [self performSegueWithIdentifier:@"source" sender:self];
        }
        else [self performSegueWithIdentifier:@"destination" sender:self];
    }
    else [self performSegueWithIdentifier:@"EachFloorView" sender:self];
    
}

/**
 *  <#Description#>
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //Sends data to the view controller to display details of the tapped individual.
    if ([[segue identifier] isEqualToString:@"EachFloorView"])
    {
        EachFloorViewController *ViewController = [segue destinationViewController];
        ViewController.sourceORdestination = _sourceORDestination;
        
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        if (myIndexPath.row == 0) {
            ViewController.currentFloor = @"top";
        }
        if (myIndexPath.row == 1) {
            ViewController.currentFloor = @"mid";
        }
        if (myIndexPath.row == 2) {
            ViewController.currentFloor = @"lower";
        }
        if (myIndexPath.row == 3) {
            ViewController.currentFloor = @"star";
        }
        if (myIndexPath.row == 5) {
            ViewController.currentFloor = @"facilities";
        }
        
    }
    
    else {
        NavigationInputViewController * ViewController = [segue destinationViewController];
        ViewController.data = @"Observatory";
    }
}

@end
