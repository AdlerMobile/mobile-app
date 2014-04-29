//
//  HomeViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/12/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:215.0/255 green:255.0/255 blue:240.0/255 alpha:1.0];
    _HomeImage.image = [UIImage imageNamed:@"home2.png"];
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.borderWidth = 1.5f;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    btn.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
