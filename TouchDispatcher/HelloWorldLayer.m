//
//  HelloWorldLayer.m
//  TouchDispatcher
//
//  Created by Joe on 13-4-25.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "JXTouchSprite.h"
// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		[[JXTouchDispatcher sharedDispatcher] begin];
        
        for (int i = 0; i <= 20; i++) {
            JXTouchSprite *sp = [JXTouchSprite spriteWithFile:@"Icon-72.png"];
            sp.position = ccp(arc4random()%320,arc4random()%480);
            int z = arc4random()%100;
            [self addChild:sp z:z];
        }
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [[JXTouchDispatcher sharedDispatcher] end];
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
