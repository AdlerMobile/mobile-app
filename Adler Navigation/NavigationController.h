//
//  NavigateTableViewController.h
//  Adler Navigation
//
//  Created by Rohan Shah on 3/16/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

/**
 * NavigationController handles the display of the generated path from the location of the user to
 * the destination.
 */
@interface NavigationController : UIViewController

/// Node id of the current location.
@property (strong, nonatomic) NSString * source;

/// Node id of the destination.
@property (strong, nonatomic) NSString * destination;

/// One of the two webviews which will display the map and path.
@property (strong, nonatomic) IBOutlet UIWebView *view1;

/// One of the two webviews which will display the map and path.
@property (strong, nonatomic) IBOutlet UIWebView *view2;

/// The stepper to move between steps in the directions.
@property (strong, nonatomic) IBOutlet UIStepper *stepper;

/// The label to display the direction in text form.
@property (strong, nonatomic) IBOutlet UILabel *textDirection;

/// The label which displays the pinch to zoom instruction.
@property (strong, nonatomic) IBOutlet UILabel *pinchLabel;



/**
 * The method to handle a change in value of the stepper. It shows the next/previous step in the
 * directions.
 */
- (IBAction)stepperValueChanged:(UIStepper *)sender;

@end
