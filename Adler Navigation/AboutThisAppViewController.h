//
//  AboutThisAppViewController.h
//  Adler Planetarium
//
//  Created by Rohan Shah on 4/28/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * Simple Table View Controller for page About This App.
 * Displays three things 
 * - How to Use This App
 * - Adler Website
 * - Sponsored By
 * Connects to AboutDetailsViewController.
 */
@interface AboutThisAppViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
