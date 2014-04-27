//
//  TableViewController.h
//  Adler Navigation
//
//  Created by Rohan Shah on 3/11/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *source;
@property (strong, nonatomic) IBOutlet UITextField *destination;
@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic) IBOutlet UIButton *giveDirections;
- (IBAction)editingChanged;


/// A destination passed to this view from the facilities view.
@property NSString *dest;

@end
