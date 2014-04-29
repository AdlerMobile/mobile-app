//
//  EachMapViewController.h
//  Adler Navigation
//
//  Created by Rohan Shah on 3/12/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EachMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *FloorMap;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarItem;

/// Adler level to be displayed by the map view (passed by segue).
@property (strong, nonatomic) NSString *levelToDisplay;

@end
