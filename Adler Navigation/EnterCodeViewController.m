//
//  EnterCodeViewController.m
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/30/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "EnterCodeViewController.h"
#import "NavigationViewController.h"

@interface EnterCodeViewController ()

@end

@implementation EnterCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _inputField.keyboardType = UIKeyboardTypeNumberPad;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NavigationViewController * vc = [segue destinationViewController];
    
    vc.data = _inputField.text;
}

@end
