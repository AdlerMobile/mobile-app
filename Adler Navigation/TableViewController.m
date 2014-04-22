//
//  TableViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/11/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "TableViewController.h"
#import "FloorViewController.h"
#import "EachFloorViewController.h"
#import "NavigateTableViewController.h"
#import "MapGraph.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[_giveDirections setEnabled:NO];
    self.source.delegate = self;
    self.destination.delegate = self;
    
    // Did we navigate here from facilities?
    if (self.destinationFromFacilities) {
        self.destination.text = self.destinationFromFacilities;
    }
        
}

- (IBAction)editingChanged {
    if ([_source.text length] != 0 && [_destination.text length] != 0) {
        [_giveDirections setEnabled:YES];
    }
    else {
        [_giveDirections setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textFieldDidBeginEditing:(UITextField *)input{
    
    [input resignFirstResponder];
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return YES; // So that I can determine whether or not to perform the segue based on app logic
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FloorViewController *fv = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"SourceTableView"])
    {
        
        fv.sourceORDestination = @"1";
        
    }
    else if ([[segue identifier] isEqualToString:@"DestinationTableView"])
    {
        fv.sourceORDestination = @"2";
    }
    
    else if ([[segue identifier] isEqualToString:@"Navigate"])
    {
        NavigateTableViewController * navigate = [segue destinationViewController];
        navigate.source = _source.text;
        navigate.destination = _destination.text;
    }
    
}

- (IBAction)sourceUnwindToViewController:(UIStoryboardSegue *)sourceUnwindSegue
{
    _source.text = _data;
}

- (IBAction)destinationUnwindToViewController:(UIStoryboardSegue *)destinationUnwindSegue
{
    _destination.text = _data;
}

@end
