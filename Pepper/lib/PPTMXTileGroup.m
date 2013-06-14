//
//  PPTMXTileGroup.m
//  Pepper
//
//  Created by Andrew Wang on 6/13/13.
//  Copyright (c) 2013 Andrew Wang. All rights reserved.
//

#import "PPTMXTileGroup.h"
#import "PPFileUtils.h"
#import "ppMath.h"
#import "PPTileset.h"

@implementation PPTMXTileGroup

-(id)initWithDictionary:(NSDictionary *)dict tileset:(PPTileset *)tileset
{
    if (self=[super init]) {
        if (CFByteOrderGetCurrent() == CFByteOrderBigEndian) shouldSwapBytesToCorrectEndianness = YES;
        int wid = [[dict objectForKey:@"width"] intValue];
        int hei = [[dict objectForKey:@"height"] intValue];
        self.mapSize = CGSizeMake(wid, hei);
        NSData *dat = [dict objectForKey:@"data"];
        mapData = (unsigned int *)[dat bytes];
        
        _tileset = tileset;
        _tileSize = CGSizeMake(self.tileset.tileSize.width/self.tileset.scale,self.tileset.tileSize.height/self.tileset.scale);
        
        numberOfQuads = (self.mapSize.width)*(self.mapSize.height);
        tileQuad = malloc(sizeof(Quad)*numberOfQuads);
        textureQuad = malloc(sizeof(Quad)*numberOfQuads);
        
        wid=self.mapSize.width;
        hei=self.mapSize.height;
        for (int x=0;x<wid;x++) {
            for (int y=0;y<hei;y++) {
                int i = y*wid+x;
                CGPoint coords = CGPointMake(x, y);
                tileQuad[i] = [self quadForTileAtMapCoords:coords];
                unsigned int tile = [self tileAtMapCoords:coords];
                if (tile > 0) {
                    textureQuad[i] = [self.tileset normalizedQuadForTile:tile];
                }
                //quadIndex[i*2] = i*2;
                //quadIndex[i*2+1] =
            }
        }
    }
    return self;
}

-(CGPoint)worldToMapCoords:(CGPoint)coords
{
    return CGPointMake(coords.x/self.tileSize.width, coords.y/self.tileSize.height);
}

-(Quad)quadForTileAtMapCoords:(CGPoint)coords
{
    int x=coords.x,y=coords.y;
    int tileWid=self.tileSize.width,tileHei=self.tileSize.height;
    int realx=x*tileWid,realy=y*tileHei;
    Quad q;
    q.x1 = realx; q.y1 = realy;
    q.x2 = realx; q.y2 = realy+tileHei;
    q.x3 = realx+tileWid; q.y3 = realy+tileHei;
    q.x4 = realx+tileWid; q.y4 = realy;
    return q;
}

-(unsigned int)tileAtMapCoords:(CGPoint)coords
{
    int x=coords.x,y=coords.y;
    unsigned int dat = mapData[y*(int)self.mapSize.width+x];
    if (shouldSwapBytesToCorrectEndianness) dat = CFSwapInt32(dat);
    return dat;
}

-(void)draw
{
    int maxWid=self.mapSize.width,maxHei = self.mapSize.height;
    for (int x=0;x<maxWid;x++) {
        for (int y=0;y<maxHei;y++) {
            int i=y*maxWid+x;
            CGPoint coords = CGPointMake(x, y);
            if ([self tileAtMapCoords:coords] > 0) {
                glEnableVertexAttribArray(GLKVertexAttribPosition);
                glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0,&tileQuad[i]);
                glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
                glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0,&textureQuad[i]);
                glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
            }
        }
    }
}

-(Quad *)quads
{
    return tileQuad;
}

-(CGSize)sizeBeforeTransformations
{
    return CGSizeMake(self.mapSize.width*self.tileSize.width,self.mapSize.height*self.tileSize.height);
}

-(void)dealloc
{
    free(tileQuad);
    free(textureQuad);
}
@end
