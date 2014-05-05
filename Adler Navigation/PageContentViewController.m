//
//  PageContentViewController.m
//  Adler Planetarium
//
//  Created by Shi Qiu on 5/1/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end


@implementation PageContentViewController

/**
 *  <#Description#>
 *
 *  @param nibNameOrNil   <#nibNameOrNil description#>
 *  @param nibBundleOrNil <#nibBundleOrNil description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/**
 *  <#Description#>
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.back.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
}

/**
 *  <#Description#>
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
