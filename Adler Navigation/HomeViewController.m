//
//  HomeViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/12/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "HomeViewController.h"

/**
 *  <#Description#>
 */
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

/**
 *  <#Description#>
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //sets the image to be home2.png. To modify the home image add image to project and change the name of image here.
    _HomeImage.image = [UIImage imageNamed:@"home2.png"];
    
    //button design with the rectangular box.
    //Connects to AboutThisAppViewController.
    UIButton *btn = (UIButton *)[self.view viewWithTag:100];
    btn.layer.borderWidth = 1.5f;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    btn.layer.cornerRadius = 10.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
