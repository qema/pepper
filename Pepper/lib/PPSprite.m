//
//  PPSprite.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPSprite.h"

@implementation PPSprite

-(id)initWithFrameInfo:(PPSpriteFrameInfo *)info position:(CGPoint)position tag:(int)tag
{
    if (self=[super initWithPosition:position]) {
        _frameInfo = info;
        self.tag = tag;
    }
    return self;
}

-(id)initWithFrameInfo:(PPSpriteFrameInfo *)info position:(CGPoint)position
{
    return [self initWithFrameInfo:info position:position];
}

-(Quad)quad
{
    // this does not include the sprite's individual transformations
    PPSpriteFrameInfo *frameInfo = self.frameInfo;
    CGPoint offset = [frameInfo offset];
    CGSize rawSize = frameInfo.bounds.size;
    CGSize size = CGSizeMake(rawSize.width / frameInfo.scale, rawSize.height  / frameInfo.scale);  // adjust sprite size according to the spritesheet scale
    CGPoint pos = CGPointMake(offset.x / frameInfo.scale, offset.y / frameInfo.scale);
    Quad q;
    q.x1 = pos.x;
    q.y1 = pos.y;
    q.x2 = pos.x;
    q.y2 = pos.y+size.height;
    q.x3 = pos.x+size.width;
    q.y3 = pos.y+size.height;
    q.x4 = pos.x+size.width;
    q.y4 = pos.y;
    return q;
}

-(CGRect)bounds
{
    CGRect b;
    b.origin = self.position;
    b.size = [self size];
    return b;
}

-(CGSize)sizeBeforeTransformations
{
    CGSize size = self.frameInfo.originalSize;
    return CGSizeMake(size.width / self.frameInfo.scale, size.height / self.frameInfo.scale);
}

-(BOOL)collidesWithSprite:(PPSprite *)sprite
{
    if (CGRectIntersectsRect([self bounds], [sprite bounds]))
        return YES;
    else
        return NO;
}
@end
