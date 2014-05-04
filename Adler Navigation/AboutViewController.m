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
    
    //UIImageView *background = (UIImageView *)[self.view viewWithTag:5];
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 360, 568)];
    [background setImage:[UIImage imageNamed: @"about.png"]];
    //background.image=[UIImage imageNamed:@"image.png"];
    //background.contentMode = UIViewContentModeCenter;
    [self.view addSubview:background];
    
    //UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(250, 10, 40, 25)];

    

    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bt1 addTarget:self
            action:@selector(toTutorial:)
  forControlEvents:UIControlEventTouchUpInside];
    [bt1 setTitle:@"How to use this app" forState:UIControlStateNormal];
    [bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt1.frame = CGRectMake(80.0, 110.0, 160.0, 40.0);
    bt1.layer.borderWidth = 1.5f;
    bt1.layer.cornerRadius = 9.0f;
    [bt1.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.view addSubview:bt1];
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bt2 addTarget:self
            action:@selector(toIntro:)
  forControlEvents:UIControlEventTouchUpInside];
    [bt2 setTitle:@"Intro to Adler" forState:UIControlStateNormal];
    [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt2.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    bt2.layer.borderWidth = 1.5f;
    bt2.layer.cornerRadius = 9.0f;
    [bt2.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.view addSubview:bt2];

    
    UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bt3 addTarget:self
            action:@selector(toWebsite:)
  forControlEvents:UIControlEventTouchUpInside];
    [bt3 setTitle:@"Go to Adler Website" forState:UIControlStateNormal];
    [bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt3.frame = CGRectMake(80.0, 310.0, 160.0, 40.0);
    bt3.layer.borderWidth = 1.5f;
    bt3.layer.cornerRadius = 9.0f;
    [bt3.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.view addSubview:bt3];

    
    UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bt4 addTarget:self
            action:@selector(toSponsors:)
  forControlEvents:UIControlEventTouchUpInside];
    [bt4 setTitle:@"About Sponsors" forState:UIControlStateNormal];
    [bt4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt4.frame = CGRectMake(80.0, 410.0, 160.0, 40.0);
    bt4.layer.borderWidth = 1.5f;
    bt4.layer.cornerRadius = 9.0f;
    [bt4.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.view addSubview:bt4];
    
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

- (IBAction) toTutorial: (id)sender
{
    [self performSegueWithIdentifier: @"getTutorial" sender: self];
}



- (IBAction)toWebsite:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.adlerplanetarium.org"]];
}

- (IBAction) toIntro: (id)sender
{
    [self performSegueWithIdentifier: @"getAdlerIntro" sender: self];
}

- (IBAction) toSponsors: (id)sender
{
    [self performSegueWithIdentifier: @"getSponsors" sender: self];
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
       vc.data = @"getAdlerIntro";
    }

}


@end
