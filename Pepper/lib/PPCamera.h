//
//  PPCamera.h
//  Pepper
//
//  Created by Andrew Wang on 6/6/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"
#import <GLKit/GLKit.h>

/** A camera object that stores a projection matrix and modelview matrix and is used to view a certain part of the game world */
@interface PPCamera : PPStageElement

/** Access the camera frame */
@property (nonatomic) CGRect frame;

-(id)initWithViewFrame:(CGRect)frame position:(CGPoint)position;
-(GLKMatrix4)modelViewMatrix;
-(GLKMatrix4)projectionMatrix;

@end
