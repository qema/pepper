//
//  PPScene.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPScene.h"

@implementation PPScene

-(id)init
{
    if (self=[super init]) {
        _layers = [[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}

-(void)addLayer:(PPLayer *)layer
{
    [_layers addObject:layer];
}

-(void)draw
{
    for (PPLayer *layer in self.layers) {
        [layer draw];
    }
}
@end
