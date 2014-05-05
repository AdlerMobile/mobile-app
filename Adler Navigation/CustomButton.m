//
//  CustomButton.m
//  Adler
//
//  Created by Smit Patel on 5/4/14.
//  Copyright (c) 2014 Adler Planetarium. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1.5f;
    self.layer.cornerRadius = 9.0f;
}


@end
