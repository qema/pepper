//
//  PPStageElement.m
//  Pepper
//
//  Created by Andrew Wang on 6/4/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStageElement.h"

@implementation PPStageElement

-(id)initWithPosition:(CGPoint)position scale:(CGPoint)scale rotation:(float)rotation
{
    if (self=[super init]) {
        _position = position;
        _scale = scale;
        _rotation = rotation;
        _anchor = CGPointMake(0.5, 0.5);    // subclasses are supposed to set this to whatever fits the specific object
    }
    return self;
}

-(id)initWithPosition:(CGPoint)position scale:(CGPoint)scale
{
    return [self initWithPosition:position scale:scale rotation:0];
}

-(id)initWithPosition:(CGPoint)position
{
    return [self initWithPosition:position scale:CGPointMake(1, 1) rotation:0];
}

-(id)init
{
    return [self initWithPosition:CGPointZero scale:CGPointMake(1, 1) rotation:0];
}

-(CGPoint)realAnchor
{
    return CGPointMake(self.anchor.x * self.size.width, self.anchor.y * self.size.height);
}

-(CGPoint)realAnchorBeforeTransformations
{
    return CGPointMake(self.anchor.x * self.sizeBeforeTransformations.width, self.anchor.y * self.sizeBeforeTransformations.height);
}

-(CGSize)size
{
    CGSize originalSize = [self sizeBeforeTransformations];
    CGSize currentSize = CGSizeMake(originalSize.width * self.scale.x, originalSize.height * self.scale.y);
    return currentSize;
}

-(CGSize)sizeBeforeTransformations
{
    NSLog(@"forgot to implement sizeBeforeTransformations!!");
    return CGSizeZero;
}
@end
