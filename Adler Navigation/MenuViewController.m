//
//  MenuViewController.m
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/30/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *myPdfFilePath  = [[NSBundle mainBundle] pathForResource:@"galileo_menu_2014" ofType: @"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
    [_displayMenu loadRequest:[NSURLRequest requestWithURL:targetURL]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
