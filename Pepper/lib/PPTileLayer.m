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
        int maxWid=layer.mapSize.width,maxHei = layer.mapSize.height;
        for (int x=0;x<maxWid;x++) {
            for (int y=0;y<maxHei;y++) {
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
