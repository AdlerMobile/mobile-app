//
//  MapViewController.h
//  Adler Navigation
//
//  Created by Ahaan Ugale on 11/22/13.
//  Copyright (c) 2013 Adler Planetarium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"
#import "MapGraph.h"

@interface MapViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// TODO: Move these to NavigateTableViewController

/**
 *  <#Description#>
 *
 *  @param graph  <#graph description#>
 *  @param source <#source description#>
 *  @param goal   <#goal description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableArray*) dijkstra: (MapGraph *)graph  from:(Node *)source to:(Node *)goal;

/**
 *  <#Description#>
 *
 *  @param source      <#source description#>
 *  @param destination <#destination description#>
 *  @param path        <#path description#>
 *  @param mg          <#mg description#>
 *  @param page        <#page description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableData *)drawPathFromSource:(Node *)source destination:(Node *)destination path:(NSArray *)path graph:(MapGraph *)mg onPDF:(CGPDFPageRef)page;

/**
 *  <#Description#>
 *
 *  @param points <#points description#>
 *  @param path   <#path description#>
 *  @param count  <#count description#>
 *  @param page   <#page description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableData *)drawLineSegments:(CGPoint *)points path:(CGPoint *)path count:(size_t)count onPDF:(CGPDFPageRef)page;

@end
