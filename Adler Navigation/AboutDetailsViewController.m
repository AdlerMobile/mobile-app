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
    
    [self.navItem setTitle:_data];
    
    //Preparing view for how to use this app.
    if ([_data isEqualToString:@"How to Use This App"])
    {
        self.sponsorView.hidden = YES;
        self.howToUseView.hidden = NO;
        
        //to load pdf which contains instructions on using this app.
        NSString *myPdfFilePath = [[NSBundle mainBundle] pathForResource: @"Adler_Intro" ofType: @"pdf"];
    
        NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        
        //loading the pdf in a UIWebView.
        [_howToUse loadRequest:request];
    }
    
    //Preparing view for Sponsored By.
    if ([_data isEqualToString:@"getSponsors"])
    {
        self.sponsorView.hidden = NO;
        self.howToUseView.hidden = YES;
        //displaying the U of I logo as an UIImageView.
        _uiucLogo.image = [UIImage imageNamed:@"uiuc_logo.png"];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
