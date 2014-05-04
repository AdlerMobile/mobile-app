//
//  TableViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/11/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "NavigationViewController.h"
#import "FloorViewController.h"
#import "EachFloorViewController.h"
#import "NavigateTableViewController.h"
#import "MapGraph.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.source.delegate = self;
    self.destination.delegate = self;
    
    // This has to be set after the view loads. Attempting to set destination.text
    // from another view controller will fail because it doesn't exist yet.
    if (self.dest) {
        self.destination.text = self.dest;
    }
    
    //Designs for the text fields and buttons on this page.
    UITextField *src = (UITextField *)[self.view viewWithTag:1];
    src.layer.borderWidth = 1.5f;
    src.layer.cornerRadius = 9.0f;
    UITextField *des = (UITextField *)[self.view viewWithTag:2];
    des.layer.borderWidth = 1.5f;
    des.layer.cornerRadius = 9.0f;
    
    UIButton *enterLocation = (UIButton *)[self.view viewWithTag:3];
    enterLocation.layer.borderWidth = 1.5f;
    enterLocation.layer.cornerRadius = 9.0f;
    
    UIButton *enterDestination = (UIButton *)[self.view viewWithTag:4];
    enterDestination.layer.borderWidth = 1.5f;
    enterDestination.layer.cornerRadius = 9.0f;
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:5];
    btn.layer.borderWidth = 1.5f;
    btn.layer.cornerRadius = 9.0f;
    
    _enterCode.layer.borderWidth = 1.5f;
    _enterCode.layer.cornerRadius = 9.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//hide keyboard on tapping the text field.
- (void) textFieldDidBeginEditing:(UITextField *)input{
    
    [input resignFirstResponder];
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    //checking if segue being used called Navigate. i.e. is get directions button pressed.
    if ([identifier isEqualToString:@"Navigate"]){
        //handling when either of the fields are empty. Create an alert.
        if ([_source.text isEqualToString:@""]||[_destination.text isEqualToString:@""]){
            UIAlertView *navigateAlert = [[UIAlertView alloc] initWithTitle:@"Ummm.." message:@"\nPlease fill in both fields.\n\n"
                                            delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
            [navigateAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
            [navigateAlert show];
            return NO;
        }
        
        //handling when both the fields have same exhibits.
        if ([_source.text isEqualToString:_destination.text]) {
            UIAlertView *navigateAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"\nYou are already at your destination.\n\n"
                                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
            [navigateAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
            [navigateAlert show];
            return NO;

        }
        
        //handling when a user tries visiting the closest restroom while at the restroom.
        if ((([_source.text rangeOfString:@"Men's Restroom"].location != NSNotFound) && ([_destination.text rangeOfString:@"Men's Restroom"].location != NSNotFound))|| (([_source.text rangeOfString:@"Women's Restroom"].location != NSNotFound) && ([_destination.text rangeOfString:@"Women's Restroom"].location != NSNotFound))) {
            UIAlertView *navigateAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"\nYou are already at your destination.\n\n"
                                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
            [navigateAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
            [navigateAlert show];
            return NO;
            
        }
        
        //handling for when box office and coat check is selected as they both are the same place.
        if (([_source.text isEqualToString:@"Box Office"] && [_destination.text isEqualToString:@"Coat Check"]) || ([_source.text isEqualToString:@"Coat Check"] && [_destination.text isEqualToString:@"Box Office"])) {
            UIAlertView *navigateAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"\nBox Office and Coat Check is the same place.\n\n"
                                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                                          otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
            [navigateAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
            [navigateAlert show];
            return NO;
            
        }
        
    }
    return YES;
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

- (IBAction)codeUnwindToViewController:(UIStoryboardSegue *)codeUnwindSegue
{
    //code to convert _data which is the code to the exhibit name goes here.
    _source.text = _data;
}

- (IBAction)destinationUnwindToViewController:(UIStoryboardSegue *)destinationUnwindSegue
{
    _destination.text = _data;
}

@end
