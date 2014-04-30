//
//  HomeViewController.h
//  Adler Navigation
//
//  Created by Rohan Shah on 3/12/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * View Controller for the Home Page i.e Home Tab.
 */
@interface HomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *HomeImage; //image view displaying the image on home page.
@property (weak, nonatomic) IBOutlet UIButton *tutorial; //connected to the button which opens view with about this app.
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar; //connected to the navigation item.


@end
