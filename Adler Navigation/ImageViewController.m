//
//  ImageViewController.m
//  Adler Navigation
//
//  Created by Shi Qiu on 4/20/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "ImageViewController.h"
#import "NavigationInputViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

/**
 *  <#Description#>
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    if(self.curExhibit){
        [_navBar setTitle:_curExhibit.ID];
        self.longDetails.editable = NO;
        self.longDetails.text = self.curExhibit.description;
        self.display.image = self.curExhibit.images[0];
        if ([self.curExhibit.ID isEqualToString: @"Hidden Wonders"]||
            [self.curExhibit.ID isEqualToString: @"Sundials"]){
            _naviButton.hidden = YES;
        }
        UITextView *tv = self.longDetails;
        tv.backgroundColor = [UIColor blackColor];
        tv.textColor = [UIColor whiteColor];
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:100];
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal ];
        btn.layer.borderWidth = 1.5f;
        btn.layer.borderColor = [[UIColor whiteColor] CGColor];
        btn.layer.cornerRadius = 9.0f;
    }
}

/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)toNavigate:(id)sender {
}

/**
 *  <#Description#>
 *
 *  @param value <#value description#>
 */
- (void) setCurrentExhibit:(Exhibit*)value {
    _curExhibit = value;
}

/**
 *  <#Description#>
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  <#Description#>
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NavigateToExhibit"]) {
        NavigationInputViewController *tc = [segue destinationViewController];
        NSString *str = _curExhibit.ID;
        tc.dest = str;
    }
}


@end
