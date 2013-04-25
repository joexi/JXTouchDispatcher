//
//  JXTouchDispatcher.m
//  EOW
//
//  Created by Joe on 13-4-25.
//  Copyright (c) 2013年 Jason Zhang. All rights reserved.
//

#import "JXTouchDispatcher.h"
@implementation CCLayer (Addition)
/** rewriting the event in cclayer */
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return NO;
}
@end

@implementation JXTouchDispatcher
JXTouchDispatcher *_sharedDispatcher;
+ (JXTouchDispatcher *)sharedDispatcher
{
    @synchronized ([self class]) {
        if (!_sharedDispatcher) {
            _sharedDispatcher = [[self alloc] init];
        }
    }
    return _sharedDispatcher;

}

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [_touchReceiver release];
    [super dealloc];
}

#pragma mark - public method
- (void)begin
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                     priority:-INT32_MAX
                                              swallowsTouches:YES];
}

- (void)end
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
}

#pragma mark - touch dispatch
- (BOOL)nodeSwallowsTouches:(CCNode *)node touch:(UITouch *)touch withEvent:(UIEvent *)event
{
    /** judge the node is conforms to touchprotocol or not
     @exception problem here is CCLayer receive the touch event and throw exception we need wo modify class cclayer
     or we need a category just like top of this page
     */
    if ([node conformsToProtocol:@protocol(CCTargetedTouchDelegate)]) {
        id <CCTargetedTouchDelegate> touchNode = (id <CCTargetedTouchDelegate>)node;
        /** 有节点接收 */
        if ([touchNode ccTouchBegan:touch withEvent:event]) {
            [_touchReceiver release];
            _touchReceiver = [touchNode retain];
            return YES;
        }
        return NO;
    }
    else {
    }
    return NO;
}

- (BOOL)touchInNode:(CCNode *)node touch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL swallowsTouches = NO;
    NSMutableArray *disAry = [NSMutableArray array];
    /** disorder the childern */
    for (CCNode *child in node.children) {
        [disAry insertObject:child atIndex:0];
    }
    for (CCNode *child in disAry) {
        /** child first */
        if ([self touchInNode:child touch:touch withEvent:event]) {
            swallowsTouches = YES;
            break;
        } 
    }
    /** no child match then check node itself */
    if (!swallowsTouches) {
        if ([self nodeSwallowsTouches:node touch:touch withEvent:event]) {
            swallowsTouches = YES;
        }
    }
    return swallowsTouches;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCNode *node = [CCDirector sharedDirector].runningScene;
    return [self touchInNode:node touch:touch withEvent:event];
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([_touchReceiver respondsToSelector:@selector(ccTouchMoved:withEvent:)]) {
        [_touchReceiver ccTouchMoved:touch withEvent:event];
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([_touchReceiver respondsToSelector:@selector(ccTouchEnded:withEvent:)]) {
        [_touchReceiver ccTouchEnded:touch withEvent:event];
    }
    [_touchReceiver release];
    _touchReceiver = nil;
}

@end
