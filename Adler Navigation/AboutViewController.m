//
//  AboutViewController.m
//  Adler Planetarium
//
//  Created by Shi Qiu on 5/1/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *adlerIntro = (UIButton *)[self.view viewWithTag:1];
    adlerIntro.layer.cornerRadius = 9.0f;
    
    UIButton *appTutorial = (UIButton *)[self.view viewWithTag:2];
    appTutorial.layer.cornerRadius = 9.0f;
    
    UIButton *adlerWebsite = (UIButton *)[self.view viewWithTag:3];
    adlerWebsite.layer.cornerRadius = 9.0f;
    
    UIButton *appSponsors = (UIButton *)[self.view viewWithTag:4];
    appSponsors.layer.cornerRadius = 9.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goToWebsite:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.adlerplanetarium.org"]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"getSponsors"])
    {
        AboutDetailsViewController * vc = [segue destinationViewController];
        vc.data = @"getSponsors";
    }
    if ([[segue identifier] isEqualToString:@"getAdlerIntro"])
    {
       AboutDetailsViewController * vc = [segue destinationViewController];
       vc.data = @"How to Use This App";
    }

}


@end
