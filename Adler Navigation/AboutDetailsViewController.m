//
//  AboutDetailsViewController.m
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/28/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "AboutDetailsViewController.h"

@interface AboutDetailsViewController ()

@end

@implementation AboutDetailsViewController

- (void)viewDidLoad
{
    
    
    //Preparing view for how to use this app.
    if ([_data isEqualToString:@"getFAQ"])
    {
        self.sponsorView.hidden = YES;
        self.howToUseView.hidden = NO;
        
        [self.navItem setTitle:@"FAQ"];
    }
    
    //Preparing view for Sponsored By.
    if ([_data isEqualToString:@"getSponsors"])
    {
        self.sponsorView.hidden = NO;
        self.howToUseView.hidden = YES;
        [self.navItem setTitle:@"Sponsors"];
        
        //displaying the U of I logo as an UIImageView.
        _uiucLogo.image = [UIImage imageNamed:@"uiuc_logo.png"];
    }
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
