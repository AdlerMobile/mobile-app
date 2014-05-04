//
//  TableViewController.h
//  Adler Navigation
//
//  Created by Rohan Shah on 3/11/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * This View Controller Allows user to select their current location and destination. 
 * Sends the user inputs to display the path from source to destionation.
 */
@interface NavigationInputViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *source; // my location.
@property (strong, nonatomic) IBOutlet UITextField *destination; // my destination.
@property (strong, nonatomic) NSString *data; // used to store data on unwind in order to display it in the fields.
@property (strong, nonatomic) IBOutlet UIButton *giveDirections; // button to send user inputs and get path.
@property (strong, nonatomic) IBOutlet UIButton *enterCode; // button to allow user to input code to get location.

/// A destination passed to Navigation from another view.
@property NSString *dest;

@end
