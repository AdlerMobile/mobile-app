//
//  AboutDetailsViewController.h
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/28/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutDetailsViewController : UIViewController

@property (strong, nonatomic) NSString * data;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIView *sponsorView;
@property (strong, nonatomic) IBOutlet UIView *howToUseView;

@property (strong, nonatomic) IBOutlet UIWebView *howToUse;
@property (strong, nonatomic) IBOutlet UIImageView *uiucLogo;

@end
