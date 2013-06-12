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

-(void)useProjectionMatrix:(GLKMatrix4)projection modelViewMatrix:(GLKMatrix4)modelView
{
    self.shader.transform.projectionMatrix = projection;
    self.shader.transform.modelviewMatrix = modelView;
}

-(void)draw
{
    CGPoint anchor = [self realAnchorBeforeTransformations];
    // scale/rotate
    GLKMatrix4 modelView = GLKMatrix4Translate(self.shader.transform.modelviewMatrix, anchor.x, anchor.y, 0);
    modelView = GLKMatrix4Scale(modelView, self.scale.x, self.scale.y, 1);
    modelView = GLKMatrix4RotateZ(modelView, -GLKMathDegreesToRadians(self.rotation));
    // translate
    self.shader.transform.modelviewMatrix = GLKMatrix4Translate(modelView, -self.position.x, -self.position.y, 0);
    
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
