//
//  JXTouchDispatcher.h
//  EOW
//
//  Created by Joe on 13-4-25.
//  Copyright (c) 2013年 Jason Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
/** this is a helper kind class which receives all touch events and disapatch to the right object according
 to their display order, just like the uikit doing,
 u dont have to add delegate with priority every single time when u want an object receiving touch event.
 it will free u from complicate touch priority in cocos2d normal way */

@interface JXTouchDispatcher : NSObject <CCTargetedTouchDelegate>
{
    id <CCTargetedTouchDelegate> _touchReceiver;
}
+ (JXTouchDispatcher *)sharedDispatcher;
/** beign receive and dispatch */
- (void)begin;
/** stop */
- (void)end;
@end

@interface CCLayer (Addition)
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
@end
