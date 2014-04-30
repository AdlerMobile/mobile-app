//
//  NavigateTableViewController.m
//  Adler Navigation
//
//  Created by Rohan Shah on 3/16/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "NavigateTableViewController.h"
#import "MapGraph.h"
#import "Node.h"


@interface NavigateTableViewController ()
@property (nonatomic) BOOL isImageTransition;
@end

@implementation NavigateTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_view1 setHidden:YES];
    _view1.scrollView.bounces = NO;
    _view2.scrollView.bounces = NO;
    
    _isImageTransition = YES;
    
    //[_nextImage setTintColor:[UIColor blueColor]];
    //[_nextImage setIncrementImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    //[_nextImage setDecrementImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];

    _mg = [[MapGraph alloc] init];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"map_data_all" ofType:@"plist"];
    [_mg createGraphFromFile:filePath];
    Node* pointA =  [_mg getNodeById:_source];
    
    if ([_destination isEqualToString:@"Men's Restroom"]) {
        float bestDistance = MAXFLOAT;
        for (Node *n in [[_mg nodes] allValues]) {
            if ([[n id] rangeOfString:@"Men's Restroom"].location != NSNotFound) {
                //NSLog(@"%@", [n id]);
                NSMutableArray *p = [MapViewController dijkstra:_mg from:pointA to:n];
                float distance = [self pathTotalDistance:p];
                if (distance < bestDistance) {
                    _path = p;
                    bestDistance = distance;
                }
            }
        }
        
    }
    else if ([_destination isEqualToString:@"Women's Restroom"]) {
        float bestDistance = MAXFLOAT;
        for (Node *n in [[_mg nodes] allValues]) {
            if ([[n id] rangeOfString:@"Women's Restroom"].location != NSNotFound) {
                //NSLog(@"%@", [n id]);
                NSMutableArray *p = [MapViewController dijkstra:_mg from:pointA to:n];
                float distance = [self pathTotalDistance:p];
                if (distance < bestDistance) {
                    _path = p;
                    bestDistance = distance;
                }
            }
        }
        
    }
    else if([_destination isEqualToString:@"Nearest Exit"]) {
        float bestDistance = MAXFLOAT;
        for (Node *n in [[_mg nodes] allValues]) {
            if ([[n id] rangeOfString:@"getout"].location != NSNotFound) {
                //NSLog(@"%@", [n id]);
                NSMutableArray *p = [MapViewController dijkstra:_mg from:pointA to:n];
                float distance = [self pathTotalDistance:p];
                if (distance < bestDistance) {
                    _path = p;
                    bestDistance = distance;
                }
            }
        }
    }
    else {
        Node* pointB = [_mg getNodeById:_destination];
        _path = [MapViewController dijkstra:_mg from:pointA to:pointB];
    }
    
    self.nextImage.maximumValue = ([_path count] - 2);
    
    _n1 = [_path objectAtIndex:0];
    _n2 = [_path objectAtIndex:1];
    
    [self drawPath:_view1 node1:_n1 node2:_n2];
    
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(swapViews) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    NSUInteger value = sender.value;
    _n1 = [_path objectAtIndex:value];
    _n2 = [_path objectAtIndex:value+1];
    
    UIWebView *nextView;
    if ([_view1 isHidden]) {
        nextView = _view1;
    } else {
        nextView = _view2;
    }
    
    [self drawPath:nextView node1:_n1 node2:_n2];
    
    // instead of this, use 3 webviews and keep next and previous views pre rendered?
    [NSTimer scheduledTimerWithTimeInterval:.045 target:self selector:@selector(swapViews) userInfo:nil repeats:NO];
}

- (void)drawPath:(UIWebView *)view node1:(Node *)n1 node2:(Node *)n2
{
    [[self textDirection] setText:@""];
    if ([n1.floor isEqualToString:n2.floor]) {
        NSString *myPdfFilePath  = [[NSBundle mainBundle] pathForResource:n1.floor ofType: @"pdf"];
        NSURL *targetURL = [NSURL fileURLWithPath:myPdfFilePath];
        CGPDFDocumentRef document = CGPDFDocumentCreateWithURL ((CFURLRef)targetURL);
        _page = CGPDFDocumentGetPage(document, 1);
        
        NSMutableArray *pathVisible = [[NSMutableArray alloc] init];
        for (Node *n in _path) {
            if ([n.floor isEqualToString:n1.floor]) {
                [pathVisible addObject:n];
            }
        }
        
        NSData *data = [MapViewController drawPathFromSource:n1 destination:n2 path:pathVisible graph:_mg onPDF:_page];
        
        [view loadData:data MIMEType:@"application/pdf" textEncodingName:nil baseURL:nil];
        
        Edge *e = [[self mg] getEdgeFrom:n1 to:n2];
        [[self textDirection] setText:[e textDirection]];
        
        [[self pinchLabel] setHidden:NO];
    }
    else {
        _isImageTransition = YES;
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
        
        [[self textDirection] setText:[NSString stringWithFormat:@"Take the stairs/elevator %@ %d level%@.", direction, levelChange, levelChange==1? @"" : @"s"]];
        
        [[self pinchLabel] setHidden:YES];
        
        // TODO: display how many floors to go up/down
    }
}

- (void)swapViews
{
    UIWebView *curView;
    UIWebView *nextView;
    if ([_view1 isHidden]) {
        curView = _view2;
        nextView = _view1;
    } else {
        curView = _view1;
        nextView = _view2;
    }
    
    if ([_n1.floor isEqualToString:_n2.floor]) {
        [self copyZoomFrom:[curView scrollView] to:[nextView scrollView]];
    }
    
    [[nextView scrollView] setBounces:NO];
    [nextView setHidden:NO];
    [curView setHidden:YES];
    
    if ([_n1.floor isEqualToString:_n2.floor] && ![_n1.floor isEqualToString:@"star"]) {
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(zoomOnArrow:) userInfo:nextView repeats:NO];
    }
}

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
    
    //NSLog( @"Visible rect: %@", NSStringFromCGRect(visibleRect) );
    
    [next zoomToRect:visibleRect animated:NO];
}

- (void)zoomOnArrow:(NSTimer *)timer
{
    UIScrollView *view = [[timer userInfo] scrollView];
    
    static float scaleFactorX;
    static float scaleFactorY;
    if ([_n1.floor isEqualToString:_n2.floor] && _isImageTransition) {
        CGRect pageRect = CGPDFPageGetBoxRect(_page, kCGPDFArtBox);
        scaleFactorX = view.contentSize.width / pageRect.size.width;
        scaleFactorY = view.contentSize.height / pageRect.size.height;
        _isImageTransition = NO;
    }
    float centerX = (_n1.xCoordinate + _n2.xCoordinate) / 2.0 * scaleFactorX;
    float centerY = (_n1.yCoordinate + _n2.yCoordinate) / 2.0 * scaleFactorY;
    
    float zoomScale = 3.0;
    
    CGRect rect;
    rect.size = CGSizeMake(view.bounds.size.width / zoomScale,
                           view.bounds.size.height / zoomScale);
    rect.origin = CGPointMake(centerX-rect.size.width/2, centerY-rect.size.height/2);
    
    if (rect.origin.x < 0) {
        rect.origin.x = 0;
    } else if (rect.origin.x >= view.bounds.size.width - rect.size.width) {
        rect.origin.x = view.bounds.size.width - rect.size.width - 1;
    }
    if (rect.origin.y < 0) {
        rect.origin.y = 0;
    } else if (rect.origin.y >= view.bounds.size.height - rect.size.height) {
        rect.origin.y = view.bounds.size.height - rect.size.height - 1;
    }
    
    //NSLog( @"Rect: %@", NSStringFromCGRect(rect) );
    //NSLog( @"Center: {%f,%f}", centerX, centerY);
    
    [view zoomToRect:rect animated:YES];
}

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
