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

/**
 * viewWillAppear used to set the navigation bar hidden in order to display a full page image of Adler.
 */
-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //sets background color
    //self.view.backgroundColor = [UIColor colorWithRed:215.0/255 green:255.0/255 blue:240.0/255 alpha:1.0];
    
    //sets the image to be home2.png. To modify the home image add image to project and change the name of image here.
    _HomeImage.image = [UIImage imageNamed:@"home2.png"];
    
    //button design with the rectangualar box.
    //Connects to AboutThisAppViewController.
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderWidth = 1.5f;
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
