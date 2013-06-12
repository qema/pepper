//
//  PPFrameInfo.m
//  Pepper
//
//  Created by Andrew Wang on 6/7/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPFrameInfo.h"

@implementation PPFrameInfo

-(id)initWithName:(NSString *)name bounds:(CGRect)bounds originalBounds:(CGRect)originalBounds flipped:(BOOL)isFlipped
{
    if (self=[super init]) {
        _name = name;
        _bounds = bounds;
        _originalBounds = originalBounds;
        _offset = CGPointMake(bounds.origin.x-originalBounds.origin.x, bounds.origin.y-originalBounds.origin.y);
        _isFlipped = isFlipped;
    }
    return self;
}

-(CGPoint)adjustedOffset
{
    return self.offset;
}

-(CGSize)adjustSize:(CGSize)size
{
    if (self.isFlipped)
        return CGSizeMake(size.height, size.width);
    else
        return size;
}

-(CGSize)adjustedSize
{
    return [self adjustSize:self.bounds.size];
}

-(CGSize)adjustedOriginalSize
{
    return [self adjustSize:self.originalBounds.size];
}
@end
