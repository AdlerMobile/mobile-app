//
//  FacilityDetailViewController.m
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/30/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "FacilityDetailViewController.h"
#import "NavigationViewController.h"
#import "MenuViewController.h"

@interface FacilityDetailViewController ()

@end

@implementation FacilityDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_navBar setTitle:_data];
    _navButton.layer.borderWidth = 1.5f;
    _navButton.layer.borderColor = [[UIColor blackColor] CGColor];
    _navButton.layer.cornerRadius = 10.0f;
    //self.view.backgroundColor = [UIColor blackColor];
    //_textDescription.backgroundColor = [UIColor blackColor];
    //_textDescription.textColor = [UIColor whiteColor];
    if ([_data isEqualToString:@"Café Galileo's"]) {
        _textDescription.text = @"For a nice, relaxing lunch and the best view of the Chicago Skyline there's nowhere better than Café Galileo’s. Café Galileo’s provides a variety of freshly prepared options, including a large selection of beverages, soups, sandwiches, salads and desserts.";
        _image.image = [UIImage imageNamed:@"cafe.jpg"];
        _onlineStoreButton.hidden = YES;
        _viewMenuButton.hidden = NO;
        _viewMenuButton.layer.borderWidth = 1.5f;
        _viewMenuButton.layer.borderColor = [[UIColor blackColor] CGColor];
        _viewMenuButton.layer.cornerRadius = 10.0f;
    }
    
    if ([_data isEqualToString:@"Adler Store"]) {
        _textDescription.text = @"Our museum store offers something for everyone, from toddlers to senior citizens. You'll find educational toys and games, unique jewelry, books and videos, and much more. Proceeds from your purchase support scientific research and learning programs that reach school students throughout the Midwest.";
        _image.image = [UIImage imageNamed:@"store.jpg"];
        _viewMenuButton.hidden = YES;
        _onlineStoreButton.hidden = NO;
        _onlineStoreButton.layer.borderWidth = 1.5f;
        _onlineStoreButton.layer.borderColor = [[UIColor blackColor] CGColor];
        _onlineStoreButton.layer.cornerRadius = 10.0f;
        
    }
    
    // Do any additional setup after loading the view.
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"takeToFacility"]) {
    NavigationViewController * vc = [segue destinationViewController];
    vc.dest = _data;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)viewOnlineStore {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://adlerplanetarium.ordercompletion.com"]];
}

@end
