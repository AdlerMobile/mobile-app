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
    
    if ([_data isEqualToString:@"How to Use This App"])
    {
        self.sponsorView.hidden = YES;
        self.howToUseView.hidden = NO;
        
        NSString *myPdfFilePath = [[NSBundle mainBundle] pathForResource: @"Adler Mobile Navigation App Documentation" ofType: @"pdf"];
    
        NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        
        [_howToUse loadRequest:request];
    }
    
    if ([_data isEqualToString:@"Sponsored By"])
    {
        self.sponsorView.hidden = NO;
        self.howToUseView.hidden = YES;
        _uiucLogo.image = [UIImage imageNamed:@"uiuc_logo.png"];
    }
    
    NSLog(@"%@", _data);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
