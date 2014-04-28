//
//  MapGraphTests.m
//  Adler Navigation
//
//  Created by Ahaan Ugale on 11/20/13.
//  Copyright (c) 2013 Adler Planetarium. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MapGraph.h"

@interface MapGraphTests : XCTestCase

@end

@implementation MapGraphTests

MapGraph *g;
Node *n1;
Node *n2;
Node *n3;
Node *n4;
Edge *e12;
Edge *e13;

- (void)setUp
{
    [super setUp];
    
    g = [[MapGraph alloc] init];
    
    n1 = [[Node alloc] init];
    n1.id = @"n1";
    n1.xCoordinate = 1;
    n1.yCoordinate = 11;
    
    n2 = [[Node alloc] init];
    n2.id = @"n2";
    n2.xCoordinate = 2;
    n2.yCoordinate = 12;
    
    n3 = [[Node alloc] init];
    n3.id = @"n3";
    n3.xCoordinate = 3;
    n3.yCoordinate = 13;
    
    n4 = [[Node alloc] init];
    n4.id = @"n4";
    n4.xCoordinate = 4;
    n4.yCoordinate = 14;
    
    [g addNode:n1];
    [g addNode:n2];
    [g addNode:n3];
    [g addNode:n4];
    
    e12 = [[Edge alloc]init];
    e12.node1 = n1;
    e12.node2 = n2;
    
    e13 = [[Edge alloc]init];
    e13.node1 = n3;
    e13.node2 = n1;
    
    [g addEdge:e12];
    [g addEdge:e13];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testAddNode
{
    XCTAssertNotNil([[g nodes] objectForKey:@"n1"]);
    XCTAssertNotNil([[g nodes] objectForKey:[n4 id]]);
    
    Node *n = [[Node alloc] init];
    n.xCoordinate = 101;
    n.yCoordinate = 101;
    n.floor = @"top";
    XCTAssertNil([g.adjacencyMatrix objectForKey:n]);
    
}

- (void)testGetNodeById
{
    Node *n = [[Node alloc] init];
    n.xCoordinate = 102;
    n.yCoordinate = 102;
    n.floor = @"mid";
    n.id = @"test";
    
    XCTAssertNil([g getNodeById:n.id]);
    
    [g addNode:n];
    XCTAssertEqualObjects(n, [g getNodeById:n.id]);
}

- (void)testAdjacent
{
    NSSet *adjacent = [g getAdjacentNodes:n1];
    NSSet *expected = [NSSet setWithObjects:e12, nil];
    
    XCTAssertEqual([adjacent count], [expected count]);
    
    XCTAssertEqualObjects(adjacent, expected);
}

- (void)testCreateGraphFromFile
{
    MapGraph * testGraph = [[MapGraph alloc] init];
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"top" ofType:@"plist"];
    
    [testGraph createGraphFromFile:filePath];
    
    NSArray * nodeDataArray = [[NSArray alloc] initWithContentsOfFile:filePath];    //array containing dict objects
    
    for(id nodeDict in nodeDataArray){
        NSString * uniqueID = [nodeDict objectForKey:@"uid"];
        NSArray * adjacentNodes = [nodeDict objectForKey:@"adjacent"];
        
        Node * currentNodeInGraph = [testGraph getNodeById:uniqueID];
        XCTAssertNotNil(currentNodeInGraph);
        
        NSArray * setOfAdjacentNodes = [testGraph getIDsOfAdjacentNodes:currentNodeInGraph];
        
        for(NSString * adjacentNodeID in adjacentNodes) {
            XCTAssertTrue([setOfAdjacentNodes containsObject:adjacentNodeID]);
        }
    }
}

@end
