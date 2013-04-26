//
//  TouchHelper.m
//  EOW
//
//  Created by darren on 13-2-27.
//  Copyright (c) 2013年 Jason Zhang. All rights reserved.
//

#import "TouchHelper.h"

@implementation TouchHelper

CGPoint TouchLocation(UITouch *touch, CCNode *node)
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    touchLocation = [[node parent] convertToNodeSpace:touchLocation];
    return touchLocation;
}

BOOL IsTouchInside(UITouch *touch, CCNode *node)
{
    CGPoint location = TouchLocation(touch, node);
    return CGRectContainsPoint([node boundingBox], location);
}

@end
