//
//  PPTileLayer.m
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTileLayer.h"
#import "PPTMXTileGroup.h"

@implementation PPTileLayer

-(id)initWithFrame:(CGRect)frame tileMap:(PPTileMap *)tileMap
{
    if (self=[super initWithFrame:frame]) {
        _tileMap = tileMap;
        self.shader.texture2d0.name = tileMap.tileset.texture.name;
        self.shader.texture2d0.enabled = YES;
    }
    return self;
}

-(void)draw
{
    [super draw]; //CGRectMake(self.position.x-self.anchor.x*size.width, self.position.y-self.anchor.y*size.height, size.width, size.height);
    for (PPTMXTileGroup *layer in self.tileMap.layers) {
        [layer draw];
    }
    //[self.tileMap drawTilesInRect:rect];
}
@end
