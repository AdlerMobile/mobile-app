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

@property (strong, nonatomic) NSArray *choices;

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
        
        _choices = @[@"Upper Level",
                     @"Mid Level",
                     @"Lower Level",
                     @"Star Level",
                     @"Observatory"];
    }
    
    if ([_sourceORDestination isEqualToString:@"2"])
    {
        [_navBarItem setTitle:@"Destination Level"];
        
        _choices = @[@"Upper Level",
                     @"Mid Level",
                     @"Lower Level",
                     @"Star Level",
                     @"Observatory",
                     @"Sky Theater",
                     @"Space Theater",
                     @"Star Theater",
                     @"Men's Restroom",
                     @"Women's Restroom",
                     @"Facilities"];
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
    return [self.choices count];
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
    
    cell.textLabel.text = [self.choices objectAtIndex:indexPath.row];
    
    return cell;
}

/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row >= 4 && indexPath.row <= 9) {
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
        if (myIndexPath.row == 10) {
            ViewController.currentFloor = @"facilities";
        }
        
    }
    
    else {
        NavigationInputViewController * ViewController = [segue destinationViewController];

        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];

        ViewController.data = [self.choices objectAtIndex:myIndexPath.row];
    }
}

@end
