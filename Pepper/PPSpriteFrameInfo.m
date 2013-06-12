//
//  PPSpriteFrameInfo.m
//  Pepper
//
//  Created by Andrew Wang on 6/7/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPSpriteFrameInfo.h"

@implementation PPSpriteFrameInfo

-(id)initWithName:(NSString *)name bounds:(CGRect)bounds originalSize:(CGSize)originalSize offset:(CGPoint)offset flipped:(BOOL)isFlipped scale:(float)scale
{
    if (self=[super init]) {
        _name = name;
        _bounds = bounds;
        _originalSize = originalSize;
        _offset = offset;
        _isFlipped = isFlipped;
        _scale = scale;
    }
    return self;
}

-(CGSize)sizeInTexture
{
    if (self.isFlipped)
        return CGSizeMake(self.bounds.size.height, self.bounds.size.width);
    else
        return self.bounds.size;
}
@end
