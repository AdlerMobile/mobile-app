//
//  EnterCodeViewController.m
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/30/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "EnterCodeViewController.h"
#import "NavigationInputViewController.h"

@interface EnterCodeViewController ()

@end

@implementation EnterCodeViewController

/**
 *  <#Description#>
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    _inputField.keyboardType = UIKeyboardTypeNumberPad;
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
 *  @param identifier <#identifier description#>
 *  @param sender     <#sender description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"map_data_all" ofType:@"plist"];
    NSArray * nodeDataArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    int index = [_inputField.text intValue];
    if ((index >= [nodeDataArray count])) {
        UIAlertView *navigateAlert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"\nNot a valid code!\n\n"
                                                               delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                                      otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
        [navigateAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
        [navigateAlert show];
        return NO;
    }
    
    BOOL checkIfValid = [[nodeDataArray[index] objectForKey:@"isSourceOrDestination"] boolValue];
    if (checkIfValid != 1) {
        UIAlertView *navigateAlert = [[UIAlertView alloc] initWithTitle:@"Invalid" message:@"\nNot a valid code!\n\n"
                                                               delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                                      otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
        [navigateAlert setTransform:CGAffineTransformMakeTranslation(0,109)];
        [navigateAlert show];
        return NO;
    }

    else return YES;
}

/**
 *  <#Description#>
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"map_data_all" ofType:@"plist"];
    NSArray * nodeDataArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    int index = [_inputField.text intValue];
    NavigationInputViewController * vc = [segue destinationViewController];
    
    vc.data = [nodeDataArray[index] objectForKey:@"uid"];
}

@end
