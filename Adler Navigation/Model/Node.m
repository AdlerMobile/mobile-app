//
//  Node.m
//  Adler Navigation
//
//  Created by Ahaan Ugale on 11/15/13.
//  Copyright (c) 2013 Adler Planetarium. All rights reserved.
//

#import "Node.h"

@implementation Node

- (id)copyWithZone:(NSZone *)zone
{
    Node *copyNode = [[[self class] allocWithZone:zone] init];
    copyNode.xCoord = _xCoord;
    copyNode.yCoord = _yCoord;
    return copyNode;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    return [self isEqualToNode:other];
}

- (BOOL)isEqualToNode:(Node *)otherNode
{
    return _xCoord == otherNode.xCoord
            && _yCoord == otherNode.yCoord;
}

- (NSUInteger)hash
{
    NSUInteger prime = 31;
    NSUInteger hash = 1;
    
    hash = hash * prime + _xCoord;
    hash = hash * prime + _yCoord;
    
    return hash;
}

@end
