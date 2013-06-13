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
        _camera = [[PPCamera alloc] initWithViewFrame:_frame position:CGPointMake(_frame.origin.x+_frame.size.width/2, _frame.origin.y+_frame.size.height/2)];
        _animationController = [[PPAnimationController alloc] init];
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

-(PPLayer *)layerWithTag:(int)tag
{
    for (PPLayer *layer in self.layers) {
        if (layer.tag == tag)
            return layer;
    }
    return nil;
}

-(PPLayer *)layerWithIndex:(int)index
{
    return self.layers[index];
}

-(void)update:(float)delta
{
    [self.animationController update:delta];
}

-(void)draw
{
    glClear(GL_COLOR_BUFFER_BIT);
    for (PPLayer *layer in self.layers) {
        [layer useProjectionMatrix:[self.camera projectionMatrix] modelViewMatrix:[self.camera modelViewMatrix]];
        [layer draw];
    }
}
@end
