//
//  PPTextureAtlas.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTextureAtlas.h"
#import "ppConstants.h"

@implementation PPTextureAtlas

-(id)initWithFile:(NSString *)filename scale:(float)scale
{
    if (self=[super init]) {
        _frames = [[NSMutableDictionary alloc] initWithCapacity:PP_TEXTURE_ATLAS_INITIAL_CAPACITY];
        _scale = scale;
    }
    return self;
}

-(CGRect)rectForFrame:(NSString *)name
{
    // subclass determines exactly how
    return CGRectZero;
}

-(Quad)quadForFrame:(NSString *)name
{
    // subclass determines exactly how
    Quad q;
    return q;
}

-(Quad)normalizedQuadForFrame:(NSString *)name
{
    Quad q;
    return q;
}
@end
