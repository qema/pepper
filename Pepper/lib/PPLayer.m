//
//  PPLayer.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPLayer.h"
#import "ppConstants.h"

@implementation PPLayer

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super init]) {
        _shader = [[GLKBaseEffect alloc] init];
        _frame = frame;
        self.anchor = CGPointMake(0.5,0.5);
        self.position = CGPointMake(_frame.origin.x+_frame.size.width/2, _frame.origin.y+_frame.size.height/2);
    }
    return self;
}

-(void)useProjectionMatrix:(GLKMatrix4)projection modelViewMatrix:(GLKMatrix4)modelView cameraBounds:(CGRect)bounds
{
    self.shader.transform.projectionMatrix = projection;
    self.shader.transform.modelviewMatrix = modelView;
    bounds.origin = CGPointMake(bounds.origin.x+self.position.x-self.anchor.x*self.size.width,bounds.origin.y+self.position.y-self.anchor.y*self.size.height);
    bounds.size = CGSizeMake(bounds.size.width/self.scale.x, bounds.size.height/self.scale.y);
    self.bounds = bounds;
}

-(void)draw
{
    CGPoint anchor = [self realAnchorBeforeTransformations];
    // scale/rotate
    GLKMatrix4 modelView = self.shader.transform.modelviewMatrix;
    modelView = GLKMatrix4Translate(modelView, anchor.x, anchor.y, 0);
    modelView = GLKMatrix4Scale(modelView, self.scale.x, self.scale.y, 1);
    modelView = GLKMatrix4RotateZ(modelView, -GLKMathDegreesToRadians(self.rotation));
    modelView = GLKMatrix4Translate(modelView, -self.position.x, -self.position.y, 0);
    // translate
    self.shader.transform.modelviewMatrix = modelView;
    
    [self.shader prepareToDraw];
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
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
