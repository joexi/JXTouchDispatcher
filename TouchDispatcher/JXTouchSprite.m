//
//  JXTouchSprite.m
//  TouchDispatcher
//
//  Created by Joe on 13-4-26.
//
//

#import "JXTouchSprite.h"

@implementation JXTouchSprite

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.color = ccGRAY;
    return YES;
}


- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.color = ccWHITE;
}
@end
