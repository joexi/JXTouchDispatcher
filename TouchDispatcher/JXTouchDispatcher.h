//
//  JXTouchDispatcher.h
//  EOW
//
//  Created by Joe on 13-4-25.
//  Copyright (c) 2013年 Jason Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
/** this is a class is a touch helper to receive all the touch event and disapatch to the right object according
 to their display orther, just like the uikit doing,
 u dont have to adddelegate with priority every sign node which need touch event
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
