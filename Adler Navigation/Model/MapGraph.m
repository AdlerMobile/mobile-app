//
//  MapGraph.m
//  Adler Navigation
//
//  Created by Ahaan Ugale on 11/15/13.
//  Copyright (c) 2013 Adler Planetarium. All rights reserved.
//

#import "MapGraph.h"

@implementation MapGraph

- (id)init
{
    self = [super init];
    if (self)
    {
        _nodes = [[NSMutableDictionary alloc] init];
        _adjacencyMatrix = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addNode:(Node *)node
{
    if (node.id == nil)
    {
        NSLog(@"Warning: ID not defined for node");
        node.id = [NSString stringWithFormat:@"(%f,%f,%@)", node.xCoordinate,
                   node.yCoordinate, node.floor];
    }
    if ([_adjacencyMatrix objectForKey:node] == nil)
    {
        [_nodes setObject:node forKey:node.id];
        NSMutableDictionary *adjacentNodes = [[NSMutableDictionary alloc] init];
        [_adjacencyMatrix setObject:adjacentNodes forKey:node];
    }
}

- (void)addEdge:(Edge *)edge
{
    // make sure nodes exist
    [self addNode:edge.node1];
    [self addNode:edge.node2];
    
    [[_adjacencyMatrix objectForKey:edge.node1] setObject:edge forKey:edge.node2];
}

- (void)addEdgeFromNode:(NSString *)nodeId1 toNode:(NSString *)nodeId2 textDirection:(NSString *)textDirection
{
    Node *n1 = [_nodes objectForKey:nodeId1];
    Node *n2 = [_nodes objectForKey:nodeId2];
    
    // make sure nodes exist
    if (n1 == nil || n2 == nil) {
        return;
    }
    
    Edge *e = [[Edge alloc]init];
    e.node1 = n1;
    e.node2 = n2;
    e.textDirection = textDirection;
    [self addEdge:e];
}

- (Node *)getNodeById:(NSString *)id
{
    return [_nodes objectForKey:id];
}

- (Edge *)getEdgeFrom:(Node *)n1 to:(Node *)n2
{
    return [[[self adjacencyMatrix] objectForKey:n1] objectForKey:n2];
}

/**
 * Returns a set of Edge objects
 */
- (NSSet *)getAdjacentNodes:(Node *)node
{
    return [NSSet setWithArray:[[[self adjacencyMatrix] objectForKey:node] allValues]];
}

/**
 * Returns an array of UIDs for adjacent nodes
 */
- (NSArray *)getIDsOfAdjacentNodes:(Node *)node
{
    NSMutableArray * adjacentNodeUIDs = [[NSMutableArray alloc] init];
    NSSet * edges = [self getAdjacentNodes:node];
    for(Edge * currentEdge in edges) {
        NSString * node1ID = currentEdge.node1.id;
        NSString * node2ID = currentEdge.node2.id;
        
        if(![node1ID isEqualToString:node.id]) {
            [adjacentNodeUIDs addObject:node1ID];
        }
        
        if(![node2ID isEqualToString:node.id]) {
            [adjacentNodeUIDs addObject:node2ID];
        }
    }
    
    return adjacentNodeUIDs;
}

- (void)addGraphNodesFromFile:(NSString *)filePath
{
    NSArray * nodeDataArray = [[NSArray alloc] initWithContentsOfFile:filePath];    //array containing dict objects
    
    for(id nodeDict in nodeDataArray){
        NSString * uniqueID = [nodeDict objectForKey:@"uid"];
        NSNumber * xCoordinate = [nodeDict objectForKey:@"x"];
        NSNumber * yCoordinate = [nodeDict objectForKey:@"y"];
        NSString * floor = [nodeDict objectForKey:@"floor"];
        
        Node * newNode = [[Node alloc] init];
        
        newNode.xCoordinate = [xCoordinate floatValue];
        newNode.yCoordinate = [yCoordinate floatValue];
        newNode.floor = floor;
        newNode.id = uniqueID;
        
        // This is a hack: remove this after fixing plist files
        if ([floor isEqualToString:@"lower"]) {
            newNode.xCoordinate -= 14.5;
        }
        
        [self addNode:newNode];
    }
}

- (void)addGraphEdgesFromFile:(NSString *)filePath
{
    NSArray * nodeDataArray = [[NSArray alloc] initWithContentsOfFile:filePath];    //array containing dict objects
    
    for(id nodeDict in nodeDataArray) {
        NSString * uniqueID = [nodeDict objectForKey:@"uid"];
        NSArray * adjacentNodes = [nodeDict objectForKey:@"adjacent"];
        
        for(NSString *nodeString in adjacentNodes) {
            NSString *id, *textDirection;
            NSUInteger splitIndex = [nodeString rangeOfString:@"^^"].location;
            if (splitIndex != NSNotFound) {
                id = [nodeString substringToIndex:splitIndex];
                if (splitIndex+2 < [nodeString length]) {
                    textDirection = [nodeString substringFromIndex:splitIndex+2];
                }
                NSLog(@"%@:%@", id, textDirection);
            } else {
                id = nodeString;
                textDirection = @"";
            }
            [self addEdgeFromNode:uniqueID toNode:id textDirection:textDirection];
        }
    }
}

- (void) createGraphFromFile:(NSString *) filePath
{
    //should the destructor be called here to clear out existing data in the graph?
    [self addGraphNodesFromFile:filePath];
    [self addGraphEdgesFromFile:filePath];
}

@end