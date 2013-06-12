//
//  PPStage.m
//  Pepper
//
//  Created by Andrew Wang on 6/3/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPStage.h"

@implementation PPStage

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super init]) {
        _frame = frame;
        _layers = [[NSMutableArray alloc] initWithCapacity:2];
        _camera = [[PPCamera alloc] initWithViewFrame:_frame];
    }
    return self;
}

-(void)stageDidLoad
{
    // implemented in subclasses
}

-(void)addLayer:(PPLayer *)layer
{
    [_layers addObject:layer];
}

-(void)removeLayerAtIndex:(int)index
{
    [self.layers removeObjectAtIndex:index];
}

-(void)removeLayerWithTag:(int)tag
{
    for (int x=0;x<[self.layers count];x++) {
        PPLayer *layer = self.layers[x];
        if (layer.tag == tag) {
            [self removeLayerAtIndex:x];
            break;
        }
    }
}

-(void)draw
{
    for (PPLayer *layer in self.layers) {
        [layer useProjectionMatrix:[self.camera projectionMatrix]];
        [layer draw];
    }
}
@end
