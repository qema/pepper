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
    [super draw];
    CGRect rect=self.bounds;
    if (!rect.size.width) {
        rect = CGRectMake(0, 0, self.tileMap.size.width, self.tileMap.size.height);
    }
    for (PPTMXTileGroup *layer in self.tileMap.layers) {
        CGPoint start=[layer worldToMapCoords:rect.origin];
        start = CGPointMake(start.x/self.scale.x, start.y/self.scale.y);
        
        int wid=ceil(rect.size.width/layer.tileSize.width/self.scale.x);
        int hei=ceil(rect.size.height/layer.tileSize.height/self.scale.y);
        int startx=start.x,starty=start.y;
        int maxWid=layer.mapSize.width,maxHei = layer.mapSize.height;
        for (int x=MAX(startx-1,0);x<MIN(startx+wid+1,maxWid);x++) {
            for (int y=MAX(starty-1,0);y<MIN(starty+hei+1,maxHei);y++) {
                int i=y*maxWid+x;
                Quad *tileQuad=[layer quads],*textureQuad=[layer textureQuads];
                CGPoint coords = CGPointMake(x, y);
                if ([layer tileAtMapCoords:coords] > 0) {
                    glEnableVertexAttribArray(GLKVertexAttribPosition);
                    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0,&tileQuad[i]);
                    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
                    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0,&textureQuad[i]);
                    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
                }
            }
        }
    }
    //[self.tileMap drawTilesInRect:rect];
}
@end
