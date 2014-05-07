//
//  TutorialViewController.m
//  Adler Planetarium
//
//  Created by Shi Qiu on 5/1/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

/**
 *  <#Description#>
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _pageTitles = @[@"Get to know Adler",@"Choose your location and desination", @"Enter code to find out where you are", @"View current exhibits Adler has to offer", @"Check the openning hours", @"Make sure you catch the events on time", @"All you need at your fingertips"];
    _pageImages = @[@"hp5.png", @"navi5.png", @"code5.png", @"exhi5.png", @"hours5.png", @"shows5.png", @"faci5.png" ];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-33);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

/**
 *  <#Description#>
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Page View Controller Data Source
/**
 *  <#Description#>
 *
 *  @param pageViewController <#pageViewController description#>
 *  @param viewController     <#viewController description#>
 *
 *  @return <#return value description#>
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

/**
 *  <#Description#>
 *
 *  @param pageViewController <#pageViewController description#>
 *  @param viewController     <#viewController description#>
 *
 *  @return <#return value description#>
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

/**
 *  <#Description#>
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

/**
 *  <#Description#>
 *
 *  @param pageViewController <#pageViewController description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

/**
 *  <#Description#>
 *
 *  @param pageViewController <#pageViewController description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)startWalkthrough:(id)sender {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}


@end
