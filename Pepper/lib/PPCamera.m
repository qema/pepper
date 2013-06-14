//
//  PPCamera.m
//  Pepper
//
//  Created by Andrew Wang on 6/6/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPCamera.h"
#import "ppConstants.h"

@implementation PPCamera

-(id)initWithViewFrame:(CGRect)frame position:(CGPoint)position
{
    if (self=[super initWithPosition:position]) {
        _frame = frame;
        
        self.anchor = CGPointMake(0.5,0.5);
    }
    return self;
}

-(CGRect)bounds
{
    return CGRectMake(self.position.x-self.anchor.x*self.size.width, self.position.y-self.anchor.y*self.size.height, self.size.width, self.size.height);
}

-(GLKMatrix4)modelViewMatrix
{
    CGPoint anchor = [self realAnchorBeforeTransformations];
    GLKMatrix4 matrix = GLKMatrix4Identity;
    // scale/rotate around anchor
    matrix = GLKMatrix4Translate(matrix, anchor.x, anchor.y, 0);
    matrix = GLKMatrix4Scale(matrix, self.scale.x, self.scale.y, 1);
    matrix = GLKMatrix4RotateZ(matrix, -GLKMathDegreesToRadians(self.rotation));
    // translate
    matrix = GLKMatrix4Translate(matrix, -self.position.x, -self.position.y, 0);
    return matrix;
}

-(GLKMatrix4)projectionMatrix
{
    return GLKMatrix4MakeOrtho(self.frame.origin.x, self.frame.origin.x+self.frame.size.width, self.frame.origin.y+self.frame.size.height, self.frame.origin.y, -1, 1);
}

-(CGSize)size
{
    return CGSizeMake(self.frame.size.width / self.scale.x, self.frame.size.height / self.scale.y);
}

-(CGSize)sizeBeforeTransformations
{
    return self.frame.size;
}
@end
