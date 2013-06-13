//
//  PPNode.h
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Basic Pepper object which is subclassed into all other Pepper objects */
@interface PPObject : NSObject

/** The object's identifier */
@property (nonatomic) int tag;

/** For updatable objects, called on every frame; object updates its attributes */
-(void)update:(float)delta;
@end
