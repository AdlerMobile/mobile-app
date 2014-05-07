//
//  NavigateTableViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/16/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "NavigationController.h"
#import "MapGraph.h"
#import "Node.h"


@interface NavigationController ()

/// The MapGraph generated from the plist file.
@property (strong, nonatomic) MapGraph *mg;

/// The path of Nodes between source and destination.
@property (strong, nonatomic) NSArray * path;

/// The pdf page containing the image of the current level.
@property (nonatomic) CGPDFPageRef page;

/// The first Node of the current step.
@property (strong, nonatomic) Node *n1;

/// The second Node of the current step.
@property (strong, nonatomic) Node *n2;

/// This indicates if the new image to be displayed will be of a different floor.
@property (nonatomic) BOOL isImageTransition;

@end



@implementation NavigationController

/**
 * On loading of the view, this creates the MapGraph, finds the two Node objects, and displays the
 * map and the path on the first UIWebView.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view1 setHidden:YES]; // This view will be unhidden in the swapViews call below
    self.view1.scrollView.bounces = NO;
    self.view2.scrollView.bounces = NO;
    
    self.isImageTransition = YES;

    self.mg = [[MapGraph alloc] init];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"map_data_all" ofType:@"plist"];
    [self.mg createGraphFromFile:filePath];
    Node* pointA =  [self.mg getNodeById:self.source];
    
    if ([self.destination isEqualToString:@"Men's Restroom"]) {
        self.path = [self findBestPathFromNode:pointA toNodeWithIdSubstring:@"Men's Restroom"];
    }
    else if ([self.destination isEqualToString:@"Women's Restroom"]) {
        self.path = [self findBestPathFromNode:pointA toNodeWithIdSubstring:@"Women's Restroom"];
    }
    else if([self.destination isEqualToString:@"Nearest Exit"]) {
        self.path = [self findBestPathFromNode:pointA toNodeWithIdSubstring:@"getout"];
    }
    else {
        Node* pointB = [self.mg getNodeById:self.destination];
        self.path = [MapViewController dijkstra:self.mg from:pointA to:pointB];
    }
    
    self.stepper.maximumValue = ([self.path count] - 2);
    
    self.n1 = [self.path objectAtIndex:0];
    self.n2 = [self.path objectAtIndex:1];
    
    [self drawPath:self.view1 node1:self.n1 node2:self.n2];
    
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(swapViews)
                                   userInfo:nil repeats:NO];
}

/**
 *  Finds the best path from the source node to some node whose id contains the given substring.
 *
 *  @param source      The source Node.
 *  @param idSubstring The substring that the destination Node's id contains.
 *
 *  @return The array of Nodes that is the best path.
 */
- (NSArray *)findBestPathFromNode:(Node *)source toNodeWithIdSubstring:(NSString *)idSubstring
{
    NSArray *bestPath = nil;
    float bestDistance = MAXFLOAT;
    
    for (Node *n in [[self.mg nodes] allValues]) {
        if ([[n id] rangeOfString:idSubstring].location != NSNotFound) {
            NSArray *p = [MapViewController dijkstra:self.mg from:source to:n];
            float distance = [self pathTotalDistance:p];
            
            if (distance < bestDistance) {
                bestPath = p;
                bestDistance = distance;
            }
        }
    }
    
    return bestPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Shows the next/previous step in the directions based on the value of the stepper.
 *
 *  @param sender The UIStepper that specifies which step of the directions to display.
 */
- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    NSUInteger value = sender.value;
    self.n1 = [self.path objectAtIndex:value];
    self.n2 = [self.path objectAtIndex:value+1];
    
    UIWebView *nextView;
    if ([self.view1 isHidden]) {
        nextView = self.view1;
    } else {
        nextView = self.view2;
    }
    
    [self drawPath:nextView node1:self.n1 node2:self.n2];
    
    // TODO: instead of this, use 3 webviews and keep next and previous views pre rendered
    [NSTimer scheduledTimerWithTimeInterval:.045 target:self selector:@selector(swapViews)
                                   userInfo:nil repeats:NO];
}

/**
 *  Displays the next direction on the given UIWebView.
 *
 *  Draws an arrow from Node n1 to Node n2, if they are on the same floor. Otherwise, displays the
 *  floor change image. Displays the text direction at the label.
 *
 *  @param view The UIWebView to draw the arrow on.
 *  @param n1   The Node at which to begin the arrow.
 *  @param n2   The Node at which to end the arrow.
 */
- (void)drawPath:(UIWebView *)view node1:(Node *)n1 node2:(Node *)n2
{
    [[self textDirection] setText:@""];
    
    if ([n1.id isEqualToString:@"Observatory"] || [n2.id isEqualToString:@"Observatory"]) {
        Node *exit, *obs;
        NSString *exitStr, *toOrFrom;
        
        if ([n1.id isEqualToString:@"Observatory"]) {
            obs = n1;
            exit = n2;
            toOrFrom = @"from";
        }
        else {
            obs = n2;
            exit = n1;
            toOrFrom = @"to";
        }
        
        if ([exit.id isEqualToString:@"getoutMain"]) {
            exitStr = @"main";
        }
        else if ([exit.id isEqualToString:@"getout33"] && [n1.id isEqualToString:@"Observatory"]) {
            exitStr = @"top_right";
        }
        else if ([exit.id isEqualToString:@"getout33"] ||[exit.id isEqualToString:@"getoutSouth"]) {
            exitStr = @"right";
        }
        else {
            exitStr = @"left";
        }
        NSString *filename = [NSString stringWithFormat:@"%@exit_%@_obs", exitStr, toOrFrom];
        NSString *myPdfFilePath  = [[NSBundle mainBundle] pathForResource:filename ofType: @"pdf"];
        NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
        [view loadRequest:[NSURLRequest requestWithURL:targetURL]];
        
        Edge *e = [[self mg] getEdgeFrom:n1 to:n2];
        [[self textDirection] setText:[e textDirection]];
        
        [[self pinchLabel] setHidden:YES];
    }
    else if ([n1.floor isEqualToString:n2.floor]) {
        NSString *myPdfFilePath  = [[NSBundle mainBundle] pathForResource:n1.floor ofType: @"pdf"];
        NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
        CGPDFDocumentRef document = CGPDFDocumentCreateWithURL ((CFURLRef)targetURL);
        self.page = CGPDFDocumentGetPage(document, 1);
        
        NSMutableArray *pathVisible = [[NSMutableArray alloc] init];
        for (Node *n in self.path) {
            if ([n.floor isEqualToString:n1.floor] && ![n.id isEqualToString:@"Observatory"]) {
                [pathVisible addObject:n];
            }
        }
        
        NSData *data = [MapViewController drawPathFromSource:n1 destination:n2 path:pathVisible
                                                       graph:self.mg onPDF:self.page];
        
        [view loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
        
        Edge *e = [[self mg] getEdgeFrom:n1 to:n2];
        [[self textDirection] setText:[e textDirection]];
        
        [[self pinchLabel] setHidden:NO];
    }
    else {
        self.isImageTransition = YES;
        int sourceFloorLevel = 0;
        int destinationFloorLevel = 0;
        
        if ([n1.floor isEqualToString:@"top"]) {
            sourceFloorLevel = 1;
        }
        else if ([n1.floor isEqualToString:@"mid"])
        {
            sourceFloorLevel = 2;
        }
        else if ([n1.floor isEqualToString:@"lower"])
        {
            sourceFloorLevel = 3;
        }
        else if ([n1.floor isEqualToString:@"star"])
        {
            sourceFloorLevel = 4;
        }
        
        if ([n2.floor isEqualToString:@"top"]) {
            destinationFloorLevel = 1;
        }
        else if ([n2.floor isEqualToString:@"mid"])
        {
            destinationFloorLevel = 2;
        }
        else if ([n2.floor isEqualToString:@"lower"])
        {
            destinationFloorLevel = 3;
        }
        else if ([n2.floor isEqualToString:@"star"])
        {
            destinationFloorLevel = 4;
        }
        
        NSString *myPdfFilePath;
        int levelChange;
        NSString *direction;
        if ((sourceFloorLevel - destinationFloorLevel) < 0) {
            myPdfFilePath  = [[NSBundle mainBundle] pathForResource:@"downstairs" ofType: @"pdf"];
            levelChange = destinationFloorLevel - sourceFloorLevel;
            direction = @"down";
        }
        else {
            myPdfFilePath  = [[NSBundle mainBundle] pathForResource:@"upstairs" ofType: @"pdf"];
            levelChange = sourceFloorLevel - destinationFloorLevel;
            direction = @"up";
        }
        
        NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
        [view loadRequest:[NSURLRequest requestWithURL:targetURL]];
        
        [[self textDirection]
         setText:[NSString stringWithFormat:@"Take the stairs/elevator %@ %d level%@.",
                  direction, levelChange, levelChange==1? @"" : @"s"]];
        
        [[self pinchLabel] setHidden:YES];
    }
}

/**
 *  Hides the currently displayed UIWebView, and displays the previously hidden one.
 */
- (void)swapViews
{
    UIWebView *curView;
    UIWebView *nextView;
    if ([self.view1 isHidden]) {
        curView = self.view2;
        nextView = self.view1;
    } else {
        curView = self.view1;
        nextView = self.view2;
    }
    
    if ([self.n1.floor isEqualToString:self.n2.floor]
        && ![self.n1.id isEqualToString:@"Observatory"]
        && ![self.n2.id isEqualToString:@"Observatory"]) {
        [self copyZoomFrom:[curView scrollView] to:[nextView scrollView]];
    }
    
    [[nextView scrollView] setBounces:NO];
    [nextView setHidden:NO];
    [curView setHidden:YES];
    
    if ([self.n1.floor isEqualToString:self.n2.floor] && ![self.n1.floor isEqualToString:@"star"]
         && ![self.n1.id isEqualToString:@"Observatory"]
         && ![self.n2.id isEqualToString:@"Observatory"]) {
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(zoomOnArrow:)
                                       userInfo:nextView repeats:NO];
    }
}

/**
 *  Zooms the next view to the zoom level and area of current view.
 *
 *  @param cur  The view whose zoom to copy.
 *  @param next The view to copy the zoom to.
 */
- (void)copyZoomFrom:(UIScrollView *)cur to:(UIScrollView *)next
{
    CGRect visibleRect;// = [next convertRect:next.bounds toView:cur];
    visibleRect.origin = cur.contentOffset;
    visibleRect.size = cur.bounds.size;
    double scale = 1.0 / [cur zoomScale];
    visibleRect.origin.x *= scale;
    visibleRect.origin.y *= scale;
    visibleRect.size.width *= scale;
    visibleRect.size.height *= scale;
    
    if (visibleRect.size.width == next.bounds.size.width) {
        visibleRect.size.width--;
    }
    if (visibleRect.size.height == next.bounds.size.height) {
        visibleRect.size.height--;
    }
    
    [next zoomToRect:visibleRect animated:NO];
}

/**
 *  Zooms the view around the displayed arrow.
 *
 *  @param timer The timer whose userInfo holds the scrollView to zoom.
 */
- (void)zoomOnArrow:(NSTimer *)timer
{
    UIScrollView *view = [[timer userInfo] scrollView];
    
    static float scaleFactorX;
    static float scaleFactorY;
    if ([self.n1.floor isEqualToString:self.n2.floor] && self.isImageTransition) {
        CGRect pageRect = CGPDFPageGetBoxRect(self.page, kCGPDFArtBox);
        scaleFactorX = view.contentSize.width / pageRect.size.width;
        scaleFactorY = view.contentSize.height / pageRect.size.height;
        self.isImageTransition = NO;
    }
    float centerX = (self.n1.xCoordinate + self.n2.xCoordinate) / 2.0 * scaleFactorX;
    float centerY = (self.n1.yCoordinate + self.n2.yCoordinate) / 2.0 * scaleFactorY;
    
    float zoomScale = 3.0;
    
    CGRect rect;
    rect.size = CGSizeMake(view.bounds.size.width / zoomScale,
                           view.bounds.size.height / zoomScale);
    rect.origin = CGPointMake(centerX-rect.size.width/2, centerY-rect.size.height/2);
    
    if (rect.origin.x < 0) {
        rect.origin.x = 0;
    }
    else if (rect.origin.x >= view.bounds.size.width - rect.size.width) {
        rect.origin.x = view.bounds.size.width - rect.size.width - 1;
    }
    
    if (rect.origin.y < 0) {
        rect.origin.y = 0;
    }
    else if (rect.origin.y >= view.bounds.size.height - rect.size.height) {
        rect.origin.y = view.bounds.size.height - rect.size.height - 1;
    }
    
    [view zoomToRect:rect animated:YES];
}

/**
 *  Calculates the total distance of the path.
 *
 *  @param path Array of the Nodes in the path.
 *
 *  @return Total distance as a float.
 */
- (float)pathTotalDistance:(NSArray *)path
{
    float distance = 0.0;
    
    for (int i = 0; i < [path count]-1; i++) {
        Edge *e = [[Edge alloc] init];
        e.node1 = [path objectAtIndex:i];
        e.node2 = [path objectAtIndex:i+1];
        distance += [e distance];
    }
    
    return distance;
}

@end
