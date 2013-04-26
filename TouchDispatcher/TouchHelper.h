//
//  TouchHelper.h
//  EOW
//
//  Created by darren on 13-2-27.
//  Copyright (c) 2013年 Jason Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface TouchHelper : NSObject

CGPoint TouchLocation(UITouch *touch, CCNode *node);
BOOL IsTouchInside(UITouch *touch, CCNode *node);
  
@end
