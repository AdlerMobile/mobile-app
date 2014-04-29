//
//  AboutThisAppViewController.m
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/28/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "AboutThisAppViewController.h"
#import "AboutDetailsViewController.h"

@interface AboutThisAppViewController ()

@end

@implementation AboutThisAppViewController

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"How to Use This App";
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Adler Website";
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = @"Sponsored By";
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.adlerplanetarium.org"]];
    }
    
    else
    {
        [self performSegueWithIdentifier:@"details" sender:self];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //Sends data to the view controller to display instructions on how to use this app.
    if ([[segue identifier] isEqualToString:@"details"])
    {
        AboutDetailsViewController * vc = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:myIndexPath];
        NSString *str = cell.textLabel.text;
        
        if ([str isEqualToString:@"How to Use This App"])
        {
            vc.data = @"How to Use This App";
        }
        
        if ([str isEqualToString:@"Sponsored By"])
        {
            vc.data = @"Sponsored By";
        }
        
    
    }
    
    
 }




@end
